Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130018AbRALPfr>; Fri, 12 Jan 2001 10:35:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131731AbRALPfh>; Fri, 12 Jan 2001 10:35:37 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:17938 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130018AbRALPfa>; Fri, 12 Jan 2001 10:35:30 -0500
Subject: Linux 2.4.0-ac8
To: linux-kernel@vger.kernel.org
Date: Fri, 12 Jan 2001 15:37:08 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14H6GN-0004UX-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	ftp://ftp.kernel.org/pub/linux/kernel/people/alan/2.4/

2.4.0-ac8
o	Fix PS/2 mouse ack/echo handling behaviour	(Julian Bradfield)
	| Let me know if you see 'odd' ps/2 stuff	(Chris Hanson)
	| in 2.4.0ac8 not in ac7
o	Merge Linus 1pre3. Drop out some of my vm
	diffs in favour of his
o	PC110 pad move to new driver style		(Hans Grobler)
o	Clean up/fix leaks in ncr885e			(Hans Grobler)
o	Move dsp56k to new style module stuff		(Hans Grobler)
o	check->request_region, resource leak fixes	(Hans Grobler)
	for qlogicisp
o	Fix iounmap leak in iphase			(Hans Grobler)
o	Fix iounmap leaks in ymf_pci			(Hans Grobler)
o	Fix s390mach.c for non SMP			(Ulrich Weigand)
o	Export queued_sectors				(Jens Axboe)
o	Fix raid5 build after Linus merge		(Andrea Arcangeli)
o	Documentation and chkconfig update		(Niels Jensen)
o	Fix iounmap leaks in oaknet		(Arnaldo Carvalho de Melo)
o	Clean up mac89x0			(Arnaldo Carvalho de Melo)
o	Fix leaks on error in myri_sbus		(Arnaldo Carvalho de Melo)
o	Convert macsonic.c to new style		(Arnaldo Carvalho de Melo)
o	RCPCI further fixes				(Rasmus Andersen)

2.4.0-ac7
o	Export a KMALLOC_MAXSIZE for drivers to check	(Hans Grobler)
	| this is needed to verify things like firmware
	| sizes passed by users
o	Fix highmem compile issues			(Ingo Molnar)
o	Fix kmalloc check missing in hades-pci		(Hans Grobler)
o	Fix kmalloc fail crash in sdla_ppp		(Hans Grobler)
o	cfi locking fixes				(Hans Grobler)
o	Fix missing spin_unlock_irq in hd6457x.c	(Hans Grobler)
o	Fix lmc_main missing skb_unlock on error case	(Hans Grobler)
o	Handle out of memory on lanstreamer		(Hans Grobler)
o	Bring cs46xx.c into working state for non	(Hans Grobler)
	module. Fix locking
o	Fix filesystem locking documentation		(Al Viro)
o	Fusion driver updates				(Steve Ralston)
o	Correct netfilter url				(Rusty Russell)
o	rcpci45 fix the pci_table name (again)		(Hans Grobler)
o	Fix scsi option ordering bug noted by		(Michael Zieger)
o	Config.h include updates			(Niels Jensen)
o	LFS handling cleanup, move some checks to 	(Al Viro)
	vmtruncate
o	Fix missing s->maxbytes setup for procfs	(me)
o	Replace epic100 patches with alternatives	(Jeff Garzik)
o	eepro fixes for older cards			(Aristeu Sergio
							     Rozanski Filho)
o	Buz error handling fix				(Hans Grobler)
o	DGRS driver cleanups/kmalloc checks		(Arnaldo Carvalho 
								de Melo)
o	Fix ioremap leak in zr36120			(Hans Grobler)
o	FIx iounmap leaks in Stradis driver		(Hans Grobler)
o	Further mtd fixes				(David Woodhouse)
o	Update yellowfin driver				(Jeff Garzik, from
							 Don Beckers drivers)
o	Fix iounmap bugs in vga16			(Hans Grobler)
o	TCP odd error fix				(Dave Miller)
o	ll_rw_blk enhancements				(Jens Axboe)
o	DMFE driver cleanup				(Pavel Rabel)
o	iucv fix for S/390 build when non SMP		(Ulrich Weigand)
o	Merge linus -pre2
o	Fix ixj kmalloc checks				(Ingo Molnar)
o	Fix null pointer check in ibm partition code	(Ingo Molnar)
o	Fix kmalloc check in pc_keyb			(Ingo Molnar)
o	Fix kmalloc check in atari_pamsnet		(Ingo Molnar)
o	Fix kmalloc check in 3c515			(Ingo Molnar)
o	Tidy up defxx/fix module locks etc		(Jeff Garzik)
o	Fix kmalloc check in atari_bionet		(Ingo Molnar)
o	Fix kmalloc check in olympic driver		(Ingo Molnar)
o	Fix kmalloc checks in avmb1 driver		(Ingo Molnar)
o	Tokenring needs to be an object file as its	(Jeff Garzik)
	using initcalls

