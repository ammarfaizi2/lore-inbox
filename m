Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131418AbQLVBRY>; Thu, 21 Dec 2000 20:17:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131619AbQLVBRF>; Thu, 21 Dec 2000 20:17:05 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:27152 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131418AbQLVBRD>; Thu, 21 Dec 2000 20:17:03 -0500
Subject: Linux 2.4.0test12pre3ac4
To: linux-kernel@vger.kernel.org
Date: Fri, 22 Dec 2000 00:49:11 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E149GOX-0003s3-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is mostly so people can see what I have merged in my tree and what
has gone from it. The patch for the adventurous is in

	ftp://ftp.kernel.org/pub/linux/kernel/people/alan/2.4.0test/..

2.4.0test13pre3-ac4
o	Fix FPU emulation compile			(Adam Richter)
o	M68K/PPC makefile fixes				(Geert Uytterhoeven)
o	CCISS root= table				(Charles White)
o	E820 handling fixup				(Andrea Arcangeli)
o	Fix frame size on toshoboe			(Christian Gennerat)
o	Quota fixes/updates				(Jan Kara)
o	Fix keyspan usb config				(Hugh Blemings)
o	Fix module handling in usb serial		(Greg Kroah-Hartmann)
o	Work around a funny in the Solaris NFS client	(Neil Brown)
o	Fix sparc64 build of fusion drivers		(Eddie Dost)
o	Further NetROM tidies				(Hans Grobler)
o	Further rose fixes				(Hans Grobler)
o	Wireless include update				(Jean Tourrilhes)
o	Fix eepro module warnings			(Aristeu Filho)
o	Clean up config.h includes			(Niels Jensen)
o	Fix most of the netfilter oops cases		(David Miller)

2.4.0test13pre3-ac3 
o	Fix the patch file. Some stuff got corrupted. 

2.4.0test13pre3-ac2 adds
o	Resync with the powerpc folks			(Cort Dougan)
o	Fix appletalk config entry			(William McGonigle)
o	Documentation/script fixes			(Tim Waugh)
o	Parport experimental label fix			(Tim Waugh)
o	Update credits to add Hans Grobler		(Hans Grobler)
o	Make uhci return the same error code as the 	(David Brownell)
	other USB hub controllers
o	Merge Fusion drivers				(Steve Ralston)
o	BPQ ethernet tidy				(Hans Grobler)
o	Updated AX.25 tidy				(Hans Grobler)
o	Shared memory fixes				(Christoph Rohland)
o	Resync mac ethernet drivers			(Cort Dougan)
o	Fix missing memory barrier in bootp/dhcp code	(Cort Dougan)

2.4.0test13pre3-ac1 adds
o	Handle TLB flush reruns caused by APIC rexmit	(me)
o	Fix leak in link() syscall			(Christopher Yeoh)
o	Fix ramfs deadlock				(Al Viro)
o	Fix udf deadlock				(Al Viro)
o	Improve parport docs				(Tim Waugh)
o	Document some of the macros			(Tim Waugh)
o	Fix ppa timing issues				(Tim Waugh)
o	Mark the parport fifo code as experimental	(Tim Waugh)
o	Resynch ppa changelog				(Tim Waugh)
	| Tim please double check as I got offsets
o	Fix Yam driver for Linux 2.4test		(Hans Grobler)
o	Fix AF_ROSE sockets for 2.4			(Hans Grobler)
o	Fix AF_NETROM sockets for 2.4			(Hans Grobler)
o	Tidy AF_AX25 sockets for 2.4			(Hans Grobler)
o	Teach kernel-doc about const			(Jani Monoses)
o	Add documentation to the PCI api		(Jani Monoses)
o	Fix inode.c documentation			(Jani Monoses)
o	Push Davicom support into the main tulip driver	(Tobias Ringstrom)
o	First block of mkiss driver fixes		(Hans Grobler)
o	Fix bug in VFAT short name handling		(Nicolas Goutte)
o	Clean up the i810 driver			(Tjeerd Mulder)
o	RCPCI45 PCI cleanup fixes (mark 2)		(Rasmus Andersen)
o	Improve the ALSxxx sound driver documentation	(Jonathan Woithe)
o	Fix ext2 modular build				(Jeff Raubitschek)
o	Fix bug in scripts/Configure.in matching	(Matthew Wilcox)
o	Revert accidental amifb change			(Geert Uytterhoeven)
o	Fix ext2 file size limiting for large files	(Andreas Dilger)
o	Clean up misleading indenting in partition code	(JAmes Antill)
o	Update SiS video drivers			(Can-Ru Yeou)
o	Yamaha audio doc fix				(Pavel Roskin)
o	Fix ACPI driver wakeup races			(David Woodhouse)
o	Remove bogus asserts in 8139too driver		(Jeff Garzik)
o	Fix timeout problms with rocktports at 249 days
o	Update acenic patches				(Jes Sorensen)
o	Fix i810 tco locking				(me)
o	Fix media makefiles				(me)
o	Fix drm makefiles				(Peter Samuelson)

