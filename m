Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310201AbSDCKHl>; Wed, 3 Apr 2002 05:07:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310206AbSDCKHb>; Wed, 3 Apr 2002 05:07:31 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:50961 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S310201AbSDCKH1>; Wed, 3 Apr 2002 05:07:27 -0500
Date: Wed, 3 Apr 2002 05:05:10 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Jauder Ho <jauderho@carumba.com>
cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Ext2 vs. ext3 recovery after crash
In-Reply-To: <Pine.LNX.4.44.0204022144310.21070-100000@twinlark.arctic.org>
Message-ID: <Pine.LNX.3.96.1020403045517.11049B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Apr 2002, Jauder Ho wrote:

> 
> Bill, you do know that it will do a full fsck every x mounts right?
> 
> [root@turtle /lib]# tune2fs -l /dev/hda6 | grep -i mount
> Last mounted on:          <not available>
> Last mount time:          Sun Mar  3 11:34:50 2002
> Mount count:              1
> Maximum mount count:      20

I assure you I have not set my max-mount down to three or four, and since
it crashes several times a day you can forget forced by date, too.

C'mon, I've been doing this stuff since the MCC four floppy distribution
was king, I've seen a max mount counts message before. This is purely a
case of the *first* mount message being EXT2 instead of EXT3, as if the
journal wasn't detected in the first place. However, the r/w mount is
always ext3 per fstab.

I never get close to max-mounts, this problem is in the 20-30% of the time
range. No one knows why a lot of the Dells hang on X-logout, guess this is
one more thing it does poorly.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

