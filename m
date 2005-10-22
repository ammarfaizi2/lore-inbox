Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751292AbVJVXgk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292AbVJVXgk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Oct 2005 19:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbVJVXgk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Oct 2005 19:36:40 -0400
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:13573 "EHLO
	anchor-post-34.mail.demon.net") by vger.kernel.org with ESMTP
	id S1751292AbVJVXgj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Oct 2005 19:36:39 -0400
From: Felix Oxley <lkml@oxley.org>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.14-rc5-rt1
Date: Sun, 23 Oct 2005 00:23:39 +0100
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>,
       Fernando Lopez-Lezcano <nando@ccrma.stanford.edu>
References: <20051017160536.GA2107@elte.hu> <200510211118.18363.lkml@oxley.org> <200510211126.38200.lkml@oxley.org>
In-Reply-To: <200510211126.38200.lkml@oxley.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200510230023.41494.lkml@oxley.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 21 October 2005 11:26, Felix Oxley wrote:

> I will try again with -rc5-rt3. :-)
> 

-rc5-rt3 builds fine.

I got these messages while doing 'make allmodconfig':

  CC [M]  drivers/pcmcia/i82365.o
  CC [M]  drivers/pcmcia/i82092.o
  CC [M]  drivers/pcmcia/tcic.o
  CC [M]  drivers/scsi/NCR_Q720.o
In file included from drivers/scsi/ncr53c8xx.h:47,
                 from drivers/scsi/NCR_Q720.c:21:
drivers/scsi/sym53c8xx_defs.h:292:1: warning: "ktime_add" redefined
In file included from include/linux/ktimer.h:19,
                 from include/linux/sched.h:264,
                 from include/linux/module.h:10,
                 from include/linux/device.h:20,
                 from include/linux/genhd.h:15,
                 from include/linux/blkdev.h:6,
                 from drivers/scsi/NCR_Q720.c:8:
include/linux/ktime.h:110:1: warning: this is the location of the previous definition
In file included from drivers/scsi/ncr53c8xx.h:47,
                 from drivers/scsi/NCR_Q720.c:21:
drivers/scsi/sym53c8xx_defs.h:293:1: warning: "ktime_sub" redefined
In file included from include/linux/ktimer.h:19,
                 from include/linux/sched.h:264,
                 from include/linux/module.h:10,
                 from include/linux/device.h:20,
                 from include/linux/genhd.h:15,
                 from include/linux/blkdev.h:6,
                 from drivers/scsi/NCR_Q720.c:8:
include/linux/ktime.h:107:1: warning: this is the location of the previous definition
  CC [M]  drivers/scsi/ncr53c8xx.o
In file included from drivers/scsi/ncr53c8xx.h:47,
                 from drivers/scsi/ncr53c8xx.c:129:
drivers/scsi/sym53c8xx_defs.h:292:1: warning: "ktime_add" redefined
In file included from include/linux/ktimer.h:19,
                 from include/linux/sched.h:264,
                 from include/linux/module.h:10,
                 from include/linux/device.h:20,
                 from include/linux/genhd.h:15,
                 from include/linux/blkdev.h:6,
                 from drivers/scsi/ncr53c8xx.c:100:
include/linux/ktime.h:110:1: warning: this is the location of the previous definition
In file included from drivers/scsi/ncr53c8xx.h:47,
                 from drivers/scsi/ncr53c8xx.c:129:
drivers/scsi/sym53c8xx_defs.h:293:1: warning: "ktime_sub" redefined
In file included from include/linux/ktimer.h:19,
                 from include/linux/sched.h:264,
                 from include/linux/module.h:10,
                 from include/linux/device.h:20,
                 from include/linux/genhd.h:15,
                 from include/linux/blkdev.h:6,
                 from drivers/scsi/ncr53c8xx.c:100:
include/linux/ktime.h:107:1: warning: this is the location of the previous definition
drivers/scsi/ncr53c8xx.c:7622: warning: ‘ncr53c8xx_setup’ defined but not used
  CC [M]  drivers/scsi/libata-core.o
  CC [M]  drivers/scsi/libata-scsi.o
  CC [M]  drivers/scsi/scsi.o

Are they of any interest?

regards,
Felix