2.4.0test12-ac1 adds
o	ARM bootup/initd fixes				(Russell King)
o	Fix ymf_sb setup bug				(Pavel Roskin)
o	Correctly print names of md10+			(me)
	[Based on code from Roberto Ragusa]
o	Fix sound crashes in various drivers		(Tjeerd Mulder)
o	Update epic100 to new pci api			(Francois Romieu)
o	Fix IOC/SIOC ioctl problems in ac97 code	(Dick Streefland)

To merge
o	Fix Ruffian Alpha boot				(Ivan Kokshaysky)
o	Bridge handling patches needed for Alpha	(Ivan Kokshaysky /
							Richard Henderson)
o	FPU emulator source set for m68k 		(Geert Uytterhoeven)
o	Fix m68k build with rmw disabled		(Geert Uytterhoeven)
o	Cleanup ramdisk namespace			(Jeff Garzik)
o	Link correctly with ACPI on ACPI_INTERPRETER off
o	Ramdisk missing blkdev_put
o	Acenic update
o	Epic100 update
o	Support mixed pnp and legacy sb cards
o	Hopefully fix the bugs in the FAT and HPFS file systems that
	caused fs corruption
o	Fix cramfs vanishing data bug
o	Fix NLS config.in bug for SMB
o	Power management locking fixes
o	filemap posix compliance fix
o	Fix pte handling race
o	Remove unneeded inits to 0 in ide code	  (Bartlomiej Zolnierkiewicz)
o	IDE documentation fixes			  (Bartlomiej Zolnierkiewicz)

Submitted to Linus
o	Add firestream ATM driver		     (Patrick van de Lageweg)
o	Add the powermac extras to the input and	(Franz Sirl)
	keyboard drivers
o	Fix reference counting in ATM		     (Patrick van de Lageweg)
o	Update Changes to give correct modutils rev	(Steven Cole)
o	Fix xconfig/menuconfig problems with config  (Andrzej Krzysztofowicz)
	scripts in 2.4test
o	Fix kd_mksound declaration			(Geert Uytterhoeven)
o	Fix warning in sim710 driver			(Pavel Rabel)
o	Merge bttv 0.7.50				(Gerd Knorr)
o	Clean it up to use pci_pci_quirks properly	(me)
o	SMC token ring driver update			(Jay Schulist)
o	Support kgcc autodetect
o	Rusty's fixes/review of unsafe set_bit usage
	(A few left to go)
o	I2C bus driver updates				(Frodo Looijaard)
o	Fix pcmcia ordering on socket remove		(David Woodhouse)
o	Update USB documentation			(Greg Kroah-Hartmann)
o	Tidy the tachyon 5526 driver			(Rasmus Andersen)
o	Clean old old compile time config stuff from	(Pavel Rabel)
	mad16 driver
o	Tidy riscom8 and sx namespace			(Jeff Garzik)
o	Rename block_til_ready in generic_serial      (Patrick van de Lageweg)

Merged by Linus from -ac or direct
o	Add clocking option to maestro (broken laptop	(me)
	stuff again)
o	Put back the module locking in soundcore	(David Schleef)
	that someone disabled
o	Abyss driver cleanup				(Jeff Garzik)
o	Fix most of the tq changes			(Mohammad A. Haque)
o	DOC1000 driver fixes				(David Woodhouse)
o	Switch tvaudio and msp3400 to use up_and_exit	(David Woodhouse)
o	usb-uhci was using constants not flags for	(Jeff Garzik)
	pci interface
