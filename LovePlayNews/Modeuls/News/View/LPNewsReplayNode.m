//
//  LPNewsReplayNode.m
//  LovePlayNews
//
//  Created by tany on 16/8/19.
//  Copyright © 2016年 tany. All rights reserved.
//

#import "LPNewsReplayNode.h"

@interface LPNewsReplayNode ()

// Data
@property (nonatomic,strong) LPNewsCommonItem *item;
@property (nonatomic,assign) NSInteger floor;

// UI
@property (nonatomic, strong) ASTextNode *nameNode;
@property (nonatomic, strong) ASTextNode *floorNode;
@property (nonatomic, strong) ASTextNode *contentNode;
@property (nonatomic, strong) ASDisplayNode *underLineNode;

@end

@implementation LPNewsReplayNode

- (instancetype)initWithCommentItem:(LPNewsCommonItem *)item floor:(NSInteger)floor;
{
    if (self = [super init]) {
        _item = item;
        _floor = floor;
        
        [self addNameNode];
        
        [self addFloorNode];
        
        [self addContentNode];
        
        [self addUnderLineNode];
    }
    return self;
}

- (void)addNameNode
{
    ASTextNode *nameNode = [[ASTextNode alloc]init];
    nameNode.layerBacked = YES;
    nameNode.maximumNumberOfLines = 1;
    NSDictionary *attrs = @{ NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:11.0f] ,NSForegroundColorAttributeName: RGB_255(138, 138, 138)};
    nameNode.attributedText = [[NSAttributedString alloc]initWithString:_item.user.nickname?_item.user.nickname : @"火星网友" attributes:attrs];
    [self addSubnode:nameNode];
    _nameNode = nameNode;
}

- (void)addFloorNode
{
    ASTextNode *floorNode = [[ASTextNode alloc]init];
    floorNode.layerBacked = YES;
    floorNode.maximumNumberOfLines = 1;
    NSDictionary *attrs = @{ NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:11.0f] ,NSForegroundColorAttributeName: RGB_255(64, 64, 61)};
    floorNode.attributedText = [[NSAttributedString alloc]initWithString:@(_floor).stringValue attributes:attrs];
    [self addSubnode:floorNode];
    _floorNode = floorNode;
}

- (void)addContentNode
{
    ASTextNode *contentNode = [[ASTextNode alloc]init];
    contentNode.layerBacked = YES;
    contentNode.maximumNumberOfLines = 0;
    NSDictionary *attrs = @{ NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:15.0f] ,NSForegroundColorAttributeName: RGB_255(88, 88, 88)};
    contentNode.attributedText = [[NSAttributedString alloc]initWithString:_item.content attributes:attrs];
    [self addSubnode:contentNode];
    _contentNode = contentNode;
}

- (void)addUnderLineNode
{
    ASDisplayNode *underLineNode = [[ASDisplayNode alloc]init];
    underLineNode.layerBacked = YES;
    underLineNode.backgroundColor = RGB_255(218, 218, 218);
    [self addSubnode:underLineNode];
    _underLineNode = underLineNode;
}

- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize
{
    _nameNode.flexGrow = YES;
    _contentNode.flexShrink = YES;
    
    ASStackLayoutSpec *horTopStackLayout = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal spacing:0 justifyContent:ASStackLayoutJustifyContentSpaceBetween alignItems:ASStackLayoutAlignItemsStart children:@[_nameNode,_floorNode]];
    horTopStackLayout.flexGrow = YES;

    ASStackLayoutSpec *verTopStackLayout = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical spacing:12 justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsStretch children:@[horTopStackLayout,_contentNode]];
    verTopStackLayout.flexGrow = YES;
    verTopStackLayout.flexShrink  = YES;
    
    ASInsetLayoutSpec *insetLayout = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(8, 8, 8, 8) child:verTopStackLayout];
    _underLineNode.preferredFrameSize = CGSizeMake(constrainedSize.max.width, 0.5);
    ASStackLayoutSpec *verStackLayout = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical spacing:0 justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsStretch children:@[insetLayout,_underLineNode]];
    return verStackLayout;
}

@end