Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262013AbSJISDo>; Wed, 9 Oct 2002 14:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262037AbSJISDn>; Wed, 9 Oct 2002 14:03:43 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:235 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S262013AbSJISDg>; Wed, 9 Oct 2002 14:03:36 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200210091809.g99I9FN19572@devserv.devel.redhat.com>
Subject: Linux 2.5.41-ac2
To: linux-kernel@vger.kernel.org
Date: Wed, 9 Oct 2002 14:09:15 -0400 (EDT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is basically about making it compile. I've not tried to tackle the 
second problem of testing it all yet.

Linux 2.5.41-ac2
o	Fix jffs/jffs2 properly this time (bpbb)	(me)
o	Fix jffs2 for workqueues			(me)
o	Next set of i2o_scsi update work		(me)
o	Do the 2.5 checkup pass on the 3c501 driver	(me)
o	Add missing exports for file system modules	(Nikita Danilov)
	on UML
o	Fix ipx proc permission bogosity	(Arnaldo Carvalho de Melo)
o	Switch appletalk spinlocks to rwlocks	(Arnaldo Carvalho de Melo)
o	Correct sys_getpid docs				(Robert Love)
o	SubmittingPatches indent fix			(John Levon)
o	cciss, cpqarray. rd. hd fixes			(Al Viro)
o	Fix cpia with gcc 3.2				(Randy Dunlap)
o	Use C99 structure initializers in IDE		(Art Haas)
o	Use C99 structure initializers in HFS		(Art Haas)
o	Update DMI scanner				(Jean Delvare)
o	Fix bogus types in ide-cd.h			(Skip Ford)
o	ns83820 updates					(Ben LaHaise)
o	AIO updates					(Ben LaHaise)
o	Beeping and sysrq on m68k			(Vojtech Pavlik)
o	Improve hid naming				(Vojtech Pavlik)
o	LSM docs					(Greg Kroah-Hartmann)
o	Merge UML updates				(Jeff Dike)
o	Fix lockd grace handling			(Juan Gomez)
o	Final superblock union cleanup			(Brian Gerst)
o	Fix atm build/makefile breakage			(Adrian Bunk)
o	Brlock optimisation				(Robert Love)
o	Miscellaneous USB updates			(Greg Kroah-Hartmann)
o	MPT Fusion update				(Pam Delaney)
o	Back out sched.c change - seem,s to cause hangs	(me)
o	Serial compile fix				(Russell King)
o	S/390 compile fixes				(Martin Schwidefsky)
o	S/390 workqueue updates				(Martin Schwidefsky)
o	Switch 3215/3270 from work queue to tasklet	(Martin Schwidefsky)
o	Update S/390 link scripts			(Martin Schwidefsky)
o	Remove duplicate S/390 memset			(Martin Schwidefsky)
o	Fix S/390 syscall tracing			(Martin Schwidefsky)
o	Multiple 3270 fixes				(Martin Schwidefsky)
o	Configurable core names				(Jes Rahbek Klinke)
o	Clean up s/390x 16bit uid calls			(Martin Schwidefsky)
o	Fix EH locking on NCR5380			(me)
	| Should now work on SMP boxes (badly admittedly)
o	Indent wd7000 (no code changes)			(me)
o	First pass at the in2000 scsi driver		(me)
	| New locking, new_eh, address conversion

Linux 2.5.41-ac1
-	Merge with Linus 2.5.41
	- Drop S/390 drivers subtree for Linus
	- Drop task queue fixes for schedule_work
	- TODO: merge two sets of conflicting UML changes
	- TODO: double check bluetooth merge
o	Fix aacraid makefile				(Mark Haverkamp)
o	Fix ips compile					(Paul Larson)
o	Fix aha152x compile				(Michel Eyckmans)
o	Fix orinoco_cs compile		(Wichert Akkerman, Martin Waitz)
o	Fix i2o_core compiler				(Gregoire Favre)
o	Fix missing exports for netfilter
o	Fix compile failure in jffs			(me)
o	Fix compile failure in jffs2			(me)
o	Fix Divas_Mod compile				(me)
o	Fix hisax compile				(me)
o	Fix ipacx compile				(me)
o	Fix pcbit compile				(me)
o	Fix tpam compile				(me)
o	Fix i2o_lan build				(me)
o	Fix i2o_proc build				(me)
o	Fix ppa compile					(me)
o	Fix imm compile					(me)
o	Fix ipv6 compile				(me)



Linux 2.5.40-ac6
o	Cadet_wake can be static			(me)
o	Bluetooth configuration cleanups		(Marcel Holtmann)
o	Hardwired empty bar handling fix take two	(Ivan Kokshaysky)
o	Use kernel crc32 lib for bluetooth		(Marcel Holtmann)
o	Make scsi cdrom honour passed timeouts		(Peter Osterlund)
o	Make aironet4500_cs compile			(me)
o	Fix bugs where ibmtr unmapped the wrong address	(me)
o	Fix crash problem in oss dmabuf.c		(me)
	| Its still very broken but ALSA should replace it
o	Fix opl3sa2 warnings				(me)
o	Make tcic compile again				(me)
o	Make i82365 also use del_timer_sync		(me)
o	Fix warnings in fpu emulator			(me)
o	Fix t128 for NCR5380 changes			(me)
o	Fix pas16 for NCR5380 changes			(me)
o	Fix dmx3191 for NCR5380 changes			(me)
o	First pass seagate st02 cleanups		(me)
o	Clean up de600 driver. Switch to spinlocks	(me)
	remove crud, formatting junk etc
	| Still needs rewriting to use parport
o	Remove extra unlock in wd7000			(Matthew Wilcox)
o	First basic pass at qlogicgas			(me)
o	Clean up the fdomain isa scsi			(me)
o	Clean up max_thread setting limits		(Matthew Wilcox)
o	Ricoh cardbus performance fix			(KOMURO)
*	Switch appletalk to seq_file /proc	(Arnaldo Carvalho de Melo)
o	Switch X.25 to seq_file			(Arnaldo Carvalho de Melo)
o	Fix bugs in the above			(Arnaldo Carvalho de Melo)

Linux 2.5.40-ac5
o	Rework S/390 driver init sequences		(Martin Schwidefsky)
o	Swap immediate_bh for tasklets for s/390 3215	(Martin Schwidefsky)
o	UML updates - crash fixes, driver cleanup	(Jeff Dike)
	pcap transport
*	Switch fmi radio card to sleeping waits		(me)
*	Fixing missing printk \n in fmi radio		(me)
o	Update to newer uclinux patch			(Greg Ungerer)
	| Unresolved now:
	| fs/exec.c kernel/fork.c procfs sysctl
	| can nommu be folded in (Hch)
o	Remove surplus irq_disable from mpt fusion	(Carlos Gorges)
*	Export gdt for APM				(Carlos Gorges)
	| Marked as _GPL because its deep internals stuff
o	Merge the add/put disk gendisk changes for i2o	(Al Viro)
*	Switch NCR5380/g_NCR5380 to new_eh		(me)
*	Fix cs89x0 netdevice init as module		(me)
o	Change some of the wd7000 code to use
	udelay and do other cleanups
o	Switch wd7000 to new_eh				(me)
o	Serial driver updates				(Russell King)
o	Sync bluetooth with 2.4, fix SMP, hotplug	(Maksim Krasnyanskiy)
	support L2CAP, BNEP, HCI filter etc
o	Move firmwareloading to hotplug for bluetooth	(Maksim Krasnyanskiy)
*	Pull hpfs out of shared struct superblock	(Brian Gerst)
o	Fix sleep with pre-empt disabled in 		(Manfred Spraul)
	set_cpus_allowed

Linux 2.5.40-ac4
*	Make ibm partition code compile again		(Martin Schwidefsky)
*	Remove unneeded config options on S/390		(Martin Schwidefsky)
o	Update DASD drivers				(Martin Schwidefsky)
o	Update S/390 xpram driver			(Martin Schwidefsky)
o	Replace S/390 BH code by tasklets		(Martin Schwidefsky)
*	Fix S/390 bitops bugs				(Martin Schwidefsky)
o	S/390x 31bit emulation fixes			(Martin Schwidefsky)
*	Update S/390 link scripts			(Martin Schwidefsky)
*	Add S/390 pre-empt support			(Martin Schwidefsky)
*	Inline some S/390 old compilers couldnt handle	(Martin Schwidefsky)
*	Use diag 44 for S/390x spinlocks		(Martin Schwidefsky)
*	Better S/390 timer handling			(Martin Schwidefsky)
*	S/390 code cleanups				(Martin Schwidefsky)
*	Clean up S/390 fpu load/stores			(Martin Schwidefsky)
o	DECnet updates for testing			(Steve Whitehouse)
*	Add console shutdown handling to S/390		(Martin Schwidefsky)
*	Remove some bogus S/390 sanity checks		(Martin Schwidefsky)
*	Clean up S/390 process irq			(Martin Schwidefsky)
o	Fix/simplify chpids handling on S/390		(Martin Schwidefsky)
*	No /proc/interrupts on S/390			(Martin Schwidefsky)
o	Remove now unneeded S/390 hack in init/main.c	(Martin Schwidefsky)
o	Clean up all the S/390 ptrace handling		(Martin Schwidefsky)
o	Fix build with local apic enabled		(James Bottomley)
o	Initial i2o_block merge of 2.4/2.5 code		(me)
	| Not yet functional
o	Initial i2o_scsi merge of 2.4/2.5 code		(me)
	| Needs dma mapping, 64bit, be and new_eh
o	Revert Ivan's pci change (breaks serverworks)
*	PCI serial oops fix				(William Irwin)
*	Remove dead wood from unistd.h			(Brian Gerst)
o	Fix bug in capget 				(Chris Wright)
o	Switch qnxfs to new style initializers		(Art Haas)
o	Recongize qnx v6 file systems			(Anders Larsen)
*	Kill off remaining pcibios_ users   (Greg "Ninja Turtle" Kroah-Hartmann)
o	Fix scsi debug for scsi scan changes		(Mike Anderson)
o	Fix some bugs in scsi error handling		(Mike Andersen)
o	Forward port RMK's 2.4 scsi fixes		(Mike Andersen)
o	Allow longer settle times for scsi reset	(Mike Andersen)
o	Hopefully improve error policies a bit		(Mike Andersen)

Linux 2.5.40-ac3
*	Resync telephony drivers with 2.4		(me)
	| Forward port security and other minor fixes
o	Fix aironet4500 build for tq changes		(me)
o	Fix keyspan USB warnings with gcc 3		(me)
o	Switch to the newer 2.4 depca driver		(me)
o	Re-merge depca fixes from 2.5.0->2.5.40]
o	Fix depca spinning waiting for irq probe	(me)
o	Fix depca copy with interrupts off		(me)
o	Fix depca clash with other ALIGN macros		(me)
*	Initial port of NCR5380/g_NCR5380 to new locks	(me)
	| This still needs new_eh, further clean up
	| and possibly making NCR5380_main a thread
