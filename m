Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261299AbSJLWdi>; Sat, 12 Oct 2002 18:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261317AbSJLWdi>; Sat, 12 Oct 2002 18:33:38 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:61314 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S261299AbSJLWde>; Sat, 12 Oct 2002 18:33:34 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200210122239.g9CMdOj10740@devserv.devel.redhat.com>
Subject: Linux 2.5.42-ac1
To: linux-kernel@vger.kernel.org
Date: Sat, 12 Oct 2002 18:39:24 -0400 (EDT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

** I strongly recommend saying N to IDE TCQ options otherwise this
   should hopefully build and run happily.


Linux 2.5.42-ac1
	Merge with Linus 2.5.42
o	Merge the LVM2 device mapper			(Joe Thornber)
o	Drop uid16 S/390 bits pending resolution	(me)
o	Fix iphase build				(Adrian Bunk)
o	Fix UML build					(Kai Germaschewski)
o	Fix cpufreq compile				(Adrian Bunk)
o	Move dead verify_area code from sh port		(Brian Gerst)
o	Fix missing AIO symbols				(Ben LaHaise)
o	Fix ATM makefile				(Sam Ravnborg)
o	Fix esp build					(Andres Salmon)
o	Fix cifs/jfs symbol name collision		(Steve F)
o	Update CPIA to match 2.4 tree			(Duncan Haldane)
o	Fix cifs 64bit and cifs scsi name collision	(Steve F)
o	Fix a compile of missing sysrq updates		(James Simmons)
o	Fix sparc timer build				(Pete Zaitcev)
o	Fix comile without networking			(Miles Bader)
o	Remove some left over _ret functions		(SL Baur)
o	Update syncppp code				(Paul Fulghum)
o	Fix n_hdlc leak					(Paul Fulghum)
o	Make synclink_cs build again			(Paul Fulghum)
o	Make synclinkmp build again			(Paul Fulghum)
o	Make synclink build again			(Paul Fulghum)
o	Fix NFS symbols for NFS as a module		(Olaf Dietsche)
o	Fix problem with scsidriver docbook		(Joaquim Fellmann)
o	Kill dead suspend code in IDE			(Pavel Machek)
o	Kill unreferenced workqueue define		(Pavel Machek)
o	Fix swsuspend with discontiguous memory bits	(Pavel Machek)
o	Fix cpqfc ioctl sense buffer handling		(Francis Wiran)
o	Sym53c416 from cli to real locking		(Bjoern Zeeb)
o	Fix a case where sd uses freed memory		(Patrick Mansfield)
o	Fix p4-clockmod on HT processors		(Dominic Brodowski)
o	CPUfreq interface update			(Dominic Brodowski)
o	Fix eicon build					(me)
o	Restore disconnect field in devices for		(me)
	driver use

Linux 2.5.41-ac2
o	Fix jffs/jffs2 properly this time (bpbb)	(me)
o	Fix jffs2 for workqueues			(me)
o	Next set of i2o_scsi update work		(me)
*	Do the 2.5 checkup pass on the 3c501 driver	(me)
o	Add missing exports for file system modules	(Nikita Danilov)
	on UML
*	Fix ipx proc permission bogosity	(Arnaldo Carvalho de Melo)
o	Switch appletalk spinlocks to rwlocks	(Arnaldo Carvalho de Melo)
o	Correct sys_getpid docs				(Robert Love)
o	SubmittingPatches indent fix			(John Levon)
*	cciss, cpqarray. rd. hd fixes			(Al Viro)
*	Fix cpia with gcc 3.2				(Randy Dunlap)
*	Use C99 structure initializers in IDE		(Art Haas)
*	Use C99 structure initializers in HFS		(Art Haas)
o	Update DMI scanner				(Jean Delvare)
o	Fix bogus types in ide-cd.h			(Skip Ford)
*	ns83820 updates					(Ben LaHaise)
*	AIO updates					(Ben LaHaise)
o	Beeping and sysrq on m68k			(Vojtech Pavlik)
o	Improve hid naming				(Vojtech Pavlik)
*	LSM docs					(Greg Kroah-Hartmann)
*	Merge UML updates				(Jeff Dike)
*	Final superblock union cleanup			(Brian Gerst)
-	Fix atm build/makefile breakage			(Adrian Bunk)
*	Brlock optimisation				(Robert Love)
*	Miscellaneous USB updates			(Greg Kroah-Hartmann)
o	MPT Fusion update				(Pam Delaney)
o	Back out sched.c change - seem,s to cause hangs	(me)
o	Serial compile fix				(Russell King)
*	S/390 compile fixes				(Martin Schwidefsky)
*	S/390 workqueue updates				(Martin Schwidefsky)
*	Switch 3215/3270 from work queue to tasklet	(Martin Schwidefsky)
*	Update S/390 link scripts			(Martin Schwidefsky)
*	Remove duplicate S/390 memset			(Martin Schwidefsky)
*	Fix S/390 syscall tracing			(Martin Schwidefsky)
*	Multiple 3270 fixes				(Martin Schwidefsky)
o	Configurable core names				(Jes Rahbek Klinke)
o	Clean up s/390x 16bit uid calls			(Martin Schwidefsky)
o	Fix EH locking on NCR5380			(me)
	| Should now work on SMP boxes (badly admittedly)
*	Indent wd7000 (no code changes)			(me)
*	First pass at the in2000 scsi driver		(me)
	| New locking, new_eh, address conversion

Linux 2.5.41-ac1
-	Merge with Linus 2.5.41
	- Drop S/390 drivers subtree for Linus
	- Drop task queue fixes for schedule_work
	- TODO: merge two sets of conflicting UML changes
	- TODO: double check bluetooth merge
*	Fix aacraid makefile				(Mark Haverkamp)
o	Fix ips compile					(Paul Larson)
*	Fix aha152x compile				(Michel Eyckmans)
*	Fix orinoco_cs compile		(Wichert Akkerman, Martin Waitz)
*	Fix i2o_core compiler				(Gregoire Favre)
o	Fix missing exports for netfilter
o	Fix compile failure in jffs			(me)
o	Fix compile failure in jffs2			(me)
*	Fix Divas_Mod compile				(me)
*	Fix hisax compile				(me)
*	Fix ipacx compile				(me)
*	Fix pcbit compile				(me)
*	Fix tpam compile				(me)
o	Fix i2o_lan build				(me)
*	Fix i2o_proc build				(me)
*	Fix ppa compile					(me)
*	Fix imm compile					(me)
*	Fix ipv6 compile				(me)



Linux 2.5.40-ac6
*	Cadet_wake can be static			(me)
o	Bluetooth configuration cleanups		(Marcel Holtmann)
o	Hardwired empty bar handling fix take two	(Ivan Kokshaysky)
o	Use kernel crc32 lib for bluetooth		(Marcel Holtmann)
o	Make scsi cdrom honour passed timeouts		(Peter Osterlund)
*	Make aironet4500_cs compile			(me)
*	Fix bugs where ibmtr unmapped the wrong address	(me)
o	Fix crash problem in oss dmabuf.c		(me)
	| Its still very broken but ALSA should replace it
*	Fix opl3sa2 warnings				(me)
*	Make tcic compile again				(me)
*	Make i82365 also use del_timer_sync		(me)
*	Fix warnings in fpu emulator			(me)
*	Fix t128 for NCR5380 changes			(me)
*	Fix pas16 for NCR5380 changes			(me)
*	Fix dmx3191 for NCR538 changes			(me)
*	First pass seagate st02 cleanups		(me)
*	Clean up de600 driver. Switch to spinlocks	(me)
	remove crud, formatting junk etc
	| Still needs rewriting to use parport
o	Remove extra unlock in wd7000			(Matthew Wilcox)
o	First basic pass at qlogicgas			(me)
*	Clean up the fdomain isa scsi			(me)
*	Clean up max_thread setting limits		(Matthew Wilcox)
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
*	DECnet updates for testing			(Steve Whitehouse)
*	Add console shutdown handling to S/390		(Martin Schwidefsky)
*	Remove some bogus S/390 sanity checks		(Martin Schwidefsky)
*	Clean up S/390 process irq			(Martin Schwidefsky)
o	Fix/simplify chpids handling on S/390		(Martin Schwidefsky)
*	No /proc/interrupts on S/390			(Martin Schwidefsky)
o	Remove now unneeded S/390 hack in init/main.c	(Martin Schwidefsky)
o	Clean up all the S/390 ptrace handling		(Martin Schwidefsky)
o	Fix build with local apic enabled		(James Bottomley)
*	Initial i2o_block merge of 2.4/2.5 code		(me)
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
*	Fix aironet4500 build for tq changes		(me)
o	Fix keyspan USB warnings with gcc 3		(me)
*	Switch to the newer 2.4 depca driver		(me)
*	Re-merge depca fixes from 2.5.0->2.5.40]
*	Fix depca spinning waiting for irq probe	(me)
*	Fix depca copy with interrupts off		(me)
*	Fix depca clash with other ALIGN macros		(me)
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
*	Fix a typo and other header			(me)
*	Fix up ixj_pcmcia for 2.5			(me)
	| Note for janitors - it looks like a lot of the pcmcia release
	| code people "fixed" should be using del_timer_sync not del_timer
*	Fix missing header in longhaul cpu speed driver	(me)
*	Pipe read/write cleanup				(Manfred Spraul)
*	Make IDE PCI config text clearer	(Andrzej Krzysztofowicz)

Linux 2.5.40-ac1
*	Initial port of aacraid driver to 2.5		(me)
*	vfat corruption fix				(Petr Vandrovec)
*	Clean up firestream warnings			(Francois Romieu)
+	Voyager support					(James Bottomley)
*	Fix split_vma					(Hugh Dickins)
+	Fix config in video subdirectory		(John Levon)
*	Update olympic driver to 2.5			(Mike Phillips)
*	Fix sg init error				(Mike Anderson)
*	Fix Rules.make
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
