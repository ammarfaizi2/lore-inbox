Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311206AbSDNUYi>; Sun, 14 Apr 2002 16:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312453AbSDNUYh>; Sun, 14 Apr 2002 16:24:37 -0400
Received: from [213.152.47.19] ([213.152.47.19]:59531 "EHLO
	noodles.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id <S311206AbSDNUYg>; Sun, 14 Apr 2002 16:24:36 -0400
Date: Sun, 14 Apr 2002 21:21:15 -0100
From: Dave Jones <davej@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Linux 2.5.7-dj4
Message-ID: <20020414212115.A10316@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Catching up with the backlog that ensued whilst resyncing with Linus.

This brings things up to date with whats going on in 2.4, and syncs up with
Linus' tree.  This is a fairly large resync (5 pre releases), so I'm expecting
some things to break in various places. The USB bits in particular might need
a little more rejiggling.

Even with the 3 2.4pre merges, my tree is currently still 6MB apart from
mainline, with more bits heading off to Linus sometime in the next week.
Some small bits are also going to trickle in over the next few -dj's to
try and get through the huge patch backlog.

As usual,..
Patch against 2.5.7 vanilla is available from:
ftp://ftp.kernel.org/pub/linux/kernel/people/davej/patches/2.5/

Merged patch archive: http://www.codemonkey.org.uk/patches/merged/

Check http://www.codemonkey.org.uk/Linux-2.5.html before reporting
known bugs that are also in mainline.

 -- Davej.

2.5.7-dj4
o   Sync up with 2.5.8pre2 & pre3.
    | dropped cyber2000fb changes  (James, please check)
o   Merge 2.4.19pre4, pre5 and pre6.
o   MCE_NONFATAL SMP fixes.				(Robert Love, Me)
o   bttv compile fix.					(Thierry Vignaud)
o   Numerous small compile fixes.			(Me)


2.5.7-dj3
o   Merge 2.5.8-pre1.
o   Fix some bogus changes found whilst syncing.	(Me)
o   Only offer thermal interrupt monitor on P4.		(Me)
o   Only offer bluesmoke background checker on K7.	(Me)


2.5.7-dj2
o   Merge bits of 2.4.19pre3 & pre4.
    | Dropped quite a bit, 2.5 is really starting to diverge
    | in quite a few areas.
o   Numerous compile fixups.				(Me)
o   Various config.help updates.			(Steven Cole, ESR)
o   AFFS compile fix.					(Jarno Paananen)
o   Update bttv to use new v4l API.			(Jarno Paananen)
o   Removal extraneous BUG() from accounting code.	(Bob Miller)
o   Fix up JFS txnmgr race.				(Christoph Hellwig)
o   Update documentation index.				(Rolf Eike Beer)
o   Use seq_file for /proc/partitions.			(Randy Dunlap)
o   Fix initrd kdev_same thinko.			(Al Viro)
o   Minor sg update.					(Doug Gilbert)
o   install .config with 'make install'			(Kelly French) 
o   Add yet another VAIO to the DMI APM blacklist.	(Michael Piotrowski)
o   Detect get_block errors in block_read_full_page.	(Anton Altaparmakov)
o   Kill off noquot.c					(Al Viro)
o   Special case P4/Xeon bluesmoke init.		(Jon Hourd)
o   Fix up ide-scsi documentation typo.			(Bill Jonas)
o   Increment tcpPassiveOpens counter.			(Dave Miller)
o   Fix up some of Linus' criticisms of SEM_UNDO	(Dave Olien)
o   ibmphp compile fix.					(Greg KH)
o   Fix up two possible panics in microcode driver.	(Tigran Aivazian)
o   fcntl return code POSIX compliance.			(Christopher Yeoh)
o   Lessen debug info from ide-tape.			(Alfredo Sanjuán)
o   Various ide fixes.					(Andre Hedrick)
    | pdc4030 bent into shape a little by me, please test carefully.
o   EasyDisk USB storage support.			(Stanislav Karchebny)
o   Flush cache/TLB on MCE.				(Me)
o   Fix double free in efi partition handling.		(Takanori Kawano)
o   Correct pci_set_mwi documentation typo.		(Geert Uytterhoeven)
o   Fix up race in indydog driver.			(Dave Hansen)
o   3ware driver update.				(Adam Radford)
o   Fix mmap bug with drivers that adjust vm_start.	(Benjamin LaHaise)
o   Register mad16 gameport with input subsystem.	(Michael Haardt)
o   Remove stale comment.				(William Lee Irwin III)
o   P4/Xeon Thermal LVT support for MCE.		(Zwane Mwaikambo)
o   Various fbdev compilation fixes.			(James Simmons)
o   Move touchscreen drivers to their own dir.		(James Simmons)
o   Seperate reiserfs_sb_info from struct super_block	(Brian Gerst)


2.5.7-dj1
o   Various x86-64 compile fixes.			(Me, Andi Kleen)
o   Fix up hfs superblock cleanup typo.			(Brian Gerst)
o   Remove 2.1.x/2.3.x checks from rocket driver.	(William Stinson)
o   JFS compile fixes.					(Dave Kleikamp)
o   pci_alloc_consistent ZONE_NORMAL fix.		(Badari Pulavarty)
o   v4l unregister with open file handles fix.		(Gerd Knorr)
o   ACPI throttling fixes.				(Dominik Brodowski)
o   Updated NFS root_server_path patch.			(Martin Schwenke)
o   Backout problematic sym53c8xx_2 changes.		(Douglas Gilbert)
o   Fix up one of my MCE SNAFU's.			(Douglas Gilbert)
    | Also make it AMD only for now, pending further investigation.
o   Support for Belkin Wireless card.			(Brendan W. McAdams)
o   input/gameport makefile & config.in fixes.		(Steven Cole)
o   UDF write compile fix.


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


-- 
Dave Jones.                    http://www.codemonkey.org.uk
SuSE Labs.
