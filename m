Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312176AbSCRCUa>; Sun, 17 Mar 2002 21:20:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312175AbSCRCUU>; Sun, 17 Mar 2002 21:20:20 -0500
Received: from ns.suse.de ([213.95.15.193]:32016 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S312176AbSCRCUI>;
	Sun, 17 Mar 2002 21:20:08 -0500
Date: Mon, 18 Mar 2002 03:20:07 +0100
From: Dave Jones <davej@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Linux 2.5.6-dj2
Message-ID: <20020318032007.E4677@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch clears out most of my pending queue (leaving just the bits that
need hand-patching, or some more thinking about).

As usual,..
Patch against 2.5.6 vanilla is available from:
ftp://ftp.kernel.org/pub/linux/kernel/people/davej/patches/2.5/

Merged patch archive: http://www.codemonkey.org.uk/patches/merged/

Check http://www.codemonkey.org.uk/Linux-2.5.html before reporting
known bugs that are also in mainline.

 -- Davej.

2.5.6-dj2
o   machine check background checker SMP improvements.	(Me)
o   Hush INVALIDATE_AGID noise on Toshiba DVD drives.	(Jens Axboe)
o   Remove delayed vfree() in ppp_deflate.		(David Woodhouse)
o   Fix devfs 64-bit portability issues.		(Carsten Otte)
o   UFS blocksize fix.					(Zwane Mwaikambo)
o   Fix proc race on task_struct->sig.			(Chris Mason)
o   Pull NFS server IP from root_server_path.		(Martin Schwenke)
o   Fix broken tristate in ALSA config.			(Steven Cole)
o   Work around mpc_apicid > MAX_APICS problem.		(James Cleverdon)
o   cs4281 OSS compile fix.				(Sebastian Droege)
o   Fix locking in ATM device allocation.		(Maksim Krasnyanskiy)
o   Fix MSDOS filesystem option mistreatment.		(Rene Scharfe)
o   Increase number of JFS transaction locks.		(Steve Best)
o   page_to_phys() fix for >4GB pages on x86.		(Badari Pulavarty)
o   Append kernel config to zImage.			(Randy Dunlap)
    | See also scripts/extract-ikconfig
o   Remove useless check from shmem_link()		(Alexander Viro)
o   Enable Natsemi MMX extensions.			(Zwane Mwaikambo)
o   Superblock cleanups for isofs,udf & bfs.		(Brian Gerst)
o   request_region() checking for hisax avm_a1		(Dan D Carpenter)
o   uninitialise lots of static vars in net/		(William Stinson)
o   D-Link DE620 janitor work.				(Karol Kasprzak)
o   Netfilter conntrack compile fix.			(Christopher Barton)


2.5.6-dj1
o   Sync against 2.5.6
    | Take my last_rx changes for hamradio over mainline.
o   Merge 2.5.7pre2
o   Initialise Machine check bank 0 on AMD systems.	(Me)
o   background checking for non-fatal machine checks.	(Me)
o   Fix ALSA config.in so xconfig works again.		(William Stinson)
o   ITE8330G IRQ router support.			(Tobias Diedrich)
o   Fix reiserfs oops on mount.				(Oleg Drokin)
o   Don't offer various MIPS drivers on !MIPS arches.	(Me)
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
