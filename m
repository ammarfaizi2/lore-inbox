Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315988AbSGIAoU>; Mon, 8 Jul 2002 20:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316047AbSGIAoT>; Mon, 8 Jul 2002 20:44:19 -0400
Received: from revdns.flarg.info ([213.152.47.18]:44721 "EHLO noodles.internal")
	by vger.kernel.org with ESMTP id <S315988AbSGIAoT>;
	Mon, 8 Jul 2002 20:44:19 -0400
Date: Tue, 9 Jul 2002 01:46:43 +0100
From: Dave Jones <davej@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Linux 2.5.25-dj1
Message-ID: <20020709004643.GA21880@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Resync against latest Linus release, and start folding in some of
the bits that have accumulated whilst I've been at conferences.
I dropped the input layer changes, as the ones in my tree already
are known to be 'almost good'. They should just fall out over time
in the same way as the framebuffer changes.

As usual,..

Patch against 2.5.25 vanilla is available from:
ftp://ftp.kernel.org/pub/linux/kernel/people/davej/patches/2.5/

Merged patch archive: http://www.codemonkey.org.uk/patches/merged/

Check http://www.codemonkey.org.uk/Linux-2.5.html before reporting
known bugs that are also in mainline.

 -- Davej.

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
