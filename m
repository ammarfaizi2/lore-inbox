Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290289AbSBORUl>; Fri, 15 Feb 2002 12:20:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290293AbSBORUc>; Fri, 15 Feb 2002 12:20:32 -0500
Received: from noodles.codemonkey.org.uk ([62.49.180.5]:4765 "EHLO
	noodles.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id <S290289AbSBORUM>; Fri, 15 Feb 2002 12:20:12 -0500
Date: Fri, 15 Feb 2002 17:24:31 +0000
From: Dave Jones <davej@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Linux 2.5.4-dj2
Message-ID: <20020215172431.A32369@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

*massive* sync with Linus, and a whole bunch of bits that
were left over. Started merging some of the janitor fixes
that have turned up over the last week, more to come.
Given the size of this diff, there are possibly some sync issues
to shake out. I'm concentrating on pushing bits to Linus right now,
so I may not release as many patches until 2.5.5 final.

Patch against 2.5.4 vanilla is available from:
ftp://ftp.kernel.org/pub/linux/kernel/people/davej/patches/2.5/

 -- Davej.

2.5.4-dj2
o   Merge 2.5.5pre1
    | Includes OSS changes from -dj1 moved to new
    | sound/oss/ directory. These need checking to see
    | if its worth to keep any of them.
o   Backout __free_pages_ok check.			(Hugh Dickins)
o   Improve bad inode handling in open_namei().		(Daniel Mack)
o   Intermezzo module macros cleanup.			(Craig Christophel)
o   fbdev accel wrapper.				(James Simmons)
o   Remove dead code from device.h			(Pavel Machek)
o   Kill BKL in NFS r/w & SunRPC.			(Trond Myklebust)
o   NFSv3 READDIRPLUS support.				(Trond Myklebust)
o   Various pcnet32 cleanups.				(Go Taniguchi)
o   ftape virt_to_bus fixes.				(Mikael Pettersson)
o   Numerous define syntax fixes.			(Timothy Ball)
o   Fix scheduler oops with rw waitqueue spinlocks.	(Bob Miller)
o   Various region/resource cleanups.			(Marcus Alanen)
o   mdacon janitor cleanups.				(Boris Bezlaj)
o   USB OHCI powerbook fix.				(Paul Mackerras)
o   Various config.help updates.			(Steven Cole)
o   Amiga drivers for new input-core layer.		(James Simmons)
o   Split up console.c & vt.c.				(James Simmons)
o   Remove unneeded reiserfs check.			(Oleg Drokin)
o   Make miro radio compile again.			(Gerd Knorr)
o   Vesafb bus_to_virt fix.				(Steven Cole)
o   Advansys virt_to_bus & scatterlist::address fixes.	(Douglas Gilbert)
o   Fix last_pid smp race.				(J.A. Magallon)
o   Various fs list_for_each cleanups.			(Martin Hicks)
o   Display source/dest IP in short UDP packet log.	(David Ford)
    | Modified by me to fit style of similar warnings.
o   Fix up OSS ymfpci.				(Pete Zaitcev, John Weber)
o   Remove FPU usage from neofb.		(Denis Oliver Kropp)


2.5.4-dj1
o   Merge 2.5.4
o   Fix inverted parameters in NCR5380			(Rasmus Andersen)
o   NSC Geode Companion chip workaround.		(Hiroshi MIURA)
    | TODO: Nuke the CONFIG option, replace with
    | PCI detection.
o   Improve kiobuf_init performance.			(Various Intel folks)
o   uidhash cleanup.					(William Lee Irwin III)
o   Fix /proc 'read past end of buffer' bug.		(Thomas Hood)
    | See http://home.t-online.de/home/gunther.mayer/lsescd
o   PnPBIOS updates (ESCD support).			(Thomas Hood)
o   signal.c missing binfmt include compile fix.	(Udo A. Steinberg)
o   thread_saved_pc compile fix.			(Andrew Morton)
o   Various reiserfs updates.				(Oleg Drokin, Namesys)
o   Fix UP Preempt compilation.				(Mikael Pettersson)
o   Kill sleep_on in Olympic TR driver.			(Mike Phillips)
o   Drop 64bit DRM fixes.
o   Fix zftape compile.					(Me)
o   Hack around synclink non-compile.			(Me)


2.5.3-dj5
o   Merge 2.5.4pre5
o   Add some missing MODULE_LICENSE tags	(Hubert Mantel)
o   Fix ptrace PEEKUSR oops.			(Manfred Spraul, others)
o   Drop some bogus bits from USB & netdrivers.	(Me)
o   sbpcd bio fixes.				(Paul Gortmaker)
o   pci id trigraph warning fixes.		(Steven J. Hill)
o   Tridentfb resource management fixes.	(Geert Uytterhoeven)
o   53c700 locking cleanup.			(James Bottomley)
o   Workaround ext2 trying to free block -1	(Andreas Dilger)
o   Fix up deviceio Docbook generation.		(Jason Ferguson)
o   removal of isa_read/writes from ibmtr.	(Mike Phillips)
o   kthread abstraction.			(Christoph Hellwig)



-- 
Dave Jones.                    http://www.codemonkey.org.uk
SuSE Labs.
