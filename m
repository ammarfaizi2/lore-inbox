Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311234AbSCQBcn>; Sat, 16 Mar 2002 20:32:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311241AbSCQBce>; Sat, 16 Mar 2002 20:32:34 -0500
Received: from zeus.kernel.org ([204.152.189.113]:47861 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S311234AbSCQBcT>;
	Sat, 16 Mar 2002 20:32:19 -0500
Date: Sun, 17 Mar 2002 02:27:16 +0100
From: Dave Jones <davej@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Linux 2.5.6-dj1
Message-ID: <20020317022716.A32672@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mostly just a 'catching up' release after my weeklong haitus.
Almost up to date with 2.4, and right up to date with 2.5 (for today at least)
This one hasn't had any testing beyond "it compiles" (testboxes are still in
packing boxes, and I'm currently a few hundred KM from home), so tread
carefully. This one is mostly just a resync-point just to start the
probably imminent 2.5.7 afresh.

Oh, and as in 2.5.7pre2, disable ACPI. It's more borken than usual.

There's still a mountain of pending bits to dig through, and lots of work
to be done in the "splitting up bits for Linus" dept.


As usual,..
Patch against 2.5.6 vanilla is available from:
ftp://ftp.kernel.org/pub/linux/kernel/people/davej/patches/2.5/

Merged patch archive: http://www.codemonkey.org.uk/patches/merged/

Check http://www.codemonkey.org.uk/Linux-2.5.html before reporting
known bugs that are also in mainline.

 -- Davej.

2.5.6-dj1
o   Sync against 2.5.6
    | Take my last_rx changes for hamradio over mainline.
o   Merge 2.5.7pre2
o   Initialise Machine check bank 0 on AMD systems.	(Me)
o   background checking for non-fatal machine checks.	(Me)
o   Fix ALSA config.in so xconfig works again.		(William Stinson)
o   ITE8330G IRQ router support.			(Tobias Diedrich)
o   Fix reiserfs oops on mount.				(Oleg Drokin)
o   Only offer various MIPS drivers on !MIPS arches.	(Me)
o   Remove double REPORT_LUNS from cpqfcTSstructs.h	(Me)
o   Fix up potential oops in udp short packet logging	(Me)
    | doesn't affect mainline.
o   sysrq updates.					(James Simmons)
o   Replace fbcon-cfb with software accels.		(James Simmons)
o   Allow ACPI configuration on x86-64			(Me)
o   Drop the radix pagecache stuff.
    (Was an ancient version, and a pita to maintain)
o   nfs3 compile fix.					(Al Viro)
o   pnpbios updates.					(Thomas Hood)


2.5.5-dj3
o   Merge 2.5.6pre2
o   Merge 2.4.19pre2
    | Drop various arch bits. (See above)
    | Drop LVM bits.
    | Drop some SIS bits that rejected -- James please take a look.
    | Fix some obvious sillies as per 2.4.19pre2ac1
o   Add missing struct initialiser to nls_cp850		(OGAWA Hirofumi)
o   natsemi rx/tx ring buffer confusion fixup.		(Jeff Garzik)
o   Backout bogus isofs makefile changes.		(Me)
o   Fix sys_shmdt return code.				(Andreas Schwab)
o   Numerous net driver last_rx = jiffies fixes.	(Me, Celso Gonzalez)
o   msync/mprotect POSIX fixes.				(Thorsten Kukuk)
o   Small SCSI generic updates.				(Douglas Gilbert)
o   Allow short commands in SCSI debug driver.		(Douglas Gilbert)
o   Update helptext for Machine Check.			(Paul Gortmaker)
o   Updated email address.				(Thomas Molina)
o   Fix potential oops in swapfile code.		(Andries Brouwer)
o   Reset/Reservation handling fixes.			(James Bottomley)
o   Various console fixes.				(James Simmons)
o   Update numerous fb drivers to new api.		(James Simmons)
o   Twin inquiry mode for SCSI LUN scanning.		(Patrick Mansfield,
							 Douglas Gilbert)
o   Update DMI / local APIC fixes.			(Mikael Pettersson)
o   Emu10k1 OSS highmem dma fixes.			(Daniel Bertrand)
o   Export dparent_lock					(Petr Vandrovec)
o   Clean up struct page shrinkage.		(Rik van Riel, Dave Miller)
o   More Config.help updates.				(Steven Cole)
o   Make highmem pte a boolean.				(Steven Cole)
o   opl3sa2 modular compile fix.			(Zwane Mwaikambo)
o   es18xx compile fix.					(Zwane Mwaikambo)
o   nfsd modular compile fix.				(Stelian Pop)
o   Use list heads for task list.			(Brian Gerst)
o   Fix up various compilation warnings.		(Roberto Nibali)
o   Power management for 3c509.				(Zwane Mwaikambo)
o   Small kbuild cleanup.				(John Levon)


-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