2.4.0-ac6
o	Sunrpc locking fix				()
o	Made agpgart smarter about i815			(Charles McLachlan)
o	Speed up truncate for shmem and clean up	(Christoph Rohland)
o	Fix kmalloc test in udf				(Ingo Molnar)
o	Fix ramfs kmalloc testing			(Ingo Molnar)
o	Fix irq and sense handling bugs in S/390	(Holger Smolinksi)
o	Fix string.h for userspace accidental include	(me)
	| noted by Ulrich Weigand
o	Red Hat office move				(David Woodhouse)
o	Fix missing highmem includes			(Jens Axboe)
o	Fix nfs_flushd deadlock				(Andrew Morton)
o	Honour owner in mpu401				(Chris Rankin)
o	Fix raid5 kmalloc check				(Ingo Molnar)
o	Export mmu_cr4_features				(Adam J Richter)
o	Update ide floppy maintainer 			(Paul Bristow)
o	Fix IP_ADD_MEMBERSHIP case			(Stefan Jonsson)
o	Wavelan resource leak fixes			(Hans Grobler)
o	Fix spinlock error introduced from 2.4.1pre	(Benjamin Redelings)
o	Fix u32 classifier possible hang		(Dave Miller)
o	Further warning fixes				(Rich Baum)
o	RCPCI driver further cleanups			(Rasmus Andersen)
o	Remove unneeded test from rlimit code		(Hans Grobler)
o	Generate header file tags as well as code	(Hans Grobler)
o	Fix ppp_generic label problem			(William Lee Irwin)
o	Fix errors failing to restore IRQ's on smctr	(Hans Grobler)
o	Fix bulkmem kmalloc check error			(Ingo Molnar)
o	Fix pci kmalloc fail handling error		(Ingo Molnar)
o	Fix dac960 kmalloc check 			(Ingo Molnar)
	| new driver rev from LNZ due anyway however
o	Fix pcmcia cs kmalloc check error		(Thiago Rondon)
o	Fix pcmcia ds kmalloc check error		(Thiago Rondon)
o	Bootmem.c uses phys_to_virt but misses include	(Bjorn Wesen)
o	Fix sknet kmalloc check 			(Ingo Molnar)
o	Fix lmc kmalloc check				(Ingo Molnar)
o	Atarilance kmalloc check			(Ingo Molnar)
o	Make some symbols static			(Dan Aloni)
o	Fix sgiseeq kmalloc fail handling		(Ingo Molnar)
o	ISDN kmalloc null check fix			(Ingo Molnar)
o	ATM kmalloc fix 				(Ingo Molnar)
o	Apa1480 kmalloc null check fix			(Ingo Molnar)
o	Sunlance kmalloc check fix			(Ingo Molnar)
o	Baget lance kmalloc check fix			(Ingo Molnar)
o	Update Jes Sorensen's email addr		(me)
o	Fix athlon crash on boot with local apic/nmi	(Ingo Molnar)
o	Further ds fix					(Dan Aloni)
	(Can the pcmcia folk verify that in fact you
	 could just move it)
o	Fix iucv kmalloc bogon				(Ingo Molnar)
o	Fix sun3 video kmalloc check			(Thiago Rondon)
o	Further raid5 fixes				(Ingo Molnar)
o	Netfilter updates				(Rusty Russell)
	| (so come to www.linux.conf.au and say thanks)
o	Update audio locking fixes			(Chris Rankin)
o	Remove ymf_sb driver now ymfpci handles all	(Pete Zaitcev)

2.4.0-ac5
o	Fix qnx build error				(Frank Davis)
o	Further generic_file_write fix			(me)
	| no signal on short write
	| write data on write overlapping max fs size
o	3c515 dereferenced freeed skbuffs		(Hans Grobler)
o	opl3sa2 driver update				(Scott Murray)
o	Uninline strstr to fix gcc compile problems	(me)
	| as in 2.2
