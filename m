Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130476AbRAHCZD>; Sun, 7 Jan 2001 21:25:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130802AbRAHCYy>; Sun, 7 Jan 2001 21:24:54 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:3858 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130476AbRAHCYo>; Sun, 7 Jan 2001 21:24:44 -0500
Subject: Linux 2.4.0-ac4
To: linux-kernel@vger.kernel.org
Date: Mon, 8 Jan 2001 02:26:34 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14FS17-0003lC-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Handle with care. I think the fs updates are right but I don't guarantee it.

	ftp://ftp.kernel.org/pub/linux/kernel/people/alan/2.4/

2.4.0-ac4
o	Fix dereference of freed skbuff in iphase	(Hans Grobler)
o	Fix dereference of freed skbuff in isdn_ppp	(Hans Grobler)
o	Fix dereference of freed skbuff in comx		(Hans Grobler)
o	Fix dereference of freed skbuff in atarilance	(Arnaldo Carvalho 
								de Melo)
o	Fix missing NULL check of dev_alloc_skb in	(Hans Grobler)
	hdlc layer
o	Fix vesafb typo					(Dag Wieers)
o	Z85230 driver cleanup				(Hans Grobler)
o	Remove spare restore_flags in de600		(Hans Grobler)
o	Catch failed kmallocs in ppc ethernet		(Hans Grobler)
o	AF_PACKET socket cleanup			(Hans Grobler)
o	ATAPI IDE format facility			(Sam Varshavchik)
	| Don't rely on the abi or anything yet, Gadi
	| the maintainer has yet to comment on it
o	Fix smc9194 crash on out of memory		(Hans Grobler)
o	Documentation fixes				(Dag Wieers)
o	Fusion driver updates				(Steve Ralston,
							 Eddie Dost,
							 Arnaldo Carvalho
							 de Melo)
o	Fix ramfs hangs					(me)
o	Fix assorted LFS problems and missing rlimit	(me)
	checks. In theory file size rules are now 
	right and properly enforced except for those
	folks not using generic_file_write who need to
	do their homework 8)

2.4.0-ac3
o	Add support for the newer 3c905 cards		(Andrew Morton)
o	Drop unused field from scc.h			(Hans Grobler)
o	Remove dead sysctl stuff from econet		(Hans Grobler)
o	Fix documentation indexes			(Paul Gortmaker)
o	Fix post free reference of an skb in lance	(Paul Gortmaker)
o	Tidy appletalk code				(Hans Grobler)
o	Fix bootup vesafb hang 				(David Wragg)
o	TCP 'reset_xmit_timer' fix			(Dave Miller)
o	Tidy up cursor positioning on menuconfig	(Kirk Reiser)
o	Add missing wait.h includes to some asm/semaphore
							(Hans Grobler)
o	AF_UNIX socket cleanup				(Hans Grobler)
o	Update sd locking fixes				(Oliver Neukum)
o	Add module locking to audio coprocessor calls	(Chris Rankin)
o	Minor further X.25 tidy				(Hans Grobler)
o	Fix scsi ioctl/scan crash on out of memory	(Douglas Gilbert)
o	Soundscape patches				(Chris Rankin)
o	M68K fixes for mem stats and stram		(Geert Uytterhoeven)
o	Set MSG_TRUNC correctly on atm sockets		(Matti Aarnio)
o	Add infrastructure for parport autoloading	(Adam J Richter)
o	Make lp driver use capable not old suser()	(Tim Waugh)
o	Fix thread/unload race on i2o block		(me)
o	Fix drivers that use asm/delay not linux/delay	(Geert Uytterhoeven)
o	Further warning fixes				(Rich Baum)
o	Netfilter config/Makefile fixes			(Dave Miller)
o	Merge updated cs4281 driver and tidy it		(Tom Woller)
	| some cleanups by me, possibly broken it ;)
o	Fix bagetlance reference of freed buffer (Arnaldo Carvalho de Melo)
o	ISDN small fixes				(Andrea Baldoni,
							 Daniel Stodden)
o	ESS Maestro 3 driver				(Zach Brown)

