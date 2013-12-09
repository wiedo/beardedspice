//
//  YoutubeHandler.m
//  WebMediaController
//
//  Created by Tyler Rhodes on 12/8/13.
//  Copyright (c) 2013 Tyler Rhodes / Jose Falcon. All rights reserved.
//

#import "YoutubeHandler.h"

@implementation YoutubeHandler

+ (id)initWithTab:(ChromeTab *)tab
{
    YoutubeHandler *out = [[YoutubeHandler alloc] init];
    [tab retain];
    [out setTab:tab];
    return out;
}

- (BOOL) isPlaying
{
    NSNumber *status = [[super tab] executeJavascript:@"var i = 0, out = 0, vs = document.querySelectorAll('#movie_player'); for (i = 0; i < vs.length; i++) { out = vs[i].getPlayerState();break; }; out"];
    if (status) {
        NSLog(@"Status is %@", status);
        return [status intValue] == 1;
    } else {
        NSLog(@"Status is not defined!");
        return NO;
    }
}

- (void)toggle
{
    NSLog(@"Toggle on %@", [super tab]);
    if ([self isPlaying]) {
        [self pause];
    } else {
        [self play];
    }
}

- (void) play
{
    [[super tab] executeJavascript:@"var i = 0, vs = document.querySelectorAll('#movie_player'); for (i = 0; i < vs.length; i++) { vs[i].playVideo() }"];
}
- (void) pause
{
    [[super tab] executeJavascript:@"var i = 0, vs = document.querySelectorAll('#movie_player'); for (i = 0; i < vs.length; i++) { vs[i].pauseVideo() }"];
}

- (void)previous
{
    NSLog(@"Previous on %@", [super tab]);
}

-(void)next
{
    NSLog(@"Next on %@", [super tab]);
}

+(BOOL) isValidFor:(NSString *)url
{
    return [url isCaseInsensitiveLike:@"*youtube.com/watch*"];
}

@end
