Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315439AbSEZBn1>; Sat, 25 May 2002 21:43:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315525AbSEZBn0>; Sat, 25 May 2002 21:43:26 -0400
Received: from revdns.flarg.info ([213.152.47.19]:8593 "EHLO noodles.internal")
	by vger.kernel.org with ESMTP id <S315439AbSEZBnZ>;
	Sat, 25 May 2002 21:43:25 -0400
Date: Sun, 26 May 2002 02:44:39 +0100
From: Dave Jones <davej@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Linux 2.5.18-dj1
Message-ID: <20020526014439.GA19527@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Resync against 2.5.18, and go through the pending patches folder.
Mostly compilation fixes, but a handful of useful bits too.
A lot of the pending stuff doesn't apply any more, so it may
take a while for me to get around to applying. (ie, resending
resynced versions of patches you sent me may be quicker)

As usual,..

Patch against 2.5.18 vanilla is available from:
ftp://ftp.kernel.org/pub/linux/kernel/people/davej/patches/2.5/

Merged patch archive: http://www.codemonkey.org.uk/patches/merged/

Check http://www.codemonkey.org.uk/Linux-2.5.html before reporting
known bugs that are also in mainline.

 -- Davej.

2.5.18-dj1
o   Fix up typos in net-sched patch from last time.	(Me)
o   More 64 bit fixes to x86-64 MTRR driver.		(Me)
o   HFS compilation fix.				(Christoph Hellwig)
o   Work around P4 Xeon errata O37			(Me)
o   Fix software delays in clps711xfb			(Me)
o   ide-scsi compile fix.				(Gert Vervoort)
o   matroxfb compile fix.				(Kai Germaschewski)
o   Remove duplication in siginfo.h			(Stephen Rothwell)
o   Remove <asm/errno.h> duplication.			(Stephen Rothwell)
o   PCMCIA config.in formatting fix.			(Adrian Bunk)
o   OPL3 compile fix.					(Takashi Iwai)
o   Fix potential oops in VFAT.				(OGAWA Hirofumi)
o   Region handling fixes in numerous drivers.		(Felipe W.Damasio,
							 William Stinson)
o   Fix broken tulip config.in				(Alex Riesen)
o   Stage 1 of LVM vg_t/lv_t sanitation.		(Anders Gustafsson)
o   vm86 page table ops locking fix.			(Benjamin LaHaise)
o   Remove unused var from v86 mode struct.		(Kasper Dupont)
o   Remove cacheline bouncing of apic_timer_irqs	(Ravikiran G Thirumalai)
o   Small cleanups in i386 head.S			(Brian Gerst)
o   Kill change_floppy warning when no floppy compiled.	(Peter Chubb)
o   semctl SUSv2 compliance.				(Christopher Yeoh)
o   Software suspend compile fix.			(Skip Ford)

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