2.4.0-ac2
o	Clean up strip driver				(Hans Grobler)
o	Fix fore atm makefile				(Jan Rekorajski)
o	Fix m68k lance mismerge				(Geert Uytterhoeven)
o	Fix tty documentation typos			(Hans Grobler)
o	Fix ohci1394 build				(Arjan van de Ven)
o	Remove dead lapbether inits			(Hans Grobler)
o	Workaround the acpi recursive variable name	(Bill Wendling)
	Makefile problem
o	Further minor S/390 merge			(Ulrich Weigand)
o	Fix DRM build problem on ATI Rage 120/no AGP	(Gareth Hughes)
o	Fix mac address setting in 8139too		(Ben Greear)
o	AGP oops fix/ALi cleanup			(Bill Crawford)
o	Further DECnet cleanups				(Hans Grobler)
o	S/390 last fixes				(Ulrich Weigand)
o	Fix missing arlan symbol			(Hans Grobler)
o	Do basic IPX/SPX cleanups			(Hans Grobler)

2.4.0-ac1
o	Resync with Linus
o	Fix serial compile bug				(Bill Notthingham)
o	Clean up lapbether				(Hans Grobler)
o	Fix endian handling in ne.c			(Geert Uytterhoeven)
o	Fix root umount handling			(Chris Mason &
							 Al Viro)
o	Bring wan drivers up to scratch for 2.4		(Krzysztof Halasa)
o	SD module locking fix				(Oliver Neukum)
o	Merge S/390 32/64bit ports			(IBM)
	| some rough edges to tidy up yet - guys can
	| you change the DMA ifdefs to match 2.2 style..

2.4.0prerelease-ac6
o	Cleanup econet					(Hans Grobler)
o	Further amateur radio cleanups			(Hans Grobler)
o	Fix irda/SMP deadlocks				(Marc Zyngier)
o	Further YAM fixes				(Hans Grobler)
o	Fix rio500 locking bug				(Greg Kroah-Hartmann)
o	Fix isdn net leak on error		(Arnaldo Carvalho de Melo)
o	Fix proc_get_inode export (for comx)		(Hans Grobler)
o	Fix locking error on get_swap_page		(Marcelo Tosatti)
o	Fix further warnings, and other stuff new gcc	(Arjan van de Ven)
	shows up
o	Add isapnp module device tables to drivers	(Bill Nottingham)
	[Added to ns558, serial, ide-pnp, cadet,
	 3c509,3c515, aironet4500,ne,sb1000, aha1542,
	 NCR5380, ad1816, awe_wave, sb, ixj]
o	Resync with Linus prepatch

2.4.0prerelease-ac5
o	Resync with Linus prepatch
o	One liner microcode driver fix			(Tigran Aivazian)
o	Fix ACPI ksyms problems				(Keith Owens)
o	Correctly resync ide-cd fixes			(Byron Stanoszek)
o	Fix i2o block driver race			(Arjan van de Ven)
o	Acorn makefile/driver fixes			(Russell King)
o	Make cyberfb use pci_get_drvdata		(Russell King)
o	Kill redundant ARM timer irq code		(Russell King)
o	Remove some ARM hacks from fbmem.c		(Russell King)
o	Fix config bugs with fusion, indenting	(Andrzej M. Krzysztofowicz)
o	Handle bootmem order changes in arm		(Russell King)
o	SA1100 update					(Russell King)
o	Handle ALI AGP flushes				(Ian Hastie)
o	Merge some of the PPC changes			(Cort Dougan)

2.4.0prerelease-ac4
o	DecNET updates					(Steve Whitehouse)
o	Devices.txt typo fix				(Roberto Nibali)
o	Fix 15-23bit direct colour in logos		(Geert Uytterhoeven)
o	Correct framebuffer device.txt			(Geert Uytterhoeven)
o	Small mkiss fixes 				(Hans Grobler)
o	Fix write off end of disk bug			(Jari Ruusu)

2.4.0prerelease-ac3
o	Fix cs46xx driver crash				(David Huggins-Daines)

2.4.0prerelease-ac2
o	Fix further CVS gcc compile warnings		(Rich Baum)

2.4.0prerelease-ac1
o	Merge with Linux prerelease

