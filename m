Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318035AbSGLWWq>; Fri, 12 Jul 2002 18:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318036AbSGLWWp>; Fri, 12 Jul 2002 18:22:45 -0400
Received: from revdns.flarg.info ([213.152.47.18]:63183 "EHLO noodles.internal")
	by vger.kernel.org with ESMTP id <S318035AbSGLWWn>;
	Fri, 12 Jul 2002 18:22:43 -0400
Date: Fri, 12 Jul 2002 23:24:54 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Linux 2.5.25-dj2
Message-ID: <20020712222454.GA10322@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A few more items from the pending queue, including the large
IDE patch from Jens and Andre, various updates & cleanups.
Mostly clearing things out of the backlog before I jet off
to Germany for a week..

As usual,..

Patch against 2.5.25 vanilla is available from:
ftp://ftp.kernel.org/pub/linux/kernel/people/davej/patches/2.5/

Merged patch archive: http://www.codemonkey.org.uk/patches/merged/

Check http://www.codemonkey.org.uk/Linux-2.5.html before reporting
known bugs that are also in mainline.

 -- Davej.

2.5.25-dj2
o   2.4 IDE layer forward port.			(Jens Axboe, Andre Hedrick)
o   Take some of the new input changes from .25
    | by .26, I should be able to go with mainline
    | if merging continues at current rate.
o   More cleanups in the agpgart driver.		(Greg-KH)
o   cpufreq update.					(Dominik Brodowski)
o   Update DMA-mapping documentation.			(Adam J. Richter)
o   Fix problem with Bochs & new MTRR driver.		(Manfred Spraul)
o   Fix i815e agpgart support.				(Nicolas Aspert)
o   Fix lock hang in shm_destroy()			(Hugh Dickins)
o   Various SCSI driver janitor work.			(Michael G. Janicki)
o   Allow booting from non-zero boot CPU.		(Anton Blanchard)
o   ad1848 OSS compile fix.				(Ryan Anderson)
o   cs46xx compile fix.					(Stephen Rothwell)
o   3c509 + non-isapnp compile fix.			(James Morris)
o   i2o proc compile fix.				(Adrian Bunk)
o   aironet compile fix.				(Adrian Bunk)


2.5.25-dj1
o   Fix negative memcpy issue in orinoco driver.	(Russell King)
o   Improvements to i386 machine check handler.		(Andi Kleen)
o   Fix various bitops to use unsigned long's.		(Geert Uytterhoeven)
o   Various network driver init_etherdev cleanups.	(Crutcher Dunnavant)
o   Improved list handling in dcache.c			(Matthew Wilcox)
o   Convert various i2c drivers to new interface.	(Frank Davis,
							 Albert Cranford)
o   Consistent usage of static in keyboard maps.	(Keith Owens)
o   Various typo fixes in ipsysctl docs.		(Edward J. Huff)
o   Region handling cleanup in boardergo isdn.		(William Stinson)
o   Region handling cleanup in baycom hamradio driver.	(William Stinson)
o   PCI DMA update for roadrunner HIPPI driver.		(Francois Romieu)
o   RPC recieve cleanup.				(Trond Myklebust)
o   Fix potential O_DIRECT oops.			(Andrew Morton)
o   Fix module creation off-by-one's.			(Peter Oberparleiter)
o   airo, aztcd & sonycd compile fixes.			(Martin Dalecki)
o   Fix misleading tlb flush comment.			(Manik Raina)
o   PCI DMA update for tlan (and misc cleanup)		(Francois Romieu)
o   Cleanup suspend code not to need prototypes.	(Pavel Machek)
o   Numerous pci_enable_device() cleanups.		(Michael G. Janicki)
o   Fix garbage in /proc/partitions.			(Peter Chubb)
o   agpgart compile fix.				(Manfred Spraul)
o   fatfs crapectomy.					(Christoph Hellwig)
o   Don't advise to make dep when not needed.		(Christoph Hellwig)
-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
