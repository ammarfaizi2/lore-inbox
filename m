Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265812AbUAKJWI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 04:22:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265816AbUAKJWI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 04:22:08 -0500
Received: from out007pub.verizon.net ([206.46.170.107]:63654 "EHLO
	out007.verizon.net") by vger.kernel.org with ESMTP id S265812AbUAKJWD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 04:22:03 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None that appears to be detectable by casual observers
To: "Pablo E. Limon Garcia Viesca" <plimon@intercable.net>
Subject: Re: GIVEUP [bootup kernel panic 2.6.x] no root partition detected?
Date: Sun, 11 Jan 2004 04:22:02 -0500
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
References: <40005E9C.3030309@intercable.net> <200401110010.09341.gene.heskett@verizon.net> <4000DE12.7020100@intercable.net>
In-Reply-To: <4000DE12.7020100@intercable.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401110422.02439.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out007.verizon.net from [151.205.56.190] at Sun, 11 Jan 2004 03:22:01 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 11 January 2004 00:24, Pablo E. Limon Garcia Viesca wrote:
>-----BEGIN PGP SIGNED MESSAGE-----
>Hash: SHA1
>
>Thanks for your answer, I use LILO but that root is refering to
>presisely the root partition, in my case it its /dev/hda5...
>It is well configured in lilo, I can enter with kernel 2.4... but
> not with 2.6...
>if you want to know, the exact Kernel error at the begining is:
>
>VFS: Cannot open root device "305" or hda5
>Please append a correct "root=" boot option
>Kernel panic: VFS: Unable to mount root fs on hda5
>
>but I know hda5 is the partition, maybe there has something to be
> with the fact that the root partition is logical, in the extended
> partiton... I mean is not a primary partition... could this be
> true???

Thats an excellent question, unforch I don't know the definitive 
answer.  But to put that fear to rest, my / partition is on 
/dev/hda7, and /root is on /dev/hda5.  I would think that if thats a 
problem, I would have seen it, and I've been setup that way for the 
last 6 months or so.

That really shouldn't make any more difference than putting /usr on a 
seperate drive does, which is no diff, at least here.

Sorry Pablo, but I'm fresh out of ideas.  But there may be enough 
clues here that someone else can chime in.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty: soap,
ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.22% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