2.4.0test13pre7-ac1
o	Merge Linus pre7
o	Fix eepro100 on machines with unsigned char	(Russell King)
o	Give the FIQ on the ARM its own handlers	(Russell King)
o	Update ARM mm code				(Russell King)
o	Fix ARM optimisations				(Russell King)
o	Update arm initd patch				(Russell King)
o	Improve ARM I/O operations			(Russell King)
o	ARM boot code updates				(Russell King)
o	ARM scsi driver updates				(Russell King)
o	Update ARM makefiles to new style		(Russell King)
o	Add missing sections to arm link script for glue(Russell King)
o	Update ARM io includes				(Russell King)
o	Clean up frame pointer printing on ARM traps	(Russell King)
o	Update ARM machine definitions			(Russell King)
o	Move the ARM task unmapped base definition	(Russell King)
o	Remove ARM specific hacks from char/mem.c	(Russell King)
o	Fix BIOS32 code for ARM				(Russell King)
o	Back out bogus SMP halt change			(Andi Kleen)
o	Update logo palette handling			(Geert Uytterhoeven)
o	Drop out the compiler selector (2.96/7 seem to work)

2.4.0test13pre6-ac1
o	Merge Linus pre6

2.4.0test13pre5-ac1
o	Merge Linus pre5

2.4.0test13pre4-ac2
o	Further quota build fix				(Jarno Paananen)
o	Fix various combinations that don't build	(Arjan van de Ven)
o	Further Fusion driver updates			(Steve Ralston)
o	Alpha makefile fixes				(Dave Gilbert)

2.4.0test13pre4-ac1
o	Merge Linus pre4
o	Fix network register/hotplug/publish problems	(Andrew Morton)
o	Hopefully fix quotaless compile			(me)
o	Help for irda options question			(Steven Cole)

2.4.0test13pre3-ac4
o	Fix frame size on toshoboe			(Christian Gennerat)
o	Quota fixes/updates				(Jan Kara)
o	Fix keyspan usb config				(Hugh Blemings)
o	Fix module handling in usb serial		(Greg Kroah-Hartmann)
o	Fix sparc64 build of fusion drivers		(Eddie Dost)
o	Clean up config.h includes			(Niels Jensen)

2.4.0test13pre3-ac3 
o	Fix the patch file. Some stuff got corrupted. 

2.4.0test13pre3-ac2 adds
o	Resync with the powerpc folks			(Cort Dougan)
o	Parport experimental label fix			(Tim Waugh)
o	Make uhci return the same error code as the 	(David Brownell)
	other USB hub controllers
o	Merge Fusion drivers				(Steve Ralston)

2.4.0test13pre3-ac1 adds
o	Fix leak in link() syscall			(Christopher Yeoh)
o	Fix ramfs deadlock				(Al Viro)
o	Fix udf deadlock				(Al Viro)
o	Improve parport docs				(Tim Waugh)
o	Document some of the macros			(Tim Waugh)
o	Fix ppa timing issues				(Tim Waugh)
o	Mark the parport fifo code as experimental	(Tim Waugh)
o	Resynch ppa changelog				(Tim Waugh)
	| Tim please double check as I got offsets
o	Add documentation to the PCI api		(Jani Monoses)
o	Fix inode.c documentation			(Jani Monoses)
o	Fix ext2 modular build				(Jeff Raubitschek)
o	Fix bug in scripts/Configure.in matching	(Matthew Wilcox)
o	Update SiS video drivers			(Can-Ru Yeou)
o	Yamaha audio doc fix				(Pavel Roskin)
o	Fix timeout problms with rocktports at 249 days

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
o	Epic100 update
o	Support mixed pnp and legacy sb cards
o	Hopefully fix the bugs in the FAT and HPFS file systems that
	caused fs corruption
o	Fix cramfs vanishing data bug
o	Power management locking fixes
o	filemap posix compliance fix
o	Fix pte handling race
o	Remove unneeded inits to 0 in ide code	  (Bartlomiej Zolnierkiewicz)
o	IDE documentation fixes			  (Bartlomiej Zolnierkiewicz)

Submitted to Linus
o	Add the powermac extras to the input and	(Franz Sirl)
	keyboard drivers
	scripts in 2.4test
