Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314381AbSFDP5I>; Tue, 4 Jun 2002 11:57:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314551AbSFDP5H>; Tue, 4 Jun 2002 11:57:07 -0400
Received: from revdns.flarg.info ([213.152.47.19]:30865 "EHLO noodles.internal")
	by vger.kernel.org with ESMTP id <S314381AbSFDP5F>;
	Tue, 4 Jun 2002 11:57:05 -0400
Date: Tue, 4 Jun 2002 16:58:45 +0100
From: Dave Jones <davej@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Linux 2.5.20-dj2
Message-ID: <20020604155845.GA19052@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Start digging through the patch queue. Plenty more to come,
but I want to do this in chunks rather than one huge set.

As usual,..

Patch against 2.5.20 vanilla is available from:
ftp://ftp.kernel.org/pub/linux/kernel/people/davej/patches/2.5/

Merged patch archive: http://www.codemonkey.org.uk/patches/merged/

Check http://www.codemonkey.org.uk/Linux-2.5.html before reporting
known bugs that are also in mainline.

 -- Davej.

2.5.20-dj2
o   Use page_to_pfn in BIO code.			(Anton Blanchard)
o   Fix framebuffer oops.				(A Guy Called Tyketto)
o   PCI device matching fixes.				(Patrick Mochel,
							 Andrew Morton)
o   SIS 745 AGPGART support.				(Carsten Rietzschel)
o   64bit fixes for swap ops.				(Anton Blanchard)
o   Add i8253 spinlocks where needed.			(Vojtech Pavlik)
o   Region handling cleanup for UMC 8672 IDE driver.	(William Stinson)
o   Region handling cleanup for hd.c			(William Stinson)
o   fcntl() POSIX correctness fix.			(Andries Brouwer)
o   Region handling cleanup for eexpress		(William Stinson)
o   PCI pool 64 bit warning fix.			(Frank Davis)
o   Trivial PCI quirk cleanup.				(Ghozlane Toumi)
o   Update URLs to Linux documentation project.		(Gianni Tedesco)
o   Plug scsi_scan memory leak.				(Patrick Mansfield)
o   Region handling cleanup for inia100.		(William Stinson)
o   Make daemonize() do reparent_to_init() for caller.	(Rusty Russell)
    | same done for hvc_console & cpqphp_ctlr		(Me)
o   copy_siginfo_to_user() cleanup.			(Stephen Rothwell)
o   Clean up capability locking.			(Robert Love)
o   Check dcache allocation success before using.	(Dan Aloni)

2.5.20-dj1
o   Drop some more bogus bits found whilst patch-splitting.
o   emu10k1 compile fix.				(Alistair Strachan)
o   Framebuffer updates.				(James Simmons)
o   Drop some bogus kbuild bits.			(Kai Germaschewski)
o   Unobsolete egcs kernel builds.			(Me)
    | This can be worked around, and this is compiler 
    | of choice on sparc and other archs.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
