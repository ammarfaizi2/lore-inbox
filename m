Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288896AbSBRW5T>; Mon, 18 Feb 2002 17:57:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288870AbSBRW5B>; Mon, 18 Feb 2002 17:57:01 -0500
Received: from unused ([66.187.233.200]:28472 "EHLO devserv.devel.redhat.com")
	by vger.kernel.org with ESMTP id <S288878AbSBRW4i>;
	Mon, 18 Feb 2002 17:56:38 -0500
From: Alan Cox <alan@redhat.com>
Message-Id: <200202182256.g1IMuc310377@devserv.devel.redhat.com>
Subject: Linux 2.4.19-rc2-ac1
To: linux-kernel@vger.kernel.org
Date: Mon, 18 Feb 2002 17:56:38 -0500 (EST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[+ indicates stuff that went to Marcelo, o stuff that has not,
 * indicates stuff that is merged in mainstream now, X stuff that proved
   bad and was dropped out]

Linux 2.4.18rc2-ac1
o	Merge with 2.4.18rc2
o	Ignore i810 modem codecs			(me)
o	Core of address space accounting code		(me)
	| Enforcement, ptrace and some shmem corner bits to do
*	Fix security hole in shmfs			(me)
o	Fix various bits of 64bit file I/O in shmem	(me)
o	Merge with rmap12f				(Rik van Riel and co)

Linux 2.4.18pre9-ac4
o	SIS IDE driver update (handle with care)	(Lionel Bouton)
o	First set of I2O endian cleanups		(me)
o	Make i2o_pci.c 64bit/BE clean			(me)
o	Maybe fix crash on i2o scsi abort/reset paths	(me)
o	Make i2o use the passed scsi direction flag	(me)
o	Fix awk failure path in menuconfig		(Andrew Church)
o	Merge varies doc updates			(Steven Cole)
o	Add serial support for the Lava Octopus-550	(Jim Treadway)
o	OPL3SA2 cleanup					(Zwane Mwaikambo)
o	Add missing blkdev_varyio export		(Todd Roy)
o	Update Changes file, config and experimental	(Niels Jensen)
	checks
o	Fix highmem warning in aacraid			(Andrew Morton)
o	Make tpqic02 use new style request region	(Marcus Alanen)
o	Only turn off mediagx/geode TSC on 5510/5520	(me)
	| From information provided by Hiroshi MIURA
o	Massively clean up the AGP enable and bugfix it	(Bjorn Helgaas)
o	Fix oops if you try to use the RW wq locks	(Bob Miller)
o	Remove FPU usage in neomagic fb			(Denis Kropp)
o	Merge IBM JFS			(Steve Best, Dave Kleikamp, 
					 Barry Arndt, Christoph Hellwig, ..)
o	Updated sis frame buffer driver			(Thomas Winischhofer)

Linux 2.4.18pre9-ac3
o	Clean up various macros and misuse of ;		(Timothy Ball)
*	Correct procfs locking fixup			(Al Viro)
o	Speed up ext2/ext3 synchronous mounts		(Andrew Morton)
o	Update IDE DMA blacklist			(Jonathan Kamens)
o	Update to XFree86 DRM 4.2 (compatible to 4.1)	(Rik Faith, 
	and adds I830 DRM				 Jeff Hartmann,
							 Keith Whitwell,
							 Abraham vd Merwe
							 and others)
o	IBM Lanstreamer updates				(Mike Phillips)
o	Fix acct rlimit problem (I hope)		(me)
	| Problem noted by Ian Allen
o	Automatically set file limits based on mem size	(Andi Kleen)
o	Correct scsi reservation conflict handling	(James Bottomley)
	and add the scsi reset api code
o	Add further kernel docs				(me)
o	Merge to rmap-12e				(Rik van Riel and co)
	|merge patch from Nick Orlov
o	Small fix to the eata driver update		(Dario Ballabio)


Linux 2.4.18pre9-ac2
o	Nat Semi now use their own ident on the Geode	(Hiroshi Miura)
*	Put #error in two files that need FPU fixups	(me)
*	Correct a specific mmap return to match posix	(Christopher Yeoh)
*	Add Eepro100/VE ident				(Hanno Boeck)
o	Add provides for DRM to the kernel make rpm	(Alexander Hoogerhuis)
*	Fix a problem where vm86 irq releasing could be	(Stas Sergeev)
	missed
o	EATA and U14/34F driver updates			(Dario Ballabio)
o	Handle EMC storage arrays that report SCSI-2 	(Kurt Garloff)
	but want REPORT_LUNs
o	Update README, defconfig, remove autogen files	(Niels Jensen)
o	Add AFAVLAB PCI serial support			(Harald Welte)
*	Fix incorrect resource free in eexpress		(Gianluca Anzolin)
o	Variable size rawio optimisations		(Badari Pulavarty)
*	Add AT's compatible 8139 cardbus chip		(Go Taniguchi)
o	Fix crash with newest hpt ide chips		(Arjan van de Ven)
*	Fix tiny SMP race in pid selection		(Erik Hendriks)
o	Hopefully fix pnpbios crash caused by early	(me)
	kernel_thread creation

Linux 2.4.18pre9-ac1
o	Initial merge of DVD card driver  (Christian Wolff,Marcus Metzler)
	| This is just an initial testing piece. DVB needs merging
	| properly and this is only a first bit of testing
o	Random number generator support for AMD768	(me)
o	Add AMD768 to i810 driver pci ident list	(me)
o	Initial AMD768 power management work		(me)
	| Unfinished pending some docs clarifications
o	Fix bugbuf mishandling for modular es1370	(me)
*	Fix up i2o readl abuse, post_wait race, and	(me, Arjan van de Ven)
	some deadlock cases
*	Added cpu_relax to yam driver 			(me)
*	Fixup AMD762 if the BIOS apparently got it wrong(me)
	(eg ASUS boards)
*	MP1.4 alignment fixup
o	pcwd cleanup, backport of fixes from 2.5	(Rob Radez)
o	Add support for more Moxa cards to mxser	(Damian Wrobel)
o/*	Add remaining missing MODULE_LICENSE tags	(Hubert Mantel)
o	Fix floppy reservation ranges			(Anton Altaparmakov)
o	Fix max file size setup				(Andi Kleen)

Linux 2.4.18pre7-ac3
o	Fix a wrong error return in the megaraid driver	(Arjan van de Ven)
*	FreeVXFS update					(Christoph Hellwig)
+	Qnxfs update					(Anders Larsen)
o	Fix non compile with PCI=n			(Adrian Bunk)
o	Fix DRM 4.0 non compile in i810			(me)
o	Drop out now dead CLONE thread/parent fixup	(Dave McCracken)
*	Make NetROM incoming frame check stricter	(Tomi Manninen)
*	Use sock_orphan in AX.25/NetROM			(Jeroen PE1RXQ)
o	Pegasus update					(Petko Manolov)
o	Make reparent_to_init and exec_usermodehelper	(Andrew Morton)
	use set_user, fix a tiny set_user SMP race
o	Mark framebuffer mappings VM_IO			(Andrew Morton)
o	Neomagic frame buffer driver			(Denis Kropp)
	- Needs FPU code fixing before it can be merged
o	Hyperthreading awareness for MTRR driver
o	Correct NR_IRQ with no apic support		(Brian Gerst)
*	Fix missing includes in sound drivers		(Michal Jaegermann)

Linux 2.4.18pre7-ac2
*	i810 audio driver update			(Doug Ledford)
o	Early ioremap for x86 specific code		(Mikael Pettersson)
	| This is needed to do things like apic/dmi detect early enough
o	Pentium IV APIC/NMI watchdog			(Mikael Pettersson)
*	Add C1MRX support to sonypi driver		(Junichi Morita)
*	Fix "make rpm" with two '-' in extraversion	(Gerald Britton)
o	Fix aacraid hang/irq storm on i960 boards	(Chris Pascoe)
*	Fix isdn audio compiler behaviour dependancy	(Urs Thuermann)
*	YAM driver fixes				(Jean-Paul Roubelat)
*	ROSE protocol stack update/fixes		(Jean-Paul Roubelat)
o	Fix UFS/CDROM oops				(Zwane Mwaikambo)
o	Fix nm256 hang on Dell Latitude			(origin unknown)
	| Please test this tree with other NM256 based boxes and check
	| those still work...
o	Merge PnPBIOS patch		(Thomas Hood, David Hinds, Tom Lees,
					 Christian Schmidt, ..)
o	Merge new sis frame buffer drivers		(Thomas Winischhofer)
*	cs46xx oops fix					(Mike Gorse)
*	Fix a second cs46xx bug related to this		(me)
o	Fix acpitable oopses on boot and other problems	(James Cleverdon)
o	Fix io port type on the hpt366 driver		(Pete Popov)
o	Updated matrox drivers				(Petr Vandrovec)
*	IPchains fixes needed for 2.4.18pre7
o	IDE config text updates for the IDE patches	(Anton Altaparmakov)
o	Merge the first bits of ZV support		(Marcus Metzler)
o	Add initial ZV support to yenta socket driver	(me)
	for TI cards
*	Fix pirq routing on the CS5530 			(me)
	| Finally the palmax pcmcia/cardbus works properly

Linux 2.4.18pre7-ac1
o	Merge with 2.4.18pre7				(Arjan van de Ven)
	| + some quota fixups redone by me
	| several 18pre7 netfilter bugs left unfixed for now
o	Rmap-12a					(Rik van Riel and co)

Linux 2.4.18pre3-ac2

o	Re-merge the IDE patches			(Andre Hedrick and co)
*	Fix check/request region in ali_ircc and lowcomx(Steven Walter)
	com90xx, sealevel, sb1000
*	Remove unused message from 6pack driver		(Adrian Bunk)
*	Fix unused variable warning in i60scsi		(Adrian Bunk)
*	Fix off by one floppy oops			(Keith Owens)
o	Fix i2o_config use of undefined C		(Andreas Dilger)
*	Fix fdomain scsi oopses				(Per Larsson)
*	Fix sf16fmi hang on boot			(me)
o	Add bridge resources to the resource tree	(Ivan Kokshaysky)
*	Fix iphase ATM oops on close in on case	   (Till Immanuel Patzschke)
*	Enable OOSTORE on winchip processors		(Dave Jones, me)
	| Worth about 10-20% performance 
*	Code Page 1250 support				(Petr Titera)
*	Fix sdla and hpfs doc typos			(Sven Vermeulen)
o	Document /proc/stat				(Sven Heinicke)
*	Update cs4281 drivers				(Tom Woller)
	| Fixes xmms stutter, remove wrapper code
	| handle tosh boxes, allow record device change
	| trigger wakeups on ioctl triggered changes
+/o/X	Fix locking of file struct stuff found by ibm	(Dipankar Sarma)
	audit
o	Use spin_lock_init in serial.c			(Dave Miller)
*	Fix AF_UNIX shutdown bug			(Dave Miller)

Linux 2.4.18pre3-ac1

o	32bit uid quota
o	rmap-11b VM					(Rik van Riel,
							 William Irwin etc)
*	Make scsi printer visible			(Stefan Wieseckel)
*	Report Hercules Fortissimo card			(Minya Sorakinu)
*	Fix O_NDELAY close mishandling on the following	(me)
	sound cards: cmpci, cs46xx, es1370, es1371,
	esssolo1, sonicvibes
*	tdfx pixclock handling fix			(Jurriaan)
o	Fix mishandling of file system size limiting	(Andrea Arcangeli)
*	generic_serial cleanups				(Rasmus Andersen)
o	serial.c locking fixes for SMP - move from cli	(Kees)
	too
*	Truncate fixes from old -ac tree		(Andrew Morton)
*	Hopefully fix the i2o oops			(me)
	| Not the right fix but it'll do till I rewrite this
*	Fix non blocking tty blocking bug		(Peter Benie)
o	IRQ routing workaround for problem HP laptops	(Cory Bell)
*	Fix the rcpci driver				(Pete Popov)
*	Fix documentation of aedsp location		(Adrian Bunk)
*	Fix the worst of the APM ate my cpu problems	(Andreas Steinmetz)
*	Correct icmp documentation			(Pierre Lombard)
*	Multiple mxser crash on boot fix	(Stephan von Krawczynski)
o	ldm header fix					(Anton Altaparmakov)
*	Fix unchecked kmalloc in i2c_proc	(Ragnar Hojland Espinosa)
*	Fix unchecked kmalloc in airo_cs	(Ragnar Hojland Espinosa)
*	Fix unchecked kmalloc in btaudio	(Ragnar Hojland Espinosa)
*	Fix unchecked kmalloc in qnx4/inode.c	(Ragnar Hojland Espinosa)
*	Disable DRM4.1 GMX2000 driver (4.0 required)	(me)
*	Fix sb16 lower speed limit bug			(Jori Liesenborgs)
o	Fix compilation of orinoco driver		(Ben Herrenschmidt)
*	ISAPnP init fix					(Chris Rankin)
o	Export release_console_sem			(Andrew Morton)
*	Output nat crash fix				(Rusty Russell)
*	Fix PLIP					(Niels Jensen)
o	Natsemi driver hang fix				(Manfred Spraul)
*	Add mono/stereo reporting to gemtek pci radio	(Jonathan Hudson)

---
        I'd prefer the trees to be separate for testing purposes: it
        doens't make much sense to have SMP support as a normal kernel
        feature when most people won't have SMP anyway"
                        -- Linus Torvalds