o	Fix kd_mksound declaration			(Geert Uytterhoeven)
o	SMC token ring driver update			(Jay Schulist)
o	Update USB documentation			(Greg Kroah-Hartmann)
o	Cleanup ramdisk namespace			(Jeff Garzik)
o	Ramdisk missing blkdev_put
 
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
o	ACPI updates					(Andrew Grover)
o	Fix FPU emulation compile			(Adam Richter)
o	M68K/PPC makefile fixes				(Geert Uytterhoeven)
o	Work around a funny in the Solaris NFS client	(Neil Brown)
o	Fix building of network modules			(Peter Samuelson)
o	Fix media makefiles				(me)
o	FPU emulator source set for m68k 		(Geert Uytterhoeven)
o	Fix m68k build with rmw disabled		(Geert Uytterhoeven)
o	Fix sun3 scsi, mmu and includes			(Geert Uytterhoeven)
o	M68k setup update				(Geert Uytterhoeven)
o	Revert accidental amifb change			(Geert Uytterhoeven)
o	Remove obsolete bits for q40			(Geert Uytterhoeven)
o	Tidy m68k includes				(Geert Uytterhoeven)
o	I2C bus driver updates				(Frodo Looijaard)
o	Fix reference counting in ATM		     (Patrick van de Lageweg)
o	Update Changes to give correct modutils rev	(Steven Cole)
o	Fix NLS config.in bug for SMB
o	Fix xconfig/menuconfig problems with config  (Andrzej Krzysztofowicz)
o	Add firestream ATM driver		     (Patrick van de Lageweg)
o	Rename block_til_ready in generic_serial      (Patrick van de Lageweg)
o	Fix i810 tco locking				(me)
o	Tidy riscom8 and sx namespace			(Jeff Garzik)
o	Fix pcmcia ordering on socket remove		(David Woodhouse)
o	Merge aha152x delay fixes
o	Fix warning in sim710 driver			(Pavel Rabel)
o	Improve the ALSxxx sound driver documentation	(Jonathan Woithe)
o	Tidy the tachyon 5526 driver			(Rasmus Andersen)
o	Clean old old compile time config stuff from	(Pavel Rabel)
	mad16 driver
o	Push Davicom support into the main tulip driver	(Tobias Ringstrom)
o	Merge bttv 0.7.50				(Gerd Knorr)
o	Clean it up to use pci_pci_quirks properly	(me)
o	OSST scsi driver for Onstream drives		(Willem Riede)
o	Merge typo/doc fixes from 2.2.18
o	Further NetROM tidies				(Hans Grobler)
o	Further rose fixes				(Hans Grobler)
o	Documentation/script fixes			(Tim Waugh)
o	BPQ ethernet tidy				(Hans Grobler)
o	Updated AX.25 tidy				(Hans Grobler)
o	Update credits to add Hans Grobler		(Hans Grobler)
o	Handle TLB flush reruns caused by APIC rexmit	(me)
o	Fix Yam driver for Linux 2.4test		(Hans Grobler)
o	Fix AF_ROSE sockets for 2.4			(Hans Grobler)
o	Fix AF_NETROM sockets for 2.4			(Hans Grobler)
o	Tidy AF_AX25 sockets for 2.4			(Hans Grobler)
o	Teach kernel-doc about const			(Jani Monoses)
o	First block of mkiss driver fixes		(Hans Grobler)
o	Update acenic patches				(Jes Sorensen)
o	Acenic update
o	Watchdog header to use __u32 etc		(Eric Brower)
o	Correct md name printing			(Luca Berra)
o	Add Steven Cole to the credits file		(Steven Cole)
o	DC390 update					(Kurt Garloff)
o	X.25 ifdef cleanups				(Henner Eisen)
o	Update OSST driver to 0.9.4.3			(Kurt Garloff)
o	Fix make xconfig failure on irda		(Steven Cole)
o	Fix crashes on unload of msr and cpuid drivers
o	Remove crud from epca driver			(me)
o	Merge support for CPU's >2Ghz from 2.2.18
o	Merge core loops_per_jiffy support
o	Merge first batch of driver fixes from 2.2.18
o	Make smp cpu halt synchronous			(Andi Kleen)
o	Fix eepro module warnings			(Aristeu Filho)
o	Fix most of the netfilter oops cases		(David Miller)
o	Fix appletalk config entry			(William McGonigle)
o	CCISS root= table				(Charles White)
o	Rusty's fixes/review of unsafe set_bit usage
	(A few left to go)
