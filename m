Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313457AbSDPBtd>; Mon, 15 Apr 2002 21:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313459AbSDPBtc>; Mon, 15 Apr 2002 21:49:32 -0400
Received: from [213.152.47.19] ([213.152.47.19]:42142 "EHLO
	noodles.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id <S313457AbSDPBtb>; Mon, 15 Apr 2002 21:49:31 -0400
Date: Tue, 16 Apr 2002 02:46:06 -0100
From: Dave Jones <davej@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Linux 2.5.8-dj1
Message-ID: <20020416024606.A7851@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Resync against 2.5.8, and start picking through some of the easier
stuff in the patch queue.  There's quite a bit here, but some more bits
have been thrown out, so we're still only just above that magic 6MB mark

As usual,..
Patch against 2.5.8 vanilla is available from:
ftp://ftp.kernel.org/pub/linux/kernel/people/davej/patches/2.5/

Merged patch archive: http://www.codemonkey.org.uk/patches/merged/

Check http://www.codemonkey.org.uk/Linux-2.5.html before reporting
known bugs that are also in mainline.

 -- Davej.

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


2.5.7-dj4
o   Sync up with 2.5.8pre2 & pre3.
    | dropped cyber2000fb changes  (James, please check)
o   Merge 2.4.19pre4, pre5 and pre6.
o   MCE_NONFATAL SMP fixes.				(Robert Love, Me)
o   bttv compile fix.					(Thierry Vignaud)
o   Numerous small compile fixes.			(Me)

-- 
Dave Jones.
http://www.codemonkey.org.uk
