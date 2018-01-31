//
//  InfoCellNode.m
//  ASDKDemo
//
//  Created by Dee on 2017/8/17.
//  Copyright © 2017年 Dee. All rights reserved.
//

#import "InfoCellNode.h"
#import "UserNode.h"

@interface InfoCellNode ()

@property(nonatomic, strong) VideoModel *video;
@property (strong, nonatomic) ASNetworkImageNode *postImageNode;
@property (strong, nonatomic) ASTextNode *titleTextNode;
@property (strong, nonatomic) ASTextNode *subTitleTextNode;
@property(nonatomic, strong) ASNetworkImageNode *userImageNode;
@property(nonatomic, strong) UserNode *userNode;

@end

@implementation InfoCellNode

-(instancetype)initWithModel:(VideoModel *)video{
    if (self = [super init]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _video = video;
        
        _postImageNode = [ASNetworkImageNode createWithURLStr:_video.cover];
        [self addSubnode:_postImageNode];
        
        _postImageNode.imageModificationBlock = [_postImageNode imageMaskScreenBlock];
        
        _titleTextNode = [ASTextNode createWithAttr:[NSAttributedString attributedStringForDescription:_video.title]];
        [self addSubnode:_titleTextNode];
        
        _userNode = [[UserNode alloc]initWithModel:_video.user_info];
        [self addSubnode:_userNode];
        
    }
    return self;
}

-(ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize{
    
    ASRatioLayoutSpec *postImageRatioSpec = [ASRatioLayoutSpec ratioLayoutSpecWithRatio:9.0/16.0 child:_postImageNode];
    
    ASInsetLayoutSpec *titleInsetSpec = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(8, 8, 8, 8) child:_titleTextNode];
    
    ASRelativeLayoutSpec *relativeSpec = [ASRelativeLayoutSpec relativePositionLayoutSpecWithHorizontalPosition:ASRelativeLayoutSpecPositionStart verticalPosition:ASRelativeLayoutSpecPositionEnd sizingOption:ASRelativeLayoutSpecSizingOptionDefault child:titleInsetSpec];
    ASOverlayLayoutSpec *nameOverSpec = [ASOverlayLayoutSpec overlayLayoutSpecWithChild:postImageRatioSpec overlay:relativeSpec];
    
    _userImageNode.style.preferredSize = CGSizeMake(25, 25);
    
    ASStackLayoutSpec *stackSpec = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical spacing:8 justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsStretch children:@[nameOverSpec, _userNode]];
    
    ASInsetLayoutSpec *insetSpec = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(16, 16, 0, 16) child:stackSpec];
    
    return insetSpec;
}

@end
