Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261717AbSJFRGK>; Sun, 6 Oct 2002 13:06:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261724AbSJFRGK>; Sun, 6 Oct 2002 13:06:10 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:2834 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S261717AbSJFRGH>; Sun, 6 Oct 2002 13:06:07 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200210061711.g96HBik22919@devserv.devel.redhat.com>
Subject: Linux 2.5.40-ac5
To: linux-kernel@vger.kernel.org
Date: Sun, 6 Oct 2002 13:11:44 -0400 (EDT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux 2.5.40-ac5
o	Rework S/390 driver init sequences		(Martin Schwidefsky)
o	Swap immediate_bh for tasklets for s/390 3215	(Martin Schwidefsky)
o	UML updates - crash fixes, driver cleanup	(Jeff Dike)
	pcap transport
o	Switch fmi radio card to sleeping waits		(me)
o	Fixing missing printk \n in fmi radio		(me)
o	Update to newer uclinux patch			(Greg Ungerer)
	| Unresolved now:
	| fs/exec.c kernel/fork.c procfs sysctl
	| can nommu be folded in (Hch)
o	Remove surplus irq_disable from mpt fusion	(Carlos Gorges)
o	Export gdt for APM				(Carlos Gorges)
	| Marked as _GPL because its deep internals stuff
o	Merge the add/put disk gendisk changes for i2o	(Al Viro)
o	Switch NCR5380/g_NCR5380 to new_eh		(me)
o	Fix cs89x0 netdevice init as module		(me)
o	Change some of the wd7000 code to use
	udelay and do other cleanups
o	Switch wd7000 to new_eh				(me)
o	Serial driver updates				(Russell King)
o	Sync bluetooth with 2.4, fix SMP, hotplug	(Maksim Krasnyanskiy)
	support L2CAP, BNEP, HCI filter etc
o	Move firmwareloading to hotplug for bluetooth	(Maksim Krasnyanskiy)
o	Pull hpfs out of shared struct superblock	(Brian Gerst)
o	Fix sleep with pre-empt disabled in 		(Manfred Spraul)
	set_cpus_allowed

Linux 2.5.40-ac4
o	Make ibm partition code compile again		(Martin Schwidefsky)
o	Remove unneeded config options on S/390		(Martin Schwidefsky)
o	Update DASD drivers				(Martin Schwidefsky)
o	Update S/390 xpram driver			(Martin Schwidefsky)
o	Replace S/390 BH code by tasklets		(Martin Schwidefsky)
o	Fix S/390 bitops bugs				(Martin Schwidefsky)
o	S/390x 31bit emulation fixes			(Martin Schwidefsky)
o	Update S/390 link scripts			(Martin Schwidefsky)
o	Add S/390 pre-empt support			(Martin Schwidefsky)
o	Inline some S/390 old compilers couldnt handle	(Martin Schwidefsky)
o	Use diag 44 for S/390x spinlocks		(Martin Schwidefsky)
o	Better S/390 timer handling			(Martin Schwidefsky)
o	S/390 code cleanups				(Martin Schwidefsky)
o	Clean up S/390 fpu load/stores			(Martin Schwidefsky)
o	DECnet updates for testing			(Steve Whitehouse)
o	Add console shutdown handling to S/390		(Martin Schwidefsky)
o	Remove some bogus S/390 sanity checks		(Martin Schwidefsky)
o	Clean up S/390 process irq			(Martin Schwidefsky)
o	Fix/simplify chpids handling on S/390		(Martin Schwidefsky)
o	No /proc/interrupts on S/390			(Martin Schwidefsky)
o	Remove now unneeded S/390 hack in init/main.c	(Martin Schwidefsky)
o	Clean up all the S/390 ptrace handling		(Martin Schwidefsky)
o	Fix build with local apic enabled		(James Bottomley)
o	Initial i2o_block merge of 2.4/2.5 code		(me)
	| Not yet functional
o	Initial i2o_scsi merge of 2.4/2.5 code		(me)
	| Needs dma mapping, 64bit, be and new_eh
o	Revert Ivan's pci change (breaks serverworks)
o	PCI serial oops fix				(William Irwin)
o	Remove dead wood from unistd.h			(Brian Gerst)
o	Fix bug in capget 				(Chris Wright)
o	Switch qnxfs to new style initializers		(Art Haas)
o	Recongize qnx v6 file systems			(Anders Larsen)
o	Kill off remaining pcibios_ users   (Greg "Ninja Turtle" Kroah-Hartmann)
o	Fix scsi debug for scsi scan changes		(Mike Anderson)
o	Fix some bugs in scsi error handling		(Mike Andersen)
o	Forward port RMK's 2.4 scsi fixes		(Mike Andersen)
o	Allow longer settle times for scsi reset	(Mike Andersen)
o	Hopefully improve error policies a bit		(Mike Andersen)

Linux 2.5.40-ac3
o	Resync telephony drivers with 2.4		(me)
	| Forward port security and other minor fixes
o	Fix aironet4500 build for tq changes		(me)
o	Fix keyspan USB warnings with gcc 3		(me)
o	Switch to the newer 2.4 depca driver		(me)
o	Re-merge depca fixes from 2.5.0->2.5.40]
o	Fix depca spinning waiting for irq probe	(me)
o	Fix depca copy with interrupts off		(me)
o	Fix depca clash with other ALIGN macros		(me)
o	Initial port of NCR5380/g_NCR5380 to new locks	(me)
	| This still needs new_eh, further clean up
	| and possibly making NCR5380_main a thread