o	Small fix for kdoc				(Tim Waugh)
o	Fix nubus build					(Geert Uytterhoeven)
o	atari/sun3lance update				(Geert Uytterhoeven)
o	Amiga gayle pcmcia fixups			(Geert Uytterhoeven)
o	Fixes for amiga scsi drivers			(Geert Uytterhoeven)
o	Simplify amiga irq handling code		(Geert Uytterhoeven)
o	Amiga sound/fb driver update			(Geert Uytterhoeven)
o	Amiga/Mac/Atari keyboard driver changes		(Geert Uytterhoeven)
o	Integrate atari stram with bootmem 		(Geert Uytterhoeven)
o	Restore atafb_fix that someone deleted		(Geert Uytterhoeven)
o	m68k include updates for 64bit structs		(Geert Uytterhoeven)
o	Add driver for MVME147 onboard scsi		(Geert Uytterhoeven)
o	Enable Q40 ide interface			(Geert Uytterhoeven)
o	Replace init with initdata in places on m68k	(Geert Uytterhoeven)
o	MMU code changes for m68k			(Geert Uytterhoeven)
o	dma_addr_t and other minor updates for m68k	(Geert Uytterhoeven)
o	m68k ptrace update 				(Geert Uytterhoeven)
o	Fix pmc551 when used without bugfix enabled	(David Woodhouse)
o	Fix endianness on ftl layer			(David Woodhouse)
o	Fix atm build					(Markus Kossmann)
o	Update 8139too driver				(Jeff Garzik)
o	Fix readdir returns on procfs			(Matt Kraai)
o	Make SET_MODULE_OWNER macro safer		(Jeff Garzik)
o	Hisax needed __init				(Jeff Garzik)
o	APM updates, fix the Dell 5000e check for APM=m	(Stephen Rothwell)
o	Fix module initialization oops 			(Keith Owens)
o	Clean up Abyss driver				(Jeff Garzik)
o	Fix raid linking order				(Neil Brown)
o	Cleanup console_verbose() duplication
o	Radio driver cleanups
o	BTTV radio config option
o	Fix qcam VIDIOCGWIN bugs
o	8390 seperate tx timeout path
o	Tulip crash fix on weird eeproms
o	ISAPnP hang on boot port fix
o	Maestro pci_enable fix
o	Fix function prototype in wacom drivr
o	Fix SCSI / PCI dependancies			(Jeff Garzik)
o	m68k config fixes				(Geert Uytterhoeven)
o	Fix dquot overflow/recovery			(Jan Kara)
o	Make uid16 macros safer				(Andreas Schwab)
o	Fix missing Config doc and sound doc error	(Thierry Vignaud)
o	APM update 					(Stephen Rothwell)
o	Fix SMP build on x86				(Steven Cole)
o	Maestro ioctl locking fix			(Zach Brown)
o	Make console_* static inline not extern		(Jeff Garzik)
o	Work arounds for broken Dell laptop APM		(me)
o	Fix aha1542 memory scribbles			(Phil Stracchino)
o	Fix ide scsi printk				(Geert Uytterhoeven)
o	Update EATA driver and Ultrastor driver		(Dario Ballabio)
o	Clean up printk formatting in a few drivers	(me)
o	Documentation for CONFIG_TOSHIBA
o	Updated version of Rusty's kernel-hacking doc
o	Updated SubmittingDrivers
o	Added SubmittingPatches
o	Updated procfs docs
o	Updated initrd docs
o	Tidy network drivers module locking		(Jeff Garzik)
	(Some in, a few to go)
o	Alpha PCI fixes (update resource not __init,	(Ivan Kokshaysky)
	off by one on check)
o	Fix warning in rclan driver			(Rasmus Andersen)
o	Clean up rcpci driver (new style pci etc)	(Jeff Garzik)
o	Fix generic bitops bugs
o	Fix pcnet32 printk problems			(Vojtech Pavlik)
o	Network driver check/request region fixes
o	MDAcon cleanup					(Pavel Rabel)
o	Tidy up mad16 driver				(Pavel Rabel)

Superceded by other fixes
o	Features is back to flags for compatibility	(me)
o	MTRR updates (36bit etc)
o	Dont crash on boot with a dual cpu board holding a non intel cpu
o	CS46xx update
o	NFS atomic fixes				(Trond Myklebust)
o	Fix O_SYNC for ext2fs				(Stephen Tweedie)
	[ I believe so anyway ]
o	Disable PMC511 driver - its obviously broken	(me)
o	kbuild documentation improvements		(Neil Brown)
o	Fix ppa and imm hangs on io_request_lock	(Tim Waugh)
o	Fix pport reverse/forward logic error		(Tim Waugh)
o	ACPI updates					(Andrew Grover)

Other

---
Alan Cox <alan@lxorguk.ukuu.org.uk>
Red Hat Kernel Hacker
& Linux 2.2 Maintainer                        Brainbench MVP for TCP/IP
http://www.linux.org.uk/diary                 http://www.brainbench.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