o	RCPCI45 PCI cleanup fixes (mark 2)		(Rasmus Andersen)
o	Fix 8139too signal handling and task scribble	(Andrew Morton)
o	Fix signal handling for usermode helper		(Shuu Yamaguchi)
o	Fix tty DoS bug					(Andrew Morton)
o	Wireless include update				(Jean Tourrilhes)
o	Resync mac ethernet drivers			(Cort Dougan)
o	Remove bogus asserts in 8139too driver		(Jeff Garzik)
o	Fix radio drivers				(Russell Kroll)
o	Fix rcpci build error				(Hans Grobler)
o	Fix incorrect preprocessor use in umsdos	(Andreas Franck)
o	DRM makefile fix				(Keith Owens)
o	IDE 2.4.0-prerelease*1231.patch			(Andre Hedrick)
o	Fixes for CVS gcc and semaphores		(Andreas Franck)
o	Better atm linking fix				(Jan Rekorajski)
o	Macintosh IDE updates				(Geert Uytterhoeven)
o	Update 68k ksyms				(Geert Uytterhoeven)
o	Fix m68k keyboard ioctls			(Geert Uytterhoeven)
o	Fix fbdev config.in allow PM2 modular		(Geert Uytterhoeven)
o	Update m68k ethernet drivers			(Geert Uytterhoeven)
o	2.4 Y2K fixes for Amiga clock			(Geert Uytterhoeven)
o	Fix sun/mac scsi drivers			(Geert Uytterhoeven)
o	Fix fb init order				(Geert Uytterhoeven)
o	Fix m68k miscellaneous stuff			(Geert Uytterhoeven)
o	Update m68k lance driver			(Geert Uytterhoeven)
o	Fix m68k asm constraints			(Geert Uytterhoeven)
o	Fix m68k config 				(Geert Uytterhoeven)
o	Amiga serial update/serial console support	(Geert Uytterhoeven)
o	Update m68k to use loops_per_jiffy		(Geert Uytterhoeven)
o	Add support functions needed by gcc		(Geert Uytterhoeven)
o	Fix amiga resource management			(Geert Uytterhoeven)
o	Fix raid buffer leak				(Neil Brown)
o	Additional knfsd locking			(Neil Brown)
o	Fix loops per jiffy oddments			(Geert Uytterhoeven)
o	Fixed lost video patch in -ac			(Geert Uytterhoeven)
o	Tidy up LAPB code				(Hans Grobler)
o	Tidy up X.25 code				(Hans Grobler)
o	General warning/minor bug fixes			(Arjan van de Ven)
o	Remove extra codec reset from i810 audio	(Anwar Payyoorayil)
	| should fix failed VRA on some boards
o	Fix page allocator recursion			(Rik van Riel)
o	Fix CMOS locking for 2.4.x			(Paul Gortmaker)
o	FAT cache locking for SMP			('manmower')
o	Skip older dm9100's from tulip driver		(me)
o	Further iee1394 build fixes			(Andreas Bombe)
o	Fix i810 divide by zero bug			(Anwar)
o	Remove dead pi and pt drivers			(Hans Grobler)
o	SCC driver update				(Hans Grobler)
o	Adjust csr0 on tulip for known iffy chipsets	(me)
	| Thanks to Don Becker and others for the chipset list
	| and knowing what the problem was.
o	6pack cleanups					(Hans Grobler)
o	Documentation cleanups				(Hans Grobler)
o	Fix unchecked scsi_allocate_request in sg.c	(me)
	| Spotted by Doug Gilbert
o	Fix compile bug in pcxx driver			(me)
o	Fix spelling of pedant				(Tim Waugh)
o	Fix mkiss build error				(Hans Grobler)
o	Patches to fix warnings from gcc 2.97 cvs	(Marcel Schmidt)

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
o	E820 handling fixup				(Andrea Arcangeli)
o	Fix missing memory barrier in bootp/dhcp code	(Cort Dougan)
o	Fix ACPI driver wakeup races			(David Woodhouse)
o	Fix drm makefiles				(Peter Samuelson)
o	Link correctly with ACPI on ACPI_INTERPRETER off
o	Shared memory fixes				(Christoph Rohland)
o	Fix bug in VFAT short name handling		(Nicolas Goutte)
o	Clean up the i810 driver			(Tjeerd Mulder)
o	Clean up misleading indenting in partition code	(JAmes Antill)
o	Support kgcc autodetect

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
