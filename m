Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315223AbSDWOpc>; Tue, 23 Apr 2002 10:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315224AbSDWOpb>; Tue, 23 Apr 2002 10:45:31 -0400
Received: from 213-152-47-19.dsl.eclipse.net.uk ([213.152.47.19]:9347 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S315223AbSDWOp3>;
	Tue, 23 Apr 2002 10:45:29 -0400
Date: Tue, 23 Apr 2002 15:45:27 +0100
From: Dave Jones <davej@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Linux 2.5.9-dj1
Message-ID: <20020423144527.GA12925@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

More of the same. Back up to date with Linus, and roll in some more pending bits.

As usual,..
Patch against 2.5.9 vanilla is available from:
ftp://ftp.kernel.org/pub/linux/kernel/people/davej/patches/2.5/

Merged patch archive: http://www.codemonkey.org.uk/patches/merged/

Check http://www.codemonkey.org.uk/Linux-2.5.html before reporting
known bugs that are also in mainline.

 -- Davej.

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


2.5.8-dj1
o   Detect existing disk geometry in scsicam.c		(Doug Gilbert)
o   Various request_region cleanups.			(Evgeniy Polyakov)
    | Via Rusty's trivial patchbot, and cleaned a little by me.
o   Yet more request_region cleanups.			(William Stinson)
o   IBM USB Memory key support.				(Alexander V. Inyukhin)
o   Add missing IA64 helptexts.				(Steven Cole)
o   Fix BFS superblock allocation error.		(Brian Gerst)
o   romfs superblock cleanups.				(Brian Gerst)
o   Limit charset size in NLS UTF8			(Liyang Hu)
o   NCR 53c810 PCI class fixup.				(Graham Cobb)
o   Dynamically size LDT on alloc.			(Manfred Spraul)
o   Disable ACPI C3 on PIIX4 whilst busmastering.	(Dominik Brodowski)
o   hitfb compile fix.					(James Simmons)
o   Various ALSA include compile fixes.			(Russell King)
o   fatfs includes compile fix.				(Russell King)
o   Stricter HTML generation from SGML.			(Erik van Konijnenburg)
o   wdt977 BKL removal.					(Dave Hansen)
o   Various suser -> capability checks.			(Colin Slater)
o   Don't miss preemption opportunities.		(Robert Love)
o   Fix up broken strtok->strsep in tmscsim.c		(Dan D Carpenter)
o   Small kernel-api docbook updates.			(Erik Mouw)
o   Various small touchscreen fixes.			(James Simmons)
o   virt_to_bus fixes for synclink driver.		(Paul Fulghum)
o   Correct nfsservctl capability.h comment.		(Chris Wright)
o   Cleanup x86 io.h functions.				(Brian Gerst)
o   Make 'make tags' work with bitkeeper.		(Peter Chubb)
o   Correct Num/Caps_lock state ioctl flags mixup	(Rok Papez)
o   Small Farsync driver fixes.				(Francois Romieu,
							 Kevin Curtis)
o   Make st.c not oops when there are no tapes.		(Douglas Gilbert)
o   Add PnP scanning to AD1848 OSS driver.		(Zwane Mwaikambo)
o   AHA152x update (ISAPNP,ABORT fixed & 2.5 fixes).	(Juergen E. Fischer)
o   Bluesmoke warning fixes.				(Robert Love)
o   Make per-cpu setup compile on uniprocessor		(Robert Love)
o   Fix various framebuffer merge funnies.		(James Simmons)
o   Fix migration_thread preemption race.		(Robert Love)
o   IDE TCQ updates.					(Jens Axboe)
o   SIGIO generation on FIFOs & pipes.			(Jeremy Elson)
o   PNPBIOS SMP fixes.					(Thomas Hood et al)
o   attach_mpu401() cleanup on failure			(Zwane Mwaikambo)
o   Make P4 thermal interrupt warning a compile option.	(Me)
    | init check for same now also checks for Intel P4.
o   Offer Athlon background MCE checker on i386 too.	(Me)