*	Initial locking rework for the wd7000 scsi	(me)
	| Still needs new_eh
*	Update jffs to the dequeue_signal changes	(me)
*	Update jffs2 to the dequeue_signal changes	(me)
*	Fix shpnt misuse in NCR53c406a, wrong free_irq	(me)
*	Update NCR53c406a to new style sglist		(me)
	| Still needs new_eh
*	Architecture updates for S/390			(Martin Schwidefsky)
o	Include updates for S/390			(Martin Schwidefsky)
o	Base S/390 driver updates			(Martin Schwidefsky)
o	Add the new syscalls to S/390			(Martin Schwidefsky)
o	Fix sleeping with locks in sound_core		(Jaroslav Kysela)
o	Fix oops on shutdown of cs4281			(Suresh Siddha)
o	Fix cdrom paths in devfs			(Jordan Breeding)
o	Fix missing cache tag entry in intel cpu table	(Jean Delvare)
*	Remove old 2.2 compatibility pci functions	(Greg Kroah-Hartmann)
o	Clean up some dead devfs bits			(Greg Kroah-Hartmann)
*	Fix an oops in the hugetblpage stuff		(Andrew Morton)
	| Its still a stupid idea but now it doesnt oops
o	Handle read only BARs with type bits set	(Ivan Kokshaysky)

