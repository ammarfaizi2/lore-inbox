Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261363AbSJYKN2>; Fri, 25 Oct 2002 06:13:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261364AbSJYKN2>; Fri, 25 Oct 2002 06:13:28 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:20724 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S261363AbSJYKM7>; Fri, 25 Oct 2002 06:12:59 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200210251019.g9PAJ8V14406@devserv.devel.redhat.com>
Subject: Linux 2.5.44-ac3
To: linux-kernel@vger.kernel.org
Date: Fri, 25 Oct 2002 06:19:08 -0400 (EDT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

** I strongly recommend saying N to IDE TCQ options otherwise this
   should hopefully build and run happily.

   Doug's scsi changes broke mptfusion. I've not looked into that yet
   also u14f/u34f.

   This one builds, its not yet had any measurable testing

Linux 2.5.44-ac3
o	Update the cciss driver				(Stephen Cameron)
o	Fix seagate st02 unload				(me)
o	Fix missing \n in i810 driver			(me)
o	Update Ninja SCSI PCMCIA driver			(Yokota Hiroshi)
o	Clean up and kill off scsi_merge		(Christoph Hellwig)
o	Remove niceness magic numbers			(Randy Dunlap)
o	Update EDD support				(Matt Domsch)
o	Update voyager support for IRQ stacks		(James Bottomley)
-	Revert do_mounts change
o	Better fix for raw.c headers			(Bjoern Zeeb)
o	Fix ehci enumeration breakage			(David Brownell)
o	Update adv7175 to new style i2c			(Frank Davis)
o	PnP updates					(Adam Belay)
o	PnP conversion of CS423x to new code		(Adam Belay)
o	Fix APM BUG() on SMP boxes, port forward 2.4	(me)
	changes
o	Update other Digi URLS				(me)

Linux 2.5.44-ac2
o	Merge interrupt stack support for x86		(David Hansen,
							 Ben LaHaise)
o	Update ACPI to the latest released patch	(Andrew Grover,
	| Should fix the compaq problems	Ducrot Bruno, Pavel Machek)
o	Kill old STATIC define in do_mounts		(Frank Davis)
o	Port NCR5380 to the latest kernel changes	(me)
o	Update Digi EPCA maintainer info		(Scott Kilau)
o	Update LVM2 device mapper	(Joe Thornber, Christoph Hellwig)
o	EATA updates					(Dario Ballabio)
o	Fix remaining depca ioctl bug			(Peter Denison)
o	Make cifs error invalid addresses nicely	(Zwane Mwaikambo)
o	Fix cifs oops on kmalloc failure		(Zwane Mwaikambo)
o	Propogate return value on cifs connect		(Zwane Mwaikambo)
o	cifs locking changes				(Zwane Mwaikambo)
o	Fix cifs oops with invalid unc			(Zwane Mwaikambo)
o	Resync voyager architecture support		(James Bottomley)
o	Spot synaptics touchpad so we dont confuse it	(David Woodhouse)
o	Quieten bttv debugging a bit			(Bongani)
o	Rip out lots of the left over pcibios_ stuff	(Greg Kroah-Hartmann)
o	Fix reiserfs build				(Steven Cole)
o	Further cpia driver updates			(Duncan Haldane)
o	Kill tqueue.h in various other files		(Martin Waitz)
o	Update IRDA maintainer data			(Pawel Kot)
o	Add in missing read_barrier_depends for sparc	(Dipankar Sarma)
o	Make afs compile with older gcc			(Jan Marek)
o	2.5.44 UML updates				(Jeff Dike)
o	Fix kmap bugs in fs/exec.c for upgrowing	(Marcus Alanen)
	stack
o	Add ethtool support to ewrk3			(Adam Kropelin)
o	Fix up cli/sti use in ewrk3			(Denis Vlasenko)
o	ewrk3 ioctl fixes				(Adam Kropelin)
o	Cleanup ewrk3 signature code			(Adam Kropelin)
o	Fix task state reporting			(Daniel Jacobowitz)
o	Handle casio fiva weirdness with APM extents	(Hiroshi Miura)
o	Add Geode target that defines OOSTORE		(Hiroshi Miura, me)
o	Remove dodgy_tsc handling code			(Hiroshi Miura)
o	Update problem PIT handling on 5510/5520	(Hiroshi Miura)
	Cyrix devices, re-enable TSC on it
o	Use outb_p on CTC load up			(Hiroshi Miura)
o	Mark ide floppies as removable devices		(Paul Bristow)
o	Fix sym53c416 IRQ release problem		(me)
o	Update sym53c416 to new EH code			(me)
o	Fix subtractive decoding bridge handling	(Ivan Kokshaysky)
o	Fix wan driver build problems			(Krzysztof Halasa)
o	Allow for >32 signals on some platforms		(Matthew Wilcox)

Linux 2.5.44-ac1
-	Resync with Linus 2.5.43/44
o	Fix net/ipv4/raw.c build problem		(me)
o	Fix bluetooth pcmcia builds			(me)
o	Fix dm includes					(me)
	| I've not merged any of the DM updates yet
o	Fix 3c515, fealnx printk type warnings		(me)
o	Fix multi-line string literal in olympic driver	(me)
o	Fix printk type warnings in tulip		(me)
o	Document core naming sysctl			(Randy Dunlap)
o	Fix hd_struct size/offset bugs			(Mark Lord)
o	Further sym53c416 updates			(Bjoern Zeeb)
o	Fix ramdisk cache flush 			(Paul Mundt)
o	Fix pnp config.in for make Xconfig		(Roman Zippel)
o	Correct ncpfs marking of executables		(Petr Vandrovec)
o	Small matroxfb fixes				(Petr Vandrovec)
o	Small cleanups for i2o_block so Al can clean	(Al Viro)
	up the core block code
o	Fix hang at shutdown with offlined disk		(Mike Anderson)
o	Fix error reporting on scsi offline		(Mike Anderson)
o	Fix hang on power off with scsi			(Mike Anderson)
o	Fix typo in pnp.h				(Martin Dahl)
o	Remove tqueue.h from cycx_main			(Adrian Bunk)
o	Fix vlsi irda compile				(Adrian Bunk)
o	Fix hamradio makefile breakage			(Adrian Bunk)
o	Fix inia100 build				(John Fort)
o	Fix AX.25 build for ip_proc			(Dave Miller)
o	Fix aic7xxx Makefile				(Inaky Perez-Gonzalez)
o	Fix vga16fb					(Ben Pfaff)
o	Optimise spinlock to Intel recommendation	(Manfred Spraul)
o	Fix pipe wakeup bug				(Manfred Spraul)
o	Fix semop 32bit pid handling			(Manfred Spraul)
o	Fix qlogic1280 build				(Jens Axboe)
o	Merge BeOS fs (already in 2.4)			(Will Dyson,
							 Sergey Kostyliov)
o	Clean up wan ioctl structures			(Krzysztof Halasa)
o	Some trident audio takes a long time to		(Kenneth Sumrall)
	come up (Hitachi webpad)
o	Add DVB api and core				(Holger Waechtler)
o	Add one DVB driver so people can see how it	(Holger Waechtler)
	all fits together
	| This wants further review. There are known things to do yet
	| but its important to get the stuff in since Digital TV is 
	| becoming the norm in western europe.
o	Print something clueful if menuconfig explodes	(Russell King)
o	Move BUG() into asm/bug.h			(Russell King)
o	Report errors unzipping ramdisks		(Russell King)
o	Support extra weird numeric key on ARM boxes	(Russell King)
o	Fix missing devexit_p in tulip			(Andrey Panin)
o	Kill sr_host 					(Patrick Mansfield)
o	S/390 Makefile and Config updates		(Martin Scwidefsky)
o	S/390 user access fixes				(Martin Scwidefsky)
o	31bit emulation fixes for S/390			(Martin Scwidefsky)
o	Make S/390 possible cpu map volatile		(Martin Scwidefsky)
o	Update dasd drivers for S/390 series		(Martin Scwidefsky)
o	Update ver_linux				(Steven Cole)
o	Fix blk ioctls on aacraid			(Mark Haverkamp)
o	Fix SiS IDE build without procfs		(Lionel Bouton)
o	i386 verify write fixes				(Brian Gerst)
o	iphase ATM updates				(Francois Romieu)
o	Update i810-tco to C99 initializers		(Wim Van Sebroeck)
o	IDE updates for ARM platform			(Russell King)
o	Fix megaraid build				(Mike Anderson)
	| This may change the device order for some folks but it works
	| at least
o	Fix in2000 to handle scsi host list change	(me)
o	Fix ncr53c8xx build				(me)
o	Fix atp870u build				(me)
o	Fix nsp32 build					(me)
o	Fix firewire prototypes				(me)

Linux 2.5.42-ac1
	Merge with Linus 2.5.42
o	Merge the LVM2 device mapper			(Joe Thornber)
-	Drop uid16 S/390 bits pending resolution	(me)
*	Fix iphase build				(Adrian Bunk)
*	Fix UML build					(Kai Germaschewski)
*	Fix cpufreq compile				(Adrian Bunk)
o	Move dead verify_area code from sh port		(Brian Gerst)
*	Fix missing AIO symbols				(Ben LaHaise)
o	Fix ATM makefile				(Sam Ravnborg)
*	Fix esp build					(Andres Salmon)
*	Fix cifs/jfs symbol name collision		(Steve F)
*	Update CPIA to match 2.4 tree			(Duncan Haldane)
*	Fix cifs 64bit and cifs scsi name collision	(Steve F)
*	Fix a compile of missing sysrq updates		(James Simmons)
*	Fix sparc timer build				(Pete Zaitcev)
*	Fix comile without networking			(Miles Bader)
*	Remove some left over _ret functions		(SL Baur)
*	Update syncppp code				(Paul Fulghum)
*	Fix n_hdlc leak					(Paul Fulghum)
*	Make synclink_cs build again			(Paul Fulghum)
*	Make synclinkmp build again			(Paul Fulghum)
*	Make synclink build again			(Paul Fulghum)
o	Fix NFS symbols for NFS as a module		(Olaf Dietsche)
*	Fix problem with scsidriver docbook		(Joaquim Fellmann)
*	Kill dead suspend code in IDE			(Pavel Machek)
*	Kill unreferenced workqueue define		(Pavel Machek)
*	Fix swsuspend with discontiguous memory bits	(Pavel Machek)
*	Fix cpqfc ioctl sense buffer handling		(Francis Wiran)
*	Sym53c416 from cli to real locking		(Bjoern Zeeb)
*	Fix a case where sd uses freed memory		(Patrick Mansfield)
o	Fix p4-clockmod on HT processors		(Dominic Brodowski)
o	CPUfreq interface update			(Dominic Brodowski)
*	Fix eicon build					(me)
*	Restore disconnect field in devices for		(me)
	driver use

Linux 2.5.41-ac2
*	Fix jffs/jffs2 properly this time (bpbb)	(me)
*	Fix jffs2 for workqueues			(me)
*	Next set of i2o_scsi update work		(me)
*	Do the 2.5 checkup pass on the 3c501 driver	(me)
o	Add missing exports for file system modules	(Nikita Danilov)
	on UML
*	Fix ipx proc permission bogosity	(Arnaldo Carvalho de Melo)
*	Switch appletalk spinlocks to rwlocks	(Arnaldo Carvalho de Melo)
*	Correct sys_getpid docs				(Robert Love)
*	SubmittingPatches indent fix			(John Levon)
*	cciss, cpqarray. rd. hd fixes			(Al Viro)
*	Fix cpia with gcc 3.2				(Randy Dunlap)
*	Use C99 structure initializers in IDE		(Art Haas)
*	Use C99 structure initializers in HFS		(Art Haas)
*	Update DMI scanner				(Jean Delvare)
*	Fix bogus types in ide-cd.h			(Skip Ford)
*	ns83820 updates					(Ben LaHaise)
*	AIO updates					(Ben LaHaise)
*	Beeping and sysrq on m68k			(Vojtech Pavlik)
*	Improve hid naming				(Vojtech Pavlik)
*	LSM docs					(Greg Kroah-Hartmann)
*	Merge UML updates				(Jeff Dike)
*	Final superblock union cleanup			(Brian Gerst)
-	Fix atm build/makefile breakage			(Adrian Bunk)
*	Brlock optimisation				(Robert Love)
*	Miscellaneous USB updates			(Greg Kroah-Hartmann)
*	MPT Fusion update				(Pam Delaney)
-	Back out sched.c change - seem,s to cause hangs	(me)
*	Serial compile fix				(Russell King)
*	S/390 compile fixes				(Martin Schwidefsky)
*	S/390 workqueue updates				(Martin Schwidefsky)
*	Switch 3215/3270 from work queue to tasklet	(Martin Schwidefsky)
*	Update S/390 link scripts			(Martin Schwidefsky)
*	Remove duplicate S/390 memset			(Martin Schwidefsky)
*	Fix S/390 syscall tracing			(Martin Schwidefsky)
*	Multiple 3270 fixes				(Martin Schwidefsky)
*	Configurable core names				(Jes Rahbek Klinke)
X	Clean up s/390x 16bit uid calls			(Martin Schwidefsky)
*	Fix EH locking on NCR5380			(me)
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
*	Fix ips compile					(Paul Larson)
*	Fix aha152x compile				(Michel Eyckmans)
*	Fix orinoco_cs compile		(Wichert Akkerman, Martin Waitz)
*	Fix i2o_core compiler				(Gregoire Favre)
*	Fix missing exports for netfilter
*	Fix compile failure in jffs			(me)
*	Fix compile failure in jffs2			(me)
*	Fix Divas_Mod compile				(me)
*	Fix hisax compile				(me)
*	Fix ipacx compile				(me)
*	Fix pcbit compile				(me)
*	Fix tpam compile				(me)
*	Fix i2o_lan build				(me)
*	Fix i2o_proc build				(me)
*	Fix ppa compile					(me)
*	Fix imm compile					(me)
*	Fix ipv6 compile				(me)



Linux 2.5.40-ac6
*	Cadet_wake can be static			(me)
*	Bluetooth configuration cleanups		(Marcel Holtmann)
o	Hardwired empty bar handling fix take two	(Ivan Kokshaysky)
*	Use kernel crc32 lib for bluetooth		(Marcel Holtmann)
*	Make scsi cdrom honour passed timeouts		(Peter Osterlund)
*	Make aironet4500_cs compile			(me)
*	Fix bugs where ibmtr unmapped the wrong address	(me)
*	Fix crash problem in oss dmabuf.c		(me)
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
*	First basic pass at qlogicgas			(me)
*	Clean up the fdomain isa scsi			(me)
*	Clean up max_thread setting limits		(Matthew Wilcox)
*	Ricoh cardbus performance fix			(KOMURO)
*	Switch appletalk to seq_file /proc	(Arnaldo Carvalho de Melo)
*	Switch X.25 to seq_file			(Arnaldo Carvalho de Melo)
*	Fix bugs in the above			(Arnaldo Carvalho de Melo)

Linux 2.5.40-ac5
*	Rework S/390 driver init sequences		(Martin Schwidefsky)
*	Swap immediate_bh for tasklets for s/390 3215	(Martin Schwidefsky)
*	UML updates - crash fixes, driver cleanup	(Jeff Dike)
	pcap transport
*	Switch fmi radio card to sleeping waits		(me)
*	Fixing missing printk \n in fmi radio		(me)
o	Update to newer uclinux patch			(Greg Ungerer)
	| Unresolved now:
	| fs/exec.c kernel/fork.c procfs sysctl
	| can nommu be folded in (Hch)
*	Remove surplus irq_disable from mpt fusion	(Carlos Gorges)
*	Export gdt for APM				(Carlos Gorges)
	| Marked as _GPL because its deep internals stuff
*	Merge the add/put disk gendisk changes for i2o	(Al Viro)
*	Switch NCR5380/g_NCR5380 to new_eh		(me)
*	Fix cs89x0 netdevice init as module		(me)
*	Change some of the wd7000 code to use
	udelay and do other cleanups
*	Switch wd7000 to new_eh				(me)
*	Serial driver updates				(Russell King)
*	Sync bluetooth with 2.4, fix SMP, hotplug	(Maksim Krasnyanskiy)
	support L2CAP, BNEP, HCI filter etc
*	Move firmwareloading to hotplug for bluetooth	(Maksim Krasnyanskiy)
*	Pull hpfs out of shared struct superblock	(Brian Gerst)
X	Fix sleep with pre-empt disabled in 		(Manfred Spraul)
	set_cpus_allowed

Linux 2.5.40-ac4
*	Make ibm partition code compile again		(Martin Schwidefsky)
*	Remove unneeded config options on S/390		(Martin Schwidefsky)
*	Update DASD drivers				(Martin Schwidefsky)
*	Update S/390 xpram driver			(Martin Schwidefsky)
*	Replace S/390 BH code by tasklets		(Martin Schwidefsky)
*	Fix S/390 bitops bugs				(Martin Schwidefsky)
*	S/390x 31bit emulation fixes			(Martin Schwidefsky)
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
*	Fix/simplify chpids handling on S/390		(Martin Schwidefsky)
*	No /proc/interrupts on S/390			(Martin Schwidefsky)
*	Remove now unneeded S/390 hack in init/main.c	(Martin Schwidefsky)
*	Clean up all the S/390 ptrace handling		(Martin Schwidefsky)
o	Fix build with local apic enabled		(James Bottomley)
*	Initial i2o_block merge of 2.4/2.5 code		(me)
	| Not yet functional
*	Initial i2o_scsi merge of 2.4/2.5 code		(me)
	| Needs dma mapping, 64bit, be and new_eh
-	Revert Ivan's pci change (breaks serverworks)
*	PCI serial oops fix				(William Irwin)
*	Remove dead wood from unistd.h			(Brian Gerst)
o	Fix bug in capget 				(Chris Wright)
*	Switch qnxfs to new style initializers		(Art Haas)
o	Recongize qnx v6 file systems			(Anders Larsen)
*	Kill off remaining pcibios_ users   (Greg "Ninja Turtle" Kroah-Hartmann)
*	Fix scsi debug for scsi scan changes		(Mike Anderson)
*	Fix some bugs in scsi error handling		(Mike Andersen)
*	Forward port RMK's 2.4 scsi fixes		(Mike Andersen)
*	Allow longer settle times for scsi reset	(Mike Andersen)
*	Hopefully improve error policies a bit		(Mike Andersen)

Linux 2.5.40-ac3
*	Resync telephony drivers with 2.4		(me)
	| Forward port security and other minor fixes
*	Fix aironet4500 build for tq changes		(me)
*	Fix keyspan USB warnings with gcc 3		(me)
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
*	Include updates for S/390			(Martin Schwidefsky)
*	Base S/390 driver updates			(Martin Schwidefsky)
*	Add the new syscalls to S/390			(Martin Schwidefsky)
*	Fix sleeping with locks in sound_core		(Jaroslav Kysela)
*	Fix oops on shutdown of cs4281			(Suresh Siddha)
*	Fix cdrom paths in devfs			(Jordan Breeding)
*	Fix missing cache tag entry in intel cpu table	(Jean Delvare)
*	Remove old 2.2 compatibility pci functions	(Greg Kroah-Hartmann)
*	Clean up some dead devfs bits			(Greg Kroah-Hartmann)
*	Fix an oops in the hugetblpage stuff		(Andrew Morton)
	| Its still a stupid idea but now it doesnt oops
o	Handle read only BARs with type bits set	(Ivan Kokshaysky)

Linux 2.5.40-ac2
*	Fix a cut and paste error in the amd rng docs	(Troels Hansen)
*	Forward port OSS maestro3 fixes for toughbook
o	Forward port ramdisk cache coherency
*	RTL8150 USB updates				(Petko Manalov)
*	Fix corega USB ident				(Petko Manalov)
*	USB keyboard driver fix				(Dave Miller)
*	USB prototype fix				(Luc Vanoostenryck)
*	USB string fixes		(cip307@cip.physik.uni-wuerzburg.de)
*	USB test driver					(David Brownell)
*	Speedtouch USB driver fixes			(Greg Kroah-Hartmann)
*	Clean environment for hotplug			(Greg Kroah-Hartmann)
*	Fix mprotect oops				(Hugh Dickins)
o	NUMA-Q cleanups					(Martin Dobson)
*	Split timers into one x86 timer type per file	(John Stultz)
*	Cyclone timer support for x440 etc		(John Stultz)
*	Fix sleeping from illegal context for ioperm	(Andrew Morton)
*	Fix imm compile				(bonganilinux@mweb.co.za)
*	Fix irda for tq changes				(Carlos Gorges)
*	Fix xjack telephony build			(Carlos Gorges)
*	Fix ppa compile					(Carlos Gorges)
*	Fix aha152x compile for tq changes		(Carlos Gorges)
*	Fix hamradio drivers for tq changes		(Carlos Gorges)
*	Fix plip driver for tq changes			(Carlos Gorges)
*	Fix mpt fusion for tq changes			(Carlos Gorges)
*	Fix isdn for tq changes				(Carlos Gorges)
*	Fix ieee1394 for tq changes			(Carlos Gorges)
*	Fix new timer code to build with cpufreq on	(me)
*	Fix capi build for new tq_ code			(me)
	| ISDN still needs moving to real locks
	| this just cleans up one item
*	Fix missing header in mtdblock_ro		(Carlos Gorges)
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
