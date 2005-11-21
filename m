Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932119AbVKUBHx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119AbVKUBHx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 20:07:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932146AbVKUBHx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 20:07:53 -0500
Received: from vms042pub.verizon.net ([206.46.252.42]:19914 "EHLO
	vms042pub.verizon.net") by vger.kernel.org with ESMTP
	id S932119AbVKUBHw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 20:07:52 -0500
Date: Sun, 20 Nov 2005 20:07:44 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Linux 2.6.15-rc2
In-reply-to: <20051121001548.GA6964@linuxtv.org>
To: Johannes Stezenbach <js@linuxtv.org>, linux-kernel@vger.kernel.org
Message-id: <200511202007.44600.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <Pine.LNX.4.64.0511191934210.8552@g5.osdl.org>
 <200511200018.11791.gene.heskett@verizon.net>
 <20051121001548.GA6964@linuxtv.org>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 20 November 2005 19:15, Johannes Stezenbach wrote:
>On Sun, Nov 20, 2005 Gene Heskett wrote:
>> First breakage report, tvtime, blue screen no audio.  Trying slightly
>> different .config for next build.
>
>Probably v4l breakage due to VM changes. For me xawtv overlay works,
>grabdisplay doesn't (with different cards). This was reported before.
>
>> My tuner (OR51132) seems to be
>> permanently selected in an xconfig screen.  Dunno if thats good or
>> bad ATM.
>
>Works for me in menuconfig. You probably have
>CONFIG_VIDEO_SAA7134_DVB_ALL_FRONTENDS selected?

Nope. its off.  Or lets put it this way:
# grep SAA7134 .config
# CONFIG_VIDEO_SAA7134 is not set

The longer string above doesn't exist in my .config, made from the
2.6.14.2 .config with a make oldconfig.  Is this a bug in the patchfile?

>Johannes
>
>PS: don't trim Cc: on lkml

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.36% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.

