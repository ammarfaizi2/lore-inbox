Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751783AbWCUPhN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751783AbWCUPhN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 10:37:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751780AbWCUPhN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 10:37:13 -0500
Received: from ookhoi.xs4all.nl ([213.84.114.66]:43143 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S1751778AbWCUPhK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 10:37:10 -0500
Date: Tue, 21 Mar 2006 16:37:08 +0100
From: Sander <sander@humilis.net>
To: Mark Lord <liml@rtr.ca>
Cc: sander@humilis.net, Mark Lord <lkml@rtr.ca>, Jeff Garzik <jeff@garzik.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.6.xx: sata_mv: another critical fix
Message-ID: <20060321153708.GA11703@favonius>
Reply-To: sander@humilis.net
References: <441F4F95.4070203@garzik.org> <200603210000.36552.lkml@rtr.ca> <20060321121354.GB24977@favonius> <442004E4.7010002@rtr.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <442004E4.7010002@rtr.ca>
X-Uptime: 16:22:50 up 18 days, 20:33, 27 users,  load average: 4.06, 3.39, 2.83
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote (ao):
> Sander wrote:
> >2.6.16 with this patch and your former patch applied, crashes during
> >stressing a raid5 connected to a MV88SX6081.
> >
> >2.6.16-rc6 crashes too.
> >
> >2.6.16-rc6-mm2 is rock solid wrt sata_mv.
> >
> >I get no output of the crash on netconsole. Would it help if I get the
> >output of the crash (if any)? In that case I'll connect a screen and see
> >what it produces.
> 
> Yes, most helpful, please.
> Even a digital camera snapshot of the oops would be handy to see.

Euh, it seems there is no output on the screen at all at during the
crash..

The system just freezes. Rock solid. No sysrq, no ctrl-alt-del, nothing.

I'm sorry.

Would setting some debug options help? I currently have:

CONFIG_PRINTK_TIME=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_KERNEL=y
CONFIG_LOG_BUF_SHIFT=17
CONFIG_DETECT_SOFTLOCKUP=y
# CONFIG_SCHEDSTATS is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_DEBUG_KOBJECT is not set
# CONFIG_DEBUG_INFO is not set
# CONFIG_DEBUG_FS is not set
# CONFIG_DEBUG_VM is not set
# CONFIG_FRAME_POINTER is not set
# CONFIG_FORCED_INLINING is not set
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_DEBUG_RODATA is not set
# CONFIG_IOMMU_DEBUG is not set


-- 
Humilis IT Services and Solutions
http://www.humilis.net
