Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317499AbSFDXgs>; Tue, 4 Jun 2002 19:36:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317505AbSFDXgs>; Tue, 4 Jun 2002 19:36:48 -0400
Received: from revdns.flarg.info ([213.152.47.19]:33171 "EHLO noodles.internal")
	by vger.kernel.org with ESMTP id <S317499AbSFDXgq>;
	Tue, 4 Jun 2002 19:36:46 -0400
Date: Wed, 5 Jun 2002 00:38:24 +0100
From: Dave Jones <davej@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Linux 2.5.20-dj3
Message-ID: <20020604233824.GA24642@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch queue under control again, this gets the interesting bits
out of the way, and introduces some of the kbuild2.5 bits in a
hope to cut down the number of "Will you merge kbuild2.5" mails
I get each day.

As usual,..

Patch against 2.5.20 vanilla is available from:
ftp://ftp.kernel.org/pub/linux/kernel/people/davej/patches/2.5/

Merged patch archive: http://www.codemonkey.org.uk/patches/merged/

Check http://www.codemonkey.org.uk/Linux-2.5.html before reporting
known bugs that are also in mainline.

 -- Davej.

2.5.20-dj3
o   Uptime >497 days wrap fixes.			(Tim Schmielau)
o   Remove some bogus whitespace diffs.			(Thierry Vignaud, Me)
o   Updated ALSA VIA driver.				(Thierry Vignaud,
							 ALSA folks)
o   Make multiple shared file leases more stable.	(Stephen Rothwell)
o   Fix compilation of bluetooth when compiled in.	(Maksim Krasnyanskiy)
o   Make i2c sysctls dependant upon CONFIG_SYSCTL	(Albert Cranford)
o   Add i2c proc entries to read smbus block data.	(Albert Cranford)
o   Fix quota format config.in entry.			(Alex Riesen)
o   IDE updates up to -84				(Martin Dalecki)
o   Fix make tags to descend into $arch dirs.		(Rusty Russell)
o   Add missing __KERNEL__ guard to byteorder/generic.h	(Dan Kegel)
o   Merge selected bits of kbuild2.5		(Sam Ravnborg, Keith Owens)
    - Dynamic symbol limit for tkparse.
    - depmod & split-include warning fixes.
    - Escape double quotes in config.in files.
    - Add new test targets: allyes, allno, randconfig
o   Make suspend to RAM work again.			(Pavel Machek)
o   Software suspend cleanups.				(Pavel Machek)
o   airo driver janitor work.				(Martin Dalecki)
o   Remove redundant Make rule.				(Adam J. Richter)
o   Add some missing printk levels to fatfs.		(Andrey Panin)
o   Fix oops on writing to floppy.			(Jens Axboe)
o   Fix compilation of kernel-api docbook.		(Juan Quintela)
o   Further floppy driver fixes.			(Mikael Pettersson)
o   Remove bogus casts in ide-cd			(Peter Chubb)
o   eicon driver was kfree'ing wrong skb.		(Adar Dembo)
o   Death of (f)suser()					(Robert Love)
    | And there was much rejoicing in kernel janitor land.
o   postcore_initcall changes for PCI & sys_bus.	(Patrick Mochel)


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