Linux 2.5.40-ac2
*	Fix a cut and paste error in the amd rng docs	(Troels Hansen)
*	Forward port OSS maestro3 fixes for toughbook
o	Forward port ramdisk cache coherency
o	RTL8150 USB updates				(Petko Manalov)
o	Fix corega USB ident				(Petko Manalov)
o	USB keyboard driver fix				(Dave Miller)
o	USB prototype fix				(Luc Vanoostenryck)
o	USB string fixes		(cip307@cip.physik.uni-wuerzburg.de)
o	USB test driver					(David Brownell)
o	Speedtouch USB driver fixes			(Greg Kroah-Hartmann)
*	Clean environment for hotplug			(Greg Kroah-Hartmann)
*	Fix mprotect oops				(Hugh Dickins)
o	NUMA-Q cleanups					(Martin Dobson)
o	Split timers into one x86 timer type per file	(John Stultz)
o	Cyclone timer support for x440 etc		(John Stultz)
*	Fix sleeping from illegal context for ioperm	(Andrew Morton)
o	Fix imm compile				(bonganilinux@mweb.co.za)
o	Fix irda for tq changes				(Carlos Gorges)
o	Fix xjack telephony build			(Carlos Gorges)
o	Fix ppa compile					(Carlos Gorges)
o	Fix aha152x compile for tq changes		(Carlos Gorges)
o	Fix hamradio drivers for tq changes		(Carlos Gorges)
o	Fix plip driver for tq changes			(Carlos Gorges)
o	Fix mpt fusion for tq changes			(Carlos Gorges)
o	Fix isdn for tq changes				(Carlos Gorges)
o	Fix ieee1394 for tq changes			(Carlos Gorges)
o	Fix new timer code to build with cpufreq on	(me)
o	Fix capi build for new tq_ code			(me)
	| ISDN still needs moving to real locks
	| this just cleans up one item