o	Initial locking rework for the wd7000 scsi	(me)
	| Still needs new_eh
o	Update jffs to the dequeue_signal changes	(me)
o	Update jffs2 to the dequeue_signal changes	(me)
o	Fix shpnt misuse in NCR53c406a, wrong free_irq	(me)
o	Update NCR53c406a to new style sglist		(me)
	| Still needs new_eh
o	Architecture updates for S/390			(Martin Schwidefsky)
o	Include updates for S/390			(Martin Schwidefsky)
o	Base S/390 driver updates			(Martin Schwidefsky)
o	Add the new syscalls to S/390			(Martin Schwidefsky)
o	Fix sleeping with locks in sound_core		(Jaroslav Kysela)
o	Fix oops on shutdown of cs4281			(Suresh Siddha)
o	Fix cdrom paths in devfs			(Jordan Breeding)
o	Fix missing cache tag entry in intel cpu table	(Jean Delvare)
o	Remove old 2.2 compatibility pci functions	(Greg Kroah-Hartmann)
o	Clean up some dead devfs bits			(Greg Kroah-Hartmann)
o	Fix an oops in the hugetblpage stuff		(Andrew Morton)
	| Its still a stupid idea but now it doesnt oops
o	Handle read only BARs with type bits set	(Ivan Kokshaysky)

Linux 2.5.40-ac2
o	Fix a cut and paste error in the amd rng docs	(Troels Hansen)
o	Forward port OSS maestro3 fixes for toughbook
o	Forward port ramdisk cache coherency
o	RTL8150 USB updates				(Petko Manalov)
o	Fix corega USB ident				(Petko Manalov)
o	USB keyboard driver fix				(Dave Miller)
o	USB prototype fix				(Luc Vanoostenryck)
o	USB string fixes		(cip307@cip.physik.uni-wuerzburg.de)
o	USB test driver					(David Brownell)
o	Speedtouch USB driver fixes			(Greg Kroah-Hartmann)
o	Clean environment for hotplug			(Greg Kroah-Hartmann)
o	Fix mprotect oops				(Hugh Dickins)
o	NUMA-Q cleanups					(Martin Dobson)
o	Split timers into one x86 timer type per file	(John Stultz)
o	Cyclone timer support for x440 etc		(John Stultz)
o	Fix sleeping from illegal context for ioperm	(Andrew Morton)
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
o	Fix missing header in longhaul cpu speed driver	(me)
o	Pipe read/write cleanup				(Manfred Spraul)
o	Make IDE PCI config text clearer	(Andrzej Krzysztofowicz)

Linux 2.5.40-ac1
+	Initial port of aacraid driver to 2.5		(me)
+	vfat corruption fix				(Petr Vandrovec)
+	Clean up firestream warnings			(Francois Romieu)
+	Voyager support					(James Bottomley)
+	Fix split_vma					(Hugh Dickins)
+	Fix config in video subdirectory		(John Levon)
+	Update olympic driver to 2.5			(Mike Phillips)
+	Fix sg init error				(Mike Anderson)
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
+	Stick tulip back under 10/100 ethernet		(me)
+	Correct docs for IBM touchpad back to how	(me)
	they were before
o	Fix abuse of set_bit in winbond-840		(me)
+	Fix abuse of set_bit in atp			(me)
