Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932267AbVHKVyF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932267AbVHKVyF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 17:54:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932282AbVHKVyF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 17:54:05 -0400
Received: from vms046pub.verizon.net ([206.46.252.46]:21493 "EHLO
	vms046pub.verizon.net") by vger.kernel.org with ESMTP
	id S932267AbVHKVyE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 17:54:04 -0400
Date: Thu, 11 Aug 2005 17:53:16 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: cx88 teletext not yet implemented -was- Re: Linux-2.6.13-rc6:
 aic7xxx testers please..
In-reply-to: <42FB70EE.6010907@m1k.net>
To: linux-kernel@vger.kernel.org, mkrufky@m1k.net
Cc: Linux and Kernel Video <video4linux-list@redhat.com>
Message-id: <200508111753.16970.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <Pine.LNX.4.58.0508071136020.3258@g5.osdl.org>
 <200508111051.01067.gene.heskett@verizon.net> <42FB70EE.6010907@m1k.net>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 11 August 2005 11:38, Michael Krufky wrote:
>Gene Heskett wrote:
>>I can also report that teletext decoding has ceased to work
>>here.  But I'm not sure what kernel version killed it.  Currently
>>running 2.6.13-rc6.  But my card is cx88 based, a pcHDTV-3000.  But
>>attempting to switch it on/off doesn't seem to generate any output
>>indicating it failed, it just Doesn't Work(TM)
>
>Gene-
>
>By teletext, I assume you are referring to closed captions.  Are you
>sure that closed captions EVER worked for you on a cx88-based card?
>AFAIK, this feature has not yet been implemented.  I am not at home
> now, so I cannot try it, however, IIRC, closed captions is
> implemented in bttv, and not yet in cx88.
>
>This is a v4l issue, not a dvb issue, however, it is NOT an issue. 
> This is not a regression, because the feature has not yet been
> implemented.
>
>Gene, if I am wrong, (this is possible) then please provide the last
>kernel version that had this feature correctly implemented.  I don't
>think that I am wrong, though.  Please investigate this and confirm
> that this is an actual regression or not.
>
>Cheers,

Its entirely possible that the last time I saw it work was in fact on
a bt878 card, one I junked because the tuner was apparently damaged,
needing something like 10,000 u-v to give a useable picture.  I
assumed (theres that word again) that the CC decoding was seperately
handled by inspecting the output video data stream regardless of its
source.  Mentally to me, that then would have been a tvtime function
and not a cx88 function.  It makes far more sense to me anyway.

Sorry for the false alarm.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.35% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.

