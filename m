Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314562AbSD0DIl>; Fri, 26 Apr 2002 23:08:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314565AbSD0DIk>; Fri, 26 Apr 2002 23:08:40 -0400
Received: from revdns.flarg.info ([213.152.47.19]:10377 "EHLO noodles.internal")
	by vger.kernel.org with ESMTP id <S314562AbSD0DIj>;
	Fri, 26 Apr 2002 23:08:39 -0400
Date: Sat, 27 Apr 2002 04:08:23 +0100
From: Dave Jones <davej@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Linux 2.5.10-dj1
Message-ID: <20020427030823.GA21608@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clear out the pending patch queue, and merge up to Linus' latest
in order to have a base to continue pushing bits from.

As usual,..
Patch against 2.5.10 vanilla is available from:
ftp://ftp.kernel.org/pub/linux/kernel/people/davej/patches/2.5/

Merged patch archive: http://www.codemonkey.org.uk/patches/merged/

Check http://www.codemonkey.org.uk/Linux-2.5.html before reporting
known bugs that are also in mainline.

 -- Davej.

2.5.10-dj1
o   Fix mysterious SMP compile breakage in sched.c	(Adam Kropelin)
o   Fix ISDN config.in typo.				(Steven Cole)
o   Remove duplicate entry from MAINTAINERS		(Adrian Bunk)
o   Silly typo in z2ram.c				(Jerry Cooperstein)
o   Disallow smp_call_function from bottom halves.	(Dipankar Sarma)
    | x86 only right now, other archs need changing.
o   Fix up builtin_expect warnings.			(Andrew Morton)
o   Only frob P4 LVT if thermal monitor enabled.	(Zwane Mwaikambo)
o   TUN/TAP readv/writev support.			(Maxim Krasnyansky)
o   updated UP CPU number microoptimisation.		(Mikael Pettersson)
o   Various net driver/ISDN request_region fixes.	(William Stinson)
o   Large sd update.					(Douglas Gilbert)
o   Add some missing exports.			(Dagfinn Ilmari Manns?ker)
o   CONFIG_DMASOUND_AWACS fix.				(Steven Cole)
o   A few Config.help updates.				(Steven Cole)
o   x86 pagetable_init cleanup.				(Brian Gerst)
o   New synclink drivers.				(Paul Fulghum)
o   e100 devinit compilation fix.			(Adrian Bunk)
o   Several trivial compile fixes.			(Keith Owens)
o   Update to IDE-42					(Martin Dalecki)
o   Fix handling of the wrong cluster chain.		(OGAWA Hirofumi)
o   Add validity check the first entry of FAT.		(OGAWA Hirofumi)
o   Other misc cleanups of fatfs.			(OGAWA Hirofumi)
o   printk loglevels in fatfs.				(Andrey Panin)
    | Andrey, some of these rejected, and were dropped
    | due to the above updates.
o   Release BKL in sem_undo exit path.			(Chris Wright)
o   Make sure UTS_VERSION is always in C locale.	(Martin Dalecki)
o   Fix Alpha ptrace.					(Ivan Kokshaysky)
o   Fix hang in migration thread.			(James Bottomley)


2.5.9-dj1
o   Resync against 2.5.9
    | Configure enhanced to look in /boot/`uname -r` 	(Me)
o   Fall back to PCI BIOS if direct access fails.	(Me)
o   Bump size of xconfig variable buffer		(Me)
o   64bit fixes for x86-64 MTRR driver.			(Me)
o   GL641USB based CF-Reader USB support.		(Gert Menke)
o   Bring x86-64 bluesmoke up to date with ia32.	(Me)
    | And drop non-x86-64 bits.
o   UP CPU number microoptimisation.			(Mikael Pettersson)
o   ATM resources compile fix.				(Frank Davis)
o   readahead reformatting.				(Steven Cole)
o   Death of SYMBOL_NAME				(Brian Gerst)
o   Add more missing Config.help entries.		(Steven Cole)
o   remove old SCSI-EH methods from Scsi_Host_Template	(Christoph Hellwig)
    | This likely breaks many SCSI drivers. They were broken anyway,
    | and only worked by chance. With this, they stand a chance of being fixed.
o   meye driver request_irq bugfix.			(Stelian Pop)
o   Add kernel command line params to meye driver.	(Stelian Pop)
o   Slabcache namespace cleanup.			(Ryan Mack)
o   SIGURG SUSv3 compliance.				(Christopher Yeoh)
o   Ultrastor region handling cleanup.			(William Stinson)
o   Megaraid region handling cleanup.			(William Stinson)
o   Buslogic region handling cleanup.			(William Stinson)
o   IrDA driver update.					(Jean Tourrilhes)
o   Fix ESSID related wireless crash.			(Jean Tourrilhes)
o   Attempt rd.c surgery.				(Me, Andrew Morton)
    | works/doesn't work feedback appreciated.
o   Fix reboot=bios cache handling.			(Robert Hentosh)
o   Recognise P4 Xeon in mptable.			(James Bourne)
o   64bit fixes for smbfs.				(Urban Widmark)
o   nfsd double down() fix.				(Anton Blanchard)
o   x86 io.h cleanup revisited.				(Brian Gerst)
o   kjournald open files fix.				(Ph. Marek)
o   Make expfs compilable on old compilers.		(Andrew Morton)
o   Nail the per-cpu-areas problem once and for all.	(Rusty Russell)

