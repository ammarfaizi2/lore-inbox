Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291453AbSBMJ0x>; Wed, 13 Feb 2002 04:26:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291470AbSBMJ0o>; Wed, 13 Feb 2002 04:26:44 -0500
Received: from mail.cogenit.fr ([195.68.53.173]:50101 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S291453AbSBMJ0Y>;
	Wed, 13 Feb 2002 04:26:24 -0500
Date: Wed, 13 Feb 2002 10:24:16 +0100
From: Francois Romieu <romieu@cogenit.fr>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Quick question on Software RAID support.
Message-ID: <20020213102416.A15790@fafner.intra.cogenit.fr>
In-Reply-To: <3C69C5A6.4020409@reviewboard.com> <Pine.LNX.3.96.1020212230521.8017E-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.3.96.1020212230521.8017E-100000@gatekeeper.tmr.com>; from davidsen@tmr.com on Tue, Feb 12, 2002 at 11:10:55PM -0500
X-Organisation: Marie's fan club - II
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

Bill Davidsen <davidsen@tmr.com> :
[...]
> >From personal experience software RAID is quite fast, and very reliable
> regarding failures while running. If a disk fails the system drops back to
> recovery, and after a new drive is added and `raidhotadd' is run it is
> rebuilt.
> 
> The dark side of the force is that is a drive fails on boot, I have had

(raid1)
- planned reboot;
- spontaneous fsck;
- rarely accessed part of a disk isn't happy
- is it normal for an scsi error to take more than 10 minutes ?
- LRB
- removal of faulty drive;
- reboot;
- spontaneous fsck;
-> now there's a nice fs with a 3 months old content.

Interesting experience for an otherwise usual sunday.

Btw, this log entry is a bit terse:

http://www.kernel.org/pub/linux/kernel/v2.4/testing/patch-2.4.18.log
[...]
- Fix rare data loss case with RAID-1

-- 
Ueimor