o	Fix dmfe oops if no card found			(Andrew Morton)
o	Fix df reporting on ntfs			(Anton Altaparmakov)
	| alternate fix to one by Willem Dekker
o	Fix error path on macii_init that left irqs off	(Hans Grobler)
o	Fix memory/resource leaks in tlan driver	(Hans Grobler)
o	Fix vmalloc end on highmem			(Ingo Molnar)
o	Allow dac960 root device specifiers		(Leonard Zubkoff)
o	Fix missing NULL kmalloc check in fore200e	(Hans Grobler)
o	AF_UNIX cleanup continued			(Hans Grobler)
o	Chkconfig fixes 				(Niels Jensen)
o	Fix kmalloc check missing on ppc proc/rtas	(Hans Grobler)
o	Add recovery for get_block failures		(Al Viro)
o	Fix partially mapped page handling in gfw	(Al Viro)
o	Use s_maxbytes in lseek				(Al Viro)
o	Correct various ext2 items			(Al Viro)
o	Fix memory leak in 3c527 driver			(Hans Grobler)
o	Clean up ipc formatting etc except shm		(Ingo Molnar)
o	Add mising BSDCOMP documentation		(Kai Germaschewski)
o	Fix unchecked allocation in isdn_ppp.c		(Hans Grobler)
o	Revised ad1848 patch				(Chris Rankin)
o	Fix missing kmalloc check on hdlc		(Krzysztof Halasa)
o	Make mnt name behaviour predictable on oom	(Ingo Molnar)
o	Configure doc fixes				(Jeremy Dolan)
o	Fix amifb endif typo				(Rich Baum)
o	Fix bug where mtd driver left irqs off on error	(Hans Grobler)
o	Adjusted ext2 max size rule			(Andreas Dilger)
o	Fix non SMP build of S/390 tree		    (Bernhard Rosenkraenzer)
o	Uniprocessor APIC support/NMI wdog etc		(Mikael Pettersson,
							 Maciej W. Rozycki
							 Ingo Molnar)
o	IXJ driver cleanups/fixes/updates		(David Huggins-Daines)
o	Fix endian and other minor partition bugs  (Andrzej M. Krzysztofowicz)
o	Fix nasty irda bug which could leave ints off	(Hans Grobler)
o	FIx bmac case where ints could be left off	(Arnaldo Carvalho 
							 de Melo)
o	Remove surplus break from de620			(Hans Grobler)
o	Fix iph5526 dereference of free skb		(Hans Grobler)
o	Remove invalid netfilter url from docs		(David Rees)
o	Fix madvise crash				(Andrew Morton)
o	Fix memleak in eepro driver error path		(Hans Grobler)
o	Ultrastor driver used wrong type for save_flags	(Thiago Rondon)
o	Fix spin_unlock missing in s390 error path	(Hans Grobler)
o	MTD update					(David Woodhouse)
o	Tidy softdog driver				(Hans Grobler)
o	Fix sunos syscall memory leak			(Hans Grobler)
o	Fix surplus remove_flags in 53c7xx,8xx driver	(Arnaldo Carvalho 
								de Melo)
o	Tidy isicom, fix missing restore_flags		(Arnaldo Carvalho
								de Melo)
o	Fix missing restore_flags in sscape		(Arnaldo Carvalho
								de Melo)
o	Make ixj use dynamic board structures		(David Huggins-Daines)
o	Fix missing spin_unlock in i2o block		(Hans Grobler)
o	Fix ad1848 missing restore_flags		(Arnaldo Carvalho
                                                                de Melo)
o	Fix missing spin_unlock in ymfpci		(Hans Grobler)
o	Adaptec 1542 SCSI command line options		(Dmitry Potapov)
o	Fix missing ksym				(Eyal Lebedinsky)
o	Fix megaraid driver				(Anwar Payyoorayil)
o	Sparc xor fix					(Anton Blanchard)
o	Fix error returns on truncate/open		(Al Viro)
o	Fix missing restore_flags in n_r3964		(Arnaldo Carvalho
 	                                            	 de Melo)
o	mxser driver capable/return fixes		(Arnaldo Carvalho
 	                                            	 de Melo)
o	Fix missing __restore_flags on IDE		(Arnaldo Carvalho
 	                                            	 de Melo)
o	Fix missing spin_unlock_irqrestore in EMU10K	(Hans Grobler)
o	Resync with Linus tree

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
