Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318215AbSIOTgg>; Sun, 15 Sep 2002 15:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318230AbSIOTgf>; Sun, 15 Sep 2002 15:36:35 -0400
Received: from 217-13-4-9.dd.nextgentel.com ([217.13.4.9]:39630 "HELO
	mail.broadpark.no") by vger.kernel.org with SMTP id <S318215AbSIOTgf>;
	Sun, 15 Sep 2002 15:36:35 -0400
Message-ID: <3D84E27A.D1BFA4E3@broadpark.no>
Date: Sun, 15 Sep 2002 21:41:46 +0200
From: Helge Hafting <helge.hafting@broadpark.no>
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.5.34bk6 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: "Cress, Andrew R" <andrew.r.cress@intel.com>
Cc: linux-kernel@vger.kernel.org, neilb@cse.unsw.edu.au
Subject: Re: 2.5.34 unable to mount root FIXED in bk6
References: <A5974D8E5F98D511BB910002A50A66470580D1AE@hdsmsx103.hd.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I use modules only for seldom-used stuff
like floppy & scanner.  The RAID is compiled-in.
It works in 2.5.33, and works again in 2.5.34-bk6,
where some raid fixes related to partitioning problems
went in.

Helge Hafting


"Cress, Andrew R" wrote:
> 
> Helge,
> 
> You've probably already checked this, but is  CONFIG_BLK_DEV_MD=y ?
> It won't work if you have a root mirror and this is a configured as a
> module.
> 
> Andy Cress
> 
> -----Original Message-----
> From: Helge Hafting [mailto:helge.hafting@broadpark.no]
> Sent: Thursday, September 12, 2002 1:24 PM
> To: Linux Kernel Mailing List
> Subject: 2.5.34 unable to mount root fs on 09:00 (smp,raid1,devfs,scsi)
> 
> 2.5.33 works. 2.5.34 and 2.5.34-bk3 won't mount the
> root fs.  The root fs is on /dev/md/1, composed
> of 2 partitions on different scsi disks.
> 
> The RAID-1 setup is autodetected, so it don't look
> like a hardware or scsi problem.  Everything seems normal
> until the root mount fail and the kernel hangs.  Not
> even sysrq works after that.
> 
> Helge Hafting
> -