o	Fix missing header in mtdblock_ro		(Carlos Gorges)
o	Fix a typo and other header			(me)
o	Fix up ixj_pcmcia for 2.5			(me)
	| Note for janitors - it looks like a lot of the pcmcia release
	| code people "fixed" should be using del_timer_sync not del_timer
*	Fix missing header in longhaul cpu speed driver	(me)
*	Pipe read/write cleanup				(Manfred Spraul)
*	Make IDE PCI config text clearer	(Andrzej Krzysztofowicz)

Linux 2.5.40-ac1
+	Initial port of aacraid driver to 2.5		(me)
*	vfat corruption fix				(Petr Vandrovec)
+	Clean up firestream warnings			(Francois Romieu)
+	Voyager support					(James Bottomley)
*	Fix split_vma					(Hugh Dickins)
+	Fix config in video subdirectory		(John Levon)
+	Update olympic driver to 2.5			(Mike Phillips)
*	Fix sg init error				(Mike Anderson)
+	Fix Rules.make
o	Merge most of ucLinux stuff			(Greg Ungerer)
	| It needs putting somewhere so we can pick over the
	| hard bits left
	| Q: Wouldn't drivers/char/mem-nommu.c be better
	| Q: How to do the procfs stuff tidily
	| Q: Wouldn't it be nicer to move all mm or mmnommu specific ksyms
	|    int the relevant mm/*.c file area instead of kernel/ksyms
	| Q: Why ifdef out overcommit -  its even easier to account on 
	|    MMUless and useful info
*	Stick tulip back under 10/100 ethernet		(me)
*	Correct docs for IBM touchpad back to how	(me)
	they were before
o	Fix abuse of set_bit in winbond-840		(me)
*	Fix abuse of set_bit in atp			(me)
