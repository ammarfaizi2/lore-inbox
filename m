Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276642AbRJUXjN>; Sun, 21 Oct 2001 19:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277305AbRJUXjG>; Sun, 21 Oct 2001 19:39:06 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:59140 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276642AbRJUXiz>; Sun, 21 Oct 2001 19:38:55 -0400
Date: Mon, 22 Oct 2001 00:45:49 +0100
From: Alan Cox <laughing@shared-source.org>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.12-ac5
Message-ID: <20011022004549.A32210@lightning.swansea.linux.org.uk>
Mail-Followup-To: Alan Cox <laughing@shared-source.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



	ftp://ftp.kernel.org/pub/linux/kernel/people/alan/linux-2.4/

		 Intermediate diffs are available from
			http://www.bzimage.org

*
*	Basically this one is for ARM users or people seeing hiccups
*	with VIA audio
*

2.4.12-ac5
o	SA1100 cleanups					(Nicolas Pitre)
o	Assabet updates					(Russell King)
o	Update ARM simpad architecture			(Russell King)
o	ICS IDE updates					(Russell King)
o	Make ISA dma support in the core optional	(Russell King)
o	Fix SA1100 cache performance problem		(Russell King)
o	Update SA1100 stork pcmcia update		(Russell King)
o	Update the ARM Cerf platform			(Russell King)
o	Keyboard/pm include cleanup			(Russell King)
o	Update ARM default configurations		(Russell King)
o	ARM include updates				(Russell King)
o	Fix isofs packing on the ARM			(Russell King)
o	ADFS file sytstem updates			(Russell King)
o	Fix compile failure on ARM ecoscsi		(Jean-Luc Leger)
o	SA1100 and EP7211 irda drivers			(Russell King,
							 "Blue Mug")
o	ISIcom device table				(Andrey Panin)
o	1.15 test VIA audio driver			(Jeff Garzik)
o	Switch most other drivers to generic BLK*64	(Christoph Hellwig)
o	Fix DTC3280 driver				(Casper Boon)
o	Mini-acpi support for using ACPI apic/cpu	(Andrew Henroid,
	tables (needed for some new IBM stuff)		 Richard Schaal,
	| You must use a command line option to enable	 Jun Nakajima,
	| this for now					 Arjan van de Ven)
	| (Submitted by IBM but written by Intel)

2.4.12-ac4
o	Workaround for gcc 3.0.x spin_unlock problem	(Hartmut Schirmer)
o	Hog stop VM update				(Rik van Riel)
o	Update segment reload avoidance code		(Andi Kleen)
o	shmfs remount fixups				(Christoph Rohland)
o	Fix broken bits of ifdef stuff			(Jean-Luc Leger)
o	Updates to xircom_tulib_cb driver		(Ion Badulescu)
o	Revert problematic tulip rx missed patch	(Jeff Garzik)
o	USB updates			(Greg Kroah-Hartmann, David Nelson,
					 David Brownell)
o	Recognize the 830MP ide and support it		(Michael Clark)
o	Fix yellowfin duplex bug			(Val Henson)
o	APM updates					(Stephen Rothwell)
o	USB net driver updates				(David Brownell)
o	Fix merge glitch in md driver			(Neil Brown)
o	Fix sa1100fb condition checking error		(Russell King)
o	Add device table to the sx driver		(Andrey Panin)
o	Add lots more rep nop points to the kernel	(Arjan van de Ven)
	for the poor old Pentium IV
o	Add device tables to moxa drivers		(Andrey Panin)
o	Joystick fix for USB joystick hats		(David Megginson)
o	Add $PIR support for serverworks CSB5		(Tim Hockin)
o	Take hfs catalog lock static			(Adrian Sun)
o	Fix an elf overflow check			(Al Viro)
o	Update M68K scsi drivers
o	Update M68K ide drivers
o	Add EXPORT_NO_SYMBOLS to motioneye		(Stelian Pop)
o	Fix m68k to be bigendian for audio		(Jes Sorensen)
o	Fix "cd tray won't close" ide cd bug		(Jens Axboe)
o	Remove an unneeded lance ident			(Dave Jones)
o	Sony pi driver update				(Stelian Pop)
o	Issue "FLUSH_CACHE" commands to ide devices	(Tim Hockin)
	on shutdown
o	Add pci table to applicon driver		(Andrey Panin)
o	Use set_current_state in the input layer	(Arnaldo Carvalho
							    de Melo)
o	Swap list locking update			(Hugh Dickins)
o	Update to aic7xxx 6.2.4				(Justin Gibbs)

2.4.12-ac3
o	Switch mpt fusion driver to use set_current_state
						     (Arnaldo Carvalho de Melo)
o	Ext3 file system update and related fixes	(Andrew Morton,
							 Stephen Tweedie)
o	ASM m68k include updates			(Richard Ziclicky)
o	Netwinder audio update				(Russell King)
o	SA1100 documentation update			(Russell King)
o	ARM keyboard updates				(Russell King)
o	ARM include updates				(Russell King)
o	Fix a pcmcia/ds.c return on error case		(Russell King)
o	Small ARM core updates				(Russell King)
o	Philips USB camera driver update		("Nemosoft")
o	Add XScale pci ident				(Russell King)
o	SA1100 frame buffer update			(Russell King)
o	Update floppy.c for N_FDC=1 case		(Russell King)
o	Update floppy parameter support			(Russell King)
o	Bring -ac usb device locking in line with Linus	(Greg Kroah-Hartmann)
	tree
o	USB initialisation fixes			(Linus Torvalds)
o	Use set_current_state in wireless drivers    (Arnaldo Carvalho de Melo)
o	Megaraid driver v 1.18				(Atul Mukker)

2.4.12-ac2
o	Fix the reiserfs buffer accounting bug		(Chris Mason)
o	VIA rhine oops fix				(Urban Widmark)
o	Fix ppc build, add license tags			(Paul Mackerras)
o	Fix partition size handling bug			(Al Viro)
o	Handle BIOSes that slow the CPU more sanely	(me)
o	Fix pm.h include in pc_keyb.c			(Mike Borrelli)
o	Document some of the APM code			(me)
o	Reapply reiserfs big endian support		(Jeff Mahoney)
o	Fix misleading bootflag reporting		(Thomas Hood)
o	Fix a reporting bug in the promise driver	(Alexander Yurchenko)
o	Switch bits of scsi to use set_current_state
						     (Arnaldo Carvalho de Melo)
o	Switch cdrom drivers to set_current_state    (Arnaldo Carvalho de Melo)
o	Add license tags to reiserfs			(Dirk Mueller)
o	SA1100 fixes					(Russell King)
o	Fix usb config typo				(Tom Rini)
o	Eurotech PC104 watchdog				(Rodolfo Giometti)
o	Add support for the VIA C5 processor		(Dave Jones)
o	Add Dave Jones to maintainers file		(Dave Jones)
o	Switch paride drivers to set_current_state   (Arnaldo Carvalho de Melo)
o	Switch USB drivers to set_current_state      (Arnaldo Carvalho de Melo)
o	Switch most of drivers/char to s_c_s	     (Arnaldo Carvalho de Melo)
o	Back out a bogus aci change		     (Arnaldo Carvalho de Melo)
o	Switch sound to use set_current_state	     (Arnaldo Carvalho de Melo)
o	Cache reporting errata handling		  	(Dave Jones)
o	Merge some identical vm operations		(Christoph Hellwig)
o	Fix init/version.h comments/format oddments	(Daniel Dickman)


2.4.12-ac1
o	Merge the majority of 2.4.11/12
	-	Fall back to the Linus reiserfs code set
	-	Fall back towards Linus tree UDF
	-	Switch to Linus tree uhci.c
	-	Fix the parport compile bug

	This continues to avoid the new VM, O_DIRECT
	and the page cache work. That will come in time

2.4.10-ac12
o	Fix the lockd problem				(Trond Mykelbust)
	| This is the minimal fix, when I got to 2.4.12-ac 
	| I'll pick up on the better changes
o	Quieten noise from ldm partition code		(me)
o	Fix ad1816 breakage in ac11			(Rasmus Andersen)
o	CCISS update, adds 5312 support, tape..		(Charles White)
o	Fix parport problem in ac11			(Thomas Hood)
o	USB serial fixes and new device support		(Hugh Blemings)
o	Try to fix irq_2_pin_list lockup		(Sam Varshavchik)
o	EMU10K driver update				(Rui Sousa)
o	ISAPnP fixes for AHA152x			(Juergen Fischer)
o	PCI idents updates				(Marc Boucher)
o	Cpqarray driver updates				(Charles White)
o	Fix address truncation on non x86 in at1700	(Jeff Garzik)
	and winbond840 drivers
o	Fix clgenfb comments				(Jeff Garzik)
o	Correct dpt_i2o license tag			(me)
o	Add more license tags 				(Frank Davies)
o	Casion QV Digital camera ident 0x1000		(Harald Schreiber)
o	Fix usb-serial bugs caught by slab debugging	(Greg Kroah-Hartmann)
o	Dell 600 workaround touch up			(Tom Rini,
							 Pete Zaitcev)
o	ns83820 pci interface cleanups			(Jeff Garzik)
o	Orinoco updates					(David Gibson)
o	SIS900 updates					(Hui-Fen Hsu)
o	Mark vaio I/O controller x86 only		(Tom Rini, Stelian Pop)
o	Update xircom_tulip_cb				(Ion Badulescu)
o	Clean up types in hamachi driver		(Jeff Garzik)
o	USB acm driver update				(Greg Kroah-Hartmann)
o	USB cdc-ether update				(Greg Kroah-Hartmann)
o	USB core updates				(Greg Kroah-Hartmann)
o	USB hpusbscsi updates				(Greg Kroah-Hartmann)
o	USB hub driver update				(Greg Kroah-Hartmann)
o	USB warning cleanups				(Greg Kroah-Hartmann)
o	USB warning fix for edgeport			(Greg Kroah-Hartmann)
o	USB microtek update				(Greg Kroah-Hartmann)
o	USB usb-uhci driver update			(Greg Kroah-Hartmann)
o	Fix header in xircom firmware			(Greg Kroah-Hartmann)
o	Bootflag cleanups				(Thomas Hood)
o	License tags for riscpc drivers			(Russell King)
o	APM support for i810 audio drivers		(Daniel Barlow)
o	Fix ics IDE build bug				(Russell King)
o	Printk string fixes				(Willy Tarreau)
o	Next mount/super updates (MS_VERBOSE,		(Al Viro)
	mount_root cleanup, etc)
o	Recursive binding fixes				(Al Viro)
o	8139too update					(Jeff Garzik)
o	natsemi driver update				(Jeff Garzik)
o	Don't scan past lun 7 for non SCSI-3		(Michael Brown)
o	Fix the sys5 compile problem			(Christoph Hellwig)
o	Make kapm_idled handle idle refuse by the	(me)
	BIOS sanely

2.4.10-ac11
o	Update wireless API and drivers			(Jean Tourrilhes)
o	Trident driver fixes and cleanups	(Arnaldo Carvalho de Melo)
o	Use set_current_state in cmpci		(Arnaldo Carvalho de Melo)
o	The 1Gb limit in our iso code is wrong		(Joerg Schilling)
	(and I trust Joerg on specs..)
o	Handle large HRT in i2o_proc			(Vojtech Pavlik)
	| Fixes a crash on the SX6000 board
o	Use set_current_state in maestro3	(Arnaldo Carvalho de Melo)
o	Kill a dead .version file			(Russell King)
o	Kill bogus include in vt.c			(Russell King)
o	Blink keyboard lights on panic on x86		(Andi Kleen)
o	Update motioneye documentation			(Stelian Pop)
o	Remove unneeded symlink faking in sys5fs	(Christoph Hellwig)
o	Update sony pi driver				(Stelian Pop)
o	ARM makefile fixes				(Russell King)
o	Fix ide build problem				(Keith Owens)
o	Clean up aci driver			(Arnaldo Carvalho de Melo)
o	Fix memory handling error in pnpbios		(Thomas Hood)
o	License tag for amd7930				(Frank Davis)
o	Further VM tuning				(Rik van Riel)

2.4.10-ac10
o	Fix panic on certain fat error cases		(Martin Josefsson)
o	Fix silly dpt_i2o naming error for alpha	(Arjan van de Ven)
	| It still doesnt work on alpha..
o	Add license tags to sbus drivers		(Frank Davis)
o	Fix ARM module export cases			(Russell King)
o	Clean up ufs byteswap handling			(Christoph Hellwig)
o	Support attaching USB irda as serial device	(Greg Kroah Hartmann)
o	Add error reporting to more of pnpbios		(Thomas Hood)
o	Update parport_pc to know about configured v	(Thomas Hood)
	unconfigured PnP resources
o	Fix non module using build			(Keith Owens)
o	S/390 build fixes				(Martin Schwidefsky)
o	Update cris support				(Bjorn Wesen)
o	Fix IPS driver build non modular		(Jack Hammer)
o	PPPoE updates					(Michal Ostrowski)
o	init_idle race fix for Alpha			(Peter Rival)
o	cdrom bracketing/missed copy fix		(Toby Milne)

2.4.10-ac9
o	Fix osb4 warning				(Christoph Hellwig)
o	Merge Configure.help updates for ARM		(Russell King)
o	Intel i860 GART					(Paul Mundt)
o	Toshiba driver compile fix			(Christoph Hellwig)
o	Fix 3dnow+pae compile problem			(Christoph Hellwig)
o	aic7xxx modules.h fix				(Arjan van de Ven)
o	Further i2c cleanups				(Christoph Hellwig)
o	Fix printk type warning in zone printkis	(Christoph Hellwig)
o	Remove unused variable in mm/filemap.c		(Christoph Hellwig)
o	Attach license tags to freevxfs			(Christoph Hellwig)
o	Add RTS/DTR support to the pl2303		(Johannes Deisenhofer
							 Greg Kroah-Hartmann)
o	SAA9730 is mips only				(me)
o	License tags for ide layer			(Frank Davis)
o	Next PnPBIOS update				(Thomas Hood)
o	Zisofs inflate compile fixup			(Keith Owens)
o	Fix Dell C600 fix for newer PM code		(Tim Stadelmann)
o	Parport license tags				(Frank Davis)
o	Fix smb naming clash				(Urban Widmark)
o	Clean up ad1816 resource handling	(Arnaldo Carvalho de Melo)
o	Remove ext2_notify_change			(Christoph Hellwig)
o	Remove dead ext2/acl.c code bits		(Christoph Hellwig)
o	Pentium pro store fence fixes for pci interface (me)
	and spin_unlock
o	spin_unlock for OOSTORE SMP kernels		(me)

2.4.10-ac8
o	Fix inflate ksym problems			(Keith Owens)
o	Fix missign return in errata 50 case		(Udo Steinberg)
o	First tiny bits of making i2o use the new pci	(me)
	API
o	I2O mtrr handling improvements			(Vojtech Pavlik)
o	Remove ARM dependancies on libgcc		(Russell King)
o	Use spin_lock_irqsave in bootflag code		(Thomas Hood)
o	Kill remaining users of malloc.h		(Dave Jones)
o	ARM documentation updates			(Russell King)
o	ARM module tag updates				(Russell King)
o	ARM nexus updates				(Russell King)
o	Remove double include of bitops in fat		(Russell King)
o	Add further export symbol checks		(Keith Owens)
o	Report initrd ramdisk unpack failures		(Russell King)
o	Wait for context thread to start before		(Russell King)
	returning from start_context_thread
o	Remove unused prototype in the pagemap.h file	(Anton Altaparmakov)
o	Move asm-um/page_offset.h to the right place	(Jeff Dike)
o	Add hooks for ARM pcmcia merging (32bit I/O	(Russell King)
	and per mapping info)
o	SA1100 pcmcia		(John Dorsey, Woojung Huh, Jordi Colomer,
				 Ken Gordon, Russell King)

2.4.10-ac7
o	Miscellaneous arm fixes				(Russell King)
o	Arm include updates				(Russell King)
o	SA1100 updates					(Russell King)
o	EBSA110 and integrator updates			(Russell King)
o	ARM arch updates				(Russell King)
o	Zero length packets for UHCI			(Johannes Erdfelt)
o	Update the uml block driver, make it 64bit clean(Greg Lonnon)
o	Change UML adress mappings			(Jeff Dike)
o	Update UML signal handling			(Jeff Dike)
o	Miscellaneous UML fixes				(Jeff Dike)
o	Update the UML example iomem driver		(Greg Lonnon)
o	Next batch of fs/namespace cleanups		(Al Viro)
o	Fix PPP over ATM configuration			(me)

2.4.10-ac6
o	Fix nfs symlink breakage			(Trond Myklebust)
o	Fix SCpnt->pid value				(Dario Ballabio)
o	LDM partition merge fix				(Al Viro)
o	Namespace fixes from 2.4.11pre*			(Al Viro)
o	pipe.c cleanup					(Al Viro)
o	Fix the iobuf oops				(Anwar Payyoorayil)
o	Fix bootp image loader on Alpha			(Jay Estabrook)
o	scsi tape module locking fixes			(Kai Mäkisara)
o	opl3sa2 dual DMA fix				(Jerome Auge)
o	Quota fixes for -ac using S_NOQUOTA flags	(Jan Kara)
o	Fix pci64 broken irq mask hack and an SRM fix	(Jay Estabrook)
o	Fix DRM procfs oops				(Abraham vd Merwe)
o	Toshiba SMM driver check laptop is a Toshiba	(Jonathan Buzzard)
o	Clean up rep_nop stuff in init/main.c for 	(Paul Mackerras)
	portability
o	Update EV6/EV67 cpu selection			(Jay Estabrook)
o	Small alpha fixups				(Jay Estabrook)
o	Remove ASSEMBLY bits 				(Keith Owens)
o	Change PPC64 contact person			(Dave Engebretsen)
o	Update cyberpro frame buffer driver		(Bradley LaRonde,
							 Russell King)
o	Add sysrq-M memory zone free info		(Marcelo Tosatti)
o	Fix mtd export oddments				(David Woodhouse)
o	Export handling cleanup/doc update		(Keith Owens)
o	Irda cleanups					(Jean Tourrilhes)
o	Irda discovery in passive mode fixes		(Jean Tourrilhes)
o	Irda usb updates				(Jean Tourrilhes)
o	VLSI irda updates				(Martin Diehl)
o	PPP over ATM support				(Mitchell Blank,
							 Jens Axboe)
2.4.10-ac5
o	Initial fix for the ELF loader bug		(Linus Torvalds)
o	Revert 2.4.10 sys_personality ABI change bug	(Paul Larson)
o	Add support for 16 byte commands to scsi	(Khalid)
	(only some controllers handle this)
o	Small updates to the ide raid drivers		(Arjan van de Ven)
o	Update the hermes drivers			(David Gibson)
o	Airo driver update				(Javier Achirica)
o	NCR 53c700 update				(James Bottomley)
o	Next set of pnpbios work			(Thomas Hood)
o	Update ARM includes				(Russell King)
o	Update nwflash driver				(Russell King)
o	ARM alignment fix				(Russell King)
o	More pci.ids					(Russell King)
o	Add another SB variant				(Jerome Cornet)
o	SMBfs updates					(Urban Widmark)
o	Further mtd driver updates			(David Woodhouse)
o	Update ibmcam idents				(Dmitri)

2.4.10-ac4
o	Switch to Linus behaviour for kmap 		(Trond Myklebust)
	in generic_file_write - should fix NFS oopses
	| I dont have any highmem boxes so you get to test 8)
o	ext3 deadlock versus truncate fix		(Tachino Nobuhiro)
o	Small reiserfs transaction fix			(Nikita Danilov)
o	Fix a fencepost error in the vm decision making	(Rik van Riel)
o	Shmem accounting fix				(Christoph Rohland)
o	BH async flag changes from 2.4.10		(Andrea Arcangeli)
o	Remove wbinvd macro the acpi people re-added	(Dave Jones)
o	Make the kiobuf init code only clean needed	(Andrew Bond)
	fields (noticably speeds up Oracle)
o	Move DMI scanning earlier in the kernel boot	(Stelian Pop)
	| This is needed to detect the vaio early enough
o	Try and fix 21041 problems with tulip, better	(Herbert Xu)
o	Tulip rx dropped calculation
o	Add further PCI idents				(Jeff Garzik)
o	Add another ident to the clgen fb		(Jeff Garzik)
o	Add intel i830 to the agp code idents		(Christof Efkemann)
o	pl2303 usb serial fixes				(Greg Kroah-Hartmann)
o	ipconfig typo fix				(Ralf Baechle)
o	Fix user mode linux build with new ptrace	(Jeff Dike)
o	JFFS tags update				(David Woodhouse)
o	Kill of remaining old style video4linux inits	(Ladis Michl)
o	Update i2c to rev 2.6.1				(Christoph Hellwig)

2.4.10-ac3
o	Fix page_kills_ppro call			(Peter Blomgren)
o	mtd jffs and jffs2 updates			(David Woodhouse)
o	Partition handling updates			(Al Viro)
o	S/390 documentation updates			(Martin Schwidefsky)
o	S/390 code updates				(Martin Schwidefsky)
o	Add clean config for bust_spinlock generics	(Martin Schwidefsky)
o	Correct EXPORT_MODULE_GPL 			(Keith Owens)
o	NFSv3 mkdir fix					(Glen Serre)
o	Clean up NFS yielding				(Trond Myklebust)

2.4.10-ac2
o	Merge Configure.help changes from 2.4.10
o	Fix the spin_unlock oostore to maybe work	(me)
o	Fix for pentium pro errata #50			(me)
o	initio driver type cleanups			(Arjan van de Ven)
o	rpc_queue_lock needs to be non static		(Frank Davies)
o	Fix a potential crash in ldm partition code	(Al Viro)
o	Acenic updates					(Jes Sorensen)
o	Fix scsi tur direction info			(James Bottomley)
o	Further natsemi updates				(Manfred Spraul)
o	Add license tags to jffs/jffs2			(Frank Davies)
o	Console driver optimisations			(Geert Uytterhoeven)
o	Add belkin F5U120 serial to belkin_sa		(Amy Fong)
o	Big endian fixes for console drivers		(Geert Uytterhoeven)
o	Add module tags to the mwave driver		(Thomas Hood)
o	i2o header file cleanups			(Russell King)
o	Fix C2 power state in ACPI			(Martin Röder)
o	Deadlock and error handling fixes for 8139too	(Manfred Spraul)
o	Update NR_DEAD in keyboard driver		(Arnaldo Carvalho
								de Melo)
o	Fix race in processor init sequence		(Martin Bligh)
o	Check procfs returns in acpi			(Pavel Machek)
o	Add DMI handles for problem K7V-RM and		(Pavel Machek)
	Tosh 4030cdt
o	Fix analog joystick breakage from 2.4.10	(Vojtech Pavlik)
o	Work around vaio weird pnpbios happenings	(Thomas Hood)
o	Update ninja scsi driver			(YOKOTA Hiroshi)
o	Adbmouse typo fix				(Paul Mackerras)

2.4.10-ac1
o	Merge with Linux 2.4.10 tree
	- Drop VM changes
	- Drop raw/block I/O changes
	- Drop out O_DIRECT
	- Basically remove the seriously unsafe stuff and
	  keep the -ac VM
	- I've not applied the obvious fixes so ACPI and joysticks
	  are still icky - that is for ac2
o	Fix the noncompile of SMP OOSTORE kernels	(me)

2.4.9-ac18
o	Fix aic7xxx and ncr53c8xxx compiles		(Erik Andersen)
o	Next PPC merge					(Paul Mackerras)
o	Updated patch-kernel				(Dave Gilbert)
o	Fix pgtable_cache_init escape on S/390		(Russell King)
o	Fix alpha build					(Dave Gilbert)
o	Further scsi ifdef fixes			(Arjan van de Ven)
o	Revert softirq changes

2.4.9-ac17
o	Fix vfree error on swap off			(Hugh Dickins)
o	Further USB serial fixups			(Greg Kroah-Hartmann)
o	ISDN cleanups - flags, includes, license texts	(Kai Germaschewski)
o	Fix bitfields in struct documentation		(Tim Jansen)
o	Next batch of MODULE_LICENSE tags		(Arjan van de Ven)
o	Fix the gendisk bugs				(me)
o	Endian fixes for cisco hdlc over isdn		(Bjoern Zeeb,
							 Kai Germaschewski)
o	PPPoE memory corruption fixes			(Chris Mason)
o	RSS accounting fix				(Hugh Dickins)
o	ide-tape fixes for HP colorado			(Pete Zaitcev)
o	Fix APM disable handling			(Randy Dunlap)
o	Fix mousedev behaviour with new gpm		(Vojtech Pavlik)
o	Add support for the ib700 watchdog		(Charles Howes)
o	Fix sysreq build fail				(me, Junio)
o	S/390 tree warning fixes			(Martin Schwidefsky)
o	Update the IBM serveraid driver			(Keith Mitchell)
o	Apply usb list_del fix				(Georg Acher)
o	Further midibuf fixes				(Adrian Cox)
o	Fix toshoboe pci initialisation			(Adam J Richter)
o	pci registration fixes for tlan			(Adam J Richter)
o	NFS lock reclaiming fixes			(Trond Myklebust)
o	Add Belkin F5D5050 USB ethernet idents		(Dane Johnson)

2.4.9-ac16
o	Fix VM breakage from my merge error		(Rik van Riel)
o	Shmem race fixs					(Hugh Dickins)
o	Improve scan_swap_map optimisiations		(Hugh Dickins)
o	Fix swapoff race				(Hugh Dickins)
o	Fix add to swap cache race			(Hugh Dickins)
o	Remove the PG_swap_cache bit			(Hugh Dickins)
o	Remove unused functions				(Hugh Dickins)
o	Remove unused argument from get_swap_page	(Hugh Dickins)
o	Make use of exclusive_swap_page when we can	(Hugh Dickins)
o	Make swap almost ready to lose BKL		(Hugh Dickins)
o	Add initial pieces for EXPORT_SYMBOL_GPL	(me)
	| kernel symbols for GPL only use
o	smc-ircc module inits				(Keith Owens)
o	Update the hp100 driver				(Jaroslav Kysela)
o	Update kernel-doc for struct and enum		(Tim Jansen)
o	Fix mac89x0 skb->len poking			(David Weinehall)
o	Big chunk of MODULE_LICENSE updates		(Arjan van de Ven)
o	Add the tainting proc hook			(Keith Owens)
o	Nand flash driver build fixes			(David Woodhouse)
o	Fix self-parenting problems in clone properly	(Dave McCracken)
o	CPIA camera fix					(Michael Marxmeier)
o	USB serial fixes				(Greg Kroah-Hartmann)
o	Fix cisco hdlc protocol	for isdn		(Bjoern Zeeb)
o	Further tunnel driver fixes			(Taral)
o	ISDN isar driver small fix			(Karsten Keil)
o	Further sscanf fixes				(Paul)
o	Fix iph5526 clash with ptrace namespace		(Dave Jones)
o	First block of block device updates from Al	(Al Viro)
o	Fix atm ioctl bug				(Mitchel Blank)
o	ISAPnP updates					(Jaroslav Kysela)
o	Merge IBM MWave support				(Paul Schroeder)
o	ISDN return value fixes				(Andrew Morton)
o	Add Acerscan 1240ut to the USB scanners		(Morgan Collins)
o	Fix init includes for aironet4500		(Keith Packard)
o	Fix GART docs to reference DRI not utah		(Robet Love)
o	Reiserfs speed ups				(Chris Mason)
o	Maestro init fixups				(Adam J Richter)
o	Lock function cleanup				(Trond Myklebust)
o	Make the DRM options clearer			(Keith Owens)
o	Add compiler.h from 2.4.10
o	Update ns83820 driver				(Ben LaHaise)

2.4.9-ac15
o	Rik's next VM handling update			(Rik van Riel)
o	Update mousedrivers documentation		(me)
o	Update 53c700 drivers				(James Bottomley)
o	USB serial pl2303 fixes				(Greg Kroah-Hartmann)
o	USB serial modcount fixes			(Greg Kroah-Hartmann)
o	USB devfs fix for skeleton driver		(Greg Kroah-Hartmann)
o	Fix possible double read_unlock in personality	(Christoph Hellwig)
	handling
o	Switch to maintainers sysrq fix			(Crutcher Dunavant)
o	Further pnpbios fixes				(Thomas Hood)
o	Delete the right ipip tunnel			(Taral)
o	Coda fixes					(Jan Harkes)
o	Fix sscanf					(Paul)
o	Clean up the semaphore fix			(Leonid Igolnik)
o	Merge minimal hooks for speakup			(Kirk Reiser)
	| Speakup itself needs more cleaning up yet 

2.4.9-ac14
o	Fix atm alignment on IA64			(Chas Williams)
o	Soundblaster unload oops fix			(Matthias Hanisch)
o	NFS over tcp fixes				(Trond Myklebust)
o	Add usb zero packet flag support to OHCI	(Roman Weissgaerber)
o	Clean up reiserfs flags usage			(Nikita Danilov)
o	Fix reiserfs disk leak on crash case		(Nikita Danilov)
o	Fix reiserfs mount option handling		(Nikita Danilov)
o	Cosmetic reiserfs changes			(Nikita Danilov)
o	Small fusion driver update			(Steve Ralston)
o	Add RAID1 support promise ide raid		(Arjan van de Ven)
o	Remove duplicate DEC fb config			(Geert Uytterhoeven)
o	PCI type 2 access type cast fixes		(Brian Gerst)
o	Add AMD761 AGP					(Robert Love)
o	Fix /proc/pid/maps				(Manfred Spraul)
o	Fix 8139too pio problem				(Celso Gonzalez)
o	Fix SEM_UNDO wrap bug				(me, Leonid Igolnik)
o	Add xircom/entrega single port USB		(Greg Kroah-Hartmann,
							 Brian Warner,
							 Cristian Craciunescu)
o	ISOfs transparent compression, unify zlib	(H Peter Anvin)
	somewhat (lots more to do there!)
o	Correct usbvideo reported procfs name		(Jonas Munsin)
o	SMP safe Z85230 driver				(me)
o	Merge saner parts of S/390 code drop

2.4.9-ac13
o	Fix mangled sun3fb bits				(me)
o	Fix make rpm version bug			(Russell King)
o	Work around eepro100 bug with some chip		(Arjan van de Ven)
	versions on 10Mbit half duplex
o	Bring UML inlines in sync with rest of kernel	(Jeff Dike)
o	UML memory protection code - main piece		(Jeff Dike)
o	Clean up UML rules				(Lennert Buytenhek)
o	Fix UML hang on xterm open fail			(Jeff Dike)
o	Fix UML signal handling bug			(Jeff Dike)
o	Fix UML out of pty's on host error reporting	(Jeff Dike)
o	Add tun/tap support to UML + clean up net code	(Jeff Dike)
o	Make UBD block driver handl errors properly	(Will Dyson)
o	Make backfile file paths in COW headers absolute(Greg London)
o	Fix missing UML tlb flush			(Jeff Dike)
o	PPC fixes for UML				(Chris Emerson)
o	Declare sys_personality so UML compiles		(Andrea Arcangeli)
o	Wrap host library mallocs into UML kernel 	(Jeff Dike)
	allocs. Also fix gprof support
o	Use -1 as "no dma" on PnPBIOS			(Thomas Hood)
o	Fix sysctl log level change breakage		(Randy Dunlap)
o	Document bread()				(Pavel Machek)

2.4.9-ac12
o	Yamaha audio wakeup race fix			(Pete Zaitcev)
o	3c507 ring buffer handling fix			(Mark Mackenzie)
	| It looks like the same may apply to eexpress and a few
	| others. People may want to check
o	4.4BSD alias syle ioctl bits			(Matthias Andree)
o	Fix jffs_min compile failure			(Frank Davis)
o	Fix hid initialisation order			(Vojtech Pavlik)
o	Add sysrq to mconsole				(James Stevenson)
o	Remove dead 3c515 stuff				(Andres Salomon)
o	Fix UML disk space leak				(James Stevenson)
o	uml hz_to_std()					(Jeff Dike)
o	uml makefile cleanup				(Jeff Dike)
o	hostfs cleanup - use pread/pwrite		(Jorgen Cederlof)
o	Fix oops in scsi generic			(Jens Axboe)
o	Fix missing break in riva fbdev.c		(Steve DuChene)
o	Push spin_trylock_bh into the headers	(Arnaldo Carvalho de Melo)
o	PWC driver update				("nemosoft")
o	Fix hz_to_std macro problem			(Matt)
o	Fix radeon + AMD761 lockup/corruption problem	(Stephen Tweedie)
o	Intermezzo update				(Peter Braam)
o	USB serial startup fix				(Greg Kroah-Hartmann)
o	Makefile cleanups				(Christoph Hellwig)
o	Code cleanup for eepro100			(Ben LaHaise)
o	Fix pid handling bug in msg queues		(Mingming Cao)
o	Raid multipathing				(Ingo Molnar)
o	Correct sys_setid return in md 			(Vojtech Pavlik)
o	Clean up isdn sc debug code			(Vojtech Pavlik)
o	x86_64 random patch				(Vojtech Pavlik)
o	Add x86_64 ifdefs to various places		(Vojtech Pavlik)
o	Limit granch asm code to x86 fix setup code	(Vojtech Pavlik)
o	Use unsigned long for flags where needed	(Vojtech Pavlik)
o	Fix reiserfs writepage v truncate/mmap race	(Edward Shushkin)
o	Eliminate various bits of reiserfs code and	(Edward Shushkin)
	references to old ext2/minix stuff
o	Support multiple block sizes in reiserfs	(Edward Shushkin)
o	Fix gcc warning building reiserfs		(Edward Shushkin)
o	Fix reiserfs 32bit uid on old format		(Edward Shushkin)
o	Fix yam hamradio driver				(Edward Shushkin)
o	Es1888 audio divider change			(Craig Mahaney)
o	Add a highmem debugging option			(Christoph Hellwig)
o	Remove crud from lvm.h				(Joe Thornber)
o	Replace some LVM macros with inlines		(Joe Thornber)
o	Open/Close LVM PV's when using them		(Joe Thornber)
o	Remove lvm_short_version			(Joe Thornber)
o	Use devfs_register_blkdev etc in LVM
o	Rename fields and consider only active LVM	(Heinz Mauelshagen)
	snapshots [and congratulations on the awar Heinz]
o	Change LVM locking to use rw_semaphores		(Joe Thornber)
o	Assorted LVM cleanups			(Joe Thornber and others)
o	IA64 processor prefetch				(??)
o	Return the right thing for strnlen_user when	(Andreas Schwab)
	limit = 0
o	More debug info on sysrq			(Andrea Arcangeli)
o	Keyboard compile fix on Alpha			(Andrea Arcangeli)
o	Shrink dcache before invalidating the inodes	(Andrea Arcangeli)
	on a umount
o	Fix apm disable handling			(Thomas Krennwallner)
o	CPIA locking fixes				(David Hansen)
o	zap_inode_mapping function to invalidate all the(Christoph Hellwig)
	maps of an inode
o	Remove accidental leak of console_lock back	(Andrew Morton)
	into -ac
o	Fix implicit declaration warning		(Dave Jones)
o	Add another promise ide ident			(Arjan van de Ven)
o	Ignore PRQ bit in apic flags when looking for	(Randy Dunlap)
	unknown configs
o	Matrox driver update				(Petr Vandrovec,
							 David Hansen)
o	NULL checks in lock code			(Francis Galiegue)
o	Remove duplicate bits on fbmem.c		(Paul Mundt)
o	ia64 arch_init_modules fix			(Arjan van de Ven)
o	Support tabstops >160				(Petr Vandrovec)
o	"noac" NFS updates				(Trond Myklebust)
o	Default P5 MCE to off				(me)
o	Bluesmoke updates				(Dave Jones)
o	Handle cpu info that goes over a page long	(James Cleverdon)
	| only tested on ia32/ia64 so far

2.4.9-ac11
o	Fix sign check error in death signal		(Martin Macok,
							 Kamil Toman)
o	Merge up to Linus 2.4.10pre9
	
2.4.9-ac10
o	Multiple swapoff fixes				(Hugh Dickins);
o	Clean up the mips parts of the mem.c ifdefs	(Ralf Baechle)
o	Update NCR53c700 driver, make it generic	(James Bottomley,
				Richard Hirst, Rasmus Andersen, Keith Owens)
o	Recognize Radeon VE in radeonfb			(Nick Kurshev)
o	MCE address reporting fix			(Dave Jones)
o	APIC check fixes				(Randy Dunlap)
o	Wrong SIGBUS data in siginfo fix		(Daniel Kobras)
o	acpi Makefile fix				(Keith Owens)
o	NTFS update					(Anton Altaparmakov)
o	Parse mainboard resources inline to pnp not	(Gerd Knorr)
	as pci_device objects
o	Propogate register_netdev errors out from 	(Dave Miller)
	init_netdev
o	Take sound lock static				(David Hansen)
o	ns83820 updates/fixes				(Ben LaHaise)
o	Small arch_init_modules fix for ia64		(Maciej Rozycki)
o	pci bridge setup fixes, 64bit sign propogation	(Todd Inglett)
	etc
o	Add another batch of MODULE_LICENSE tags	(me)

2.4.9-ac9
o	ICP vortex documentation update			(Boji Kannanthanam)
o	Fix farsync ioctl checks			(Bob Dunlop)
o	Kiovec optimisations				(Rohit Seth)
o	Fix irda-usb match flags			(Adam J Richter)
o	USB serial MODULE_LICENSE tags			(Greg Kroah-Hartmann)
o	Tidy up Changes notes to recommend gcc2.95+	("Colonel")
o	Kill dup in usb unusual_devs table		(Harald Schreiber)
o	Ethtool ioctl handling fix			(Dave Miller)
o	Add S/PDIF, 4 and 6 channel audio to ICH driver	(Bob Paauwe)
o	Fix compare types in ncpfs			(Petr Vandrovec)
o	Add limit to bluetooth ioctl			(me)
o	Fix missing channel range check in dpt_i2o	(me)
o	Fix lvm checks					(me)
o	Add missing wireless ioctl length check		(me)
o	Fix checks in sbpcd				(me)
o	Fix checks in generic ppp			(me)
o	Fix check in zr36067				(me)
o	Fix checks in moxa				(me)
o	Fix checks in zr36120				(me)
o	Fix Matrox DRM to mention G450			(Pavel Roskin)
o	DGRS multi-nic mode fix				(Rick Richardson)
o	Reformat aztcd (no other changes)		(me)
o	Clean up the mcd driver				(me)
o	Remove gendisk export. Gendisk is now private	(Christoph Hellwig)
	to the sane API and has proper locking
o	Highmem overflow fix				(Ben LaHaise)
o	Megaraid oops fix				(Arjan van de Ven)
o	Update kernel-doc-nano-HOWTO			(Ken Moffat)
o	Fix sis900 kerneldoc				(Ken Moffat)
o	Fix via audio kernel doc			(Ken Moffat)

2.4.9-ac8
o	Merge from 2.4.10-pre4 except
		USB uhci controller update
		MM/buffer cache changes
o	Intermezzo update				(Peter Braam)
o	Clean up gendisk common code			(Christoph Hellwig)

2.4.9-ac7
o	Add another 1885 ident				(Leon)
o	Mention G450 in the 200/400 DRI			(Pavel Roskin)
o	Fix non PCI aic7xxx oops			(me)
o	Correct centaur chip detection			(Keith Owens)
o	Correct Dell cable detection			(me)
o	Fix usb storage warning				(Christoph Hellwig)
o	Fix symbol clash between core and pwc		(Christoph Hellwig)
o	Comment out the visws				(Christoph Hellwig)
o	Small alpha build fix				(Ricky Beam)
o	NFS client update				(Trond Myklebust)
o	SE401 update					(Jeroen Vreeken)
o	Check proc/modules before querying it in	(André Dahlqvist)
	ver_linux
o	Add hppa to unaligned list for reiserfs		(Jurriaan)
o	i2c Config.in fix				(Christoph Hellwig)
o	LVM 32/64bit sort out				(Patrick Caulfield)
o	Softirq update/fixups				(Andrea Arcangeli)
o	Add arch_init_modules hook			(Maciej Rozycki)
o	Update slab cache to do LIFO handling and clean	(Andrea Arcangeli)
	up code somewhat
o	Ethtool and alias fix				(Arjan van de Ven)
o	Self adjusting syscall table filler		(Andrea Arcangeli)
o	Configure.help typo fix				(David Weinehall)

2.4.9-ac6
o	Update compiler requirements doc		(me)
o	Fix module count leak (I hope) in cs46xx	(me)
o	Fix sx.c warnings				(Christoph Hellwig)
o	Fix seagate.c prototypes			(Christoph Hellwig)
o	Remove non-modular stuff from mod builds	(Christoph Hellwig)
	and fix warnings
o	Fix missing return value on xirc2ps		(Christoph Hellwig)
o	Fix atmtcp MODULE_LICENSE			(Christoph Hellwig)
o	Remove various unused code			(Christoph Hellwig)
o	Switch drivers/fc4 to use module_init		(Christoph Hellwig)
o	Config file fixes				(Christoph Hellwig)
o	Fix AX.25 digipeat crash			(Thomas Osterried)
o	DECNET update					(Steven Whitehouse)
o	Fix UNUSUAL_DEV entry for eUSB SmartMedia	(Andries Brouwer)
o	Remove spare maxinefb setup			(Paul Mundt)
o	Add USB MODULE_LICENSE tags			(Greg Kroah-Hartmann)
o	Update the irq fix for the i810 audio based	(me)
	on further analysis by Doug Ledford
o	make rpm target bug-fixes			(Eli Carter)
o	Fix missing export-objs in acpi			(Keith Owens)
o	VIA ide update (support 82c576, other small	(Vojtech Pavlik)
	fixes)
o	Fix tulip bug when using MWI experimental bits	(Jeff Garzik)
o	Add MODULE_LICENSE tags to telephony		(Robert Love)
o	Add MODULE_LICENSE tags to drivers/video	(Robert Love)
o	Fix z2ram tag					(Robert Love)
o	Ask for 255 bytes of header on scsi pages	(Matt Dharm)
	| Lots of USB crap can't even get truncating right
o	Fix ver_linux for e2fsprogs 1.23		(Albert Cranford)
o	Add MODULE_LICENSE tags to zorro		(Robert Love)
o	Make __module_license static			(Keith Owens)
o	Merge some of the PPC64 submission	(Peter Bergner, Anton Blanchard, Mike Corrigan, Dave Engebretsen,
					Tom Gall, Todd Inglett, Paul Mackerras,
					Pat McCarthy, Steve Munroe, Don Reed, 
					and Al Trautman)
	| I dropped some config bits to keep stuff simpler
	| and a few files that definitely didnt follow CodingStyle
o	Merge updated gdth scsi raid driver		(Achim Leubner)
o	Remove escaped debug code from ni5010		(Frank Davies)

2.4.9-ac5
o	Make pae i386 compile again			(Russell King)
o	Add MODULE_LICENSE tagging			(me)
o	Clean up aztcd (phase 1)			(me)
o	Fix aztcd subchannel error reporting bug	(me)
o	Reformat cdu31a pending cleanups		(me)
o	Reformat cm206 pending cleanups			(me)
o	Reformat gscd pending cleanups			(me)
o	Reformat isp16 pending cleanups			(me)
o	Reformat sjcd pending cleanups			(me)
o	Reformat tpqic02 pending cleanups		(me)
o	Add tags in drivers upto and including drivers/char/*
	| lots more to add yet...
o	pl2303 oops fix					(Greg Kroah-Hartmann)
o	Sony clie updates for clie OS 4.0		(Greg Kroah-Hartmann)
o	Fix elf loader for prelink binaries		(Jakub Jelinek)
o	Make xconfig fix				(Robert Love)
o	Add reparent_to_init, fix pnp and 8139 zombies	(Andrew Morton)
o	Update Configure.help				(Steven Cole)

2.4.9-ac4
o	ns83820 driver fixes and updates		(Ben LaHaise)
o	Configure.help updates				(Steven Cole)
o	Add generic pgtable_cache_init()		(Russell King)
	| and remove pae ifdefs from init/main.c
o	Fix X.75 with new hisax drivers and an isdn	(Kai Germaschewski)
	disconnect race
o	Remove now defunct directory offset cast	(me)
o	Make several vm behaviours tunable for now	(Rik van Riel)
	| This is so we can study behaviour patterns not for
	| the long term
o	Merge an additional ide-floppy fix		(Sam Varshavchik)
	| Fixed the ide floppy I/O error funny on some drives
o	Pull dac/adc rate setting into ac97_codec.c	(me)
o	Update mips64 makefiles 			(Ralf Baechle)
o	Complete the missing bits of the proc 		(Ralf Baechle)
	infrastructure using constant HZ to userspace
	| This has been partial for a long time, with the mips tree
	| it actually needs to be completed...
o	Avoid oops in rivafb when using 15bit depth	(Steve DuChene)
	on riva128
o	Indent seagate scsi into linux format		(me)
	| Changes pending so do this in two steps..
o	pl2303 updates					(Greg Kroah-Hartmann)
o	Orinoco update					(David Gibson)
o	IRQ stack value fix				(John Byrne)
o	Enable DMA on 20268R				(Zygo Blaxell)
o	Add missing -EFAULT return to se401		(Pavel Machek)
o	Voodoo 1/2 frame buffer console			(Ghozlane Toumi)
o	Update cache size reporting errata		(Dave Jones)
o	Fix nasty oops and deadlock in i810_audio	(me)

2.4.9-ac3
o	Fix config glitch in drivers/video/Config.in	(Steven Cole)
o	Kaweth endian fixes				(Brad Hards)
o	Update the MPT fusion drivers			(Steve Ralston)
o	Possible floppy probe fix			(Paul Gortmaker)
o	Add the KT266 agp to the table			(Kris Kersey)
o	Start convering ia32 and x86_64 mtrr code	(Dave Jones)
o	Account ramdisk in out of memory code		(Russell King)
o	Possible fix for cardbus allocation failures	(Andreas Bombe)
o	Clean up other cases of const initdata		(Dave Jones)
o	Update the keyboard rate code to be more	(Dave Miller)
	flexible (needed for sparc)
o	Configure.help fixes				(Steven Cole)
o	Pegasus USB driver fixes			(Petko Manolov)
o	Fix i810 audio pops on speed changes		(Scott Herod)
o	GPIO driver for the ITE board			(Hai-Pao Fan)
o	Philips Nino port update		(Steven Hill, Pavel Machek)

2.4.9-ac2
o	Last small bits of the PPC merge		(Paul Mackerras)
o	Fix compile bugs in airport driver		(David Gibson)
o	ITE8172 ide updates				(Steve L)
o	Add i2c drivers for the ITE board		(Hai-Pao Fan)
o	AC97 register naming fix			(Ralf Baechle)
o	TI 3912 serial driver			(Harald Koerfgen, Jim Pick,
							 Steven Hill)
o	ITE general updates				(P Popov)
o	Remove double init of SGI streamable device	(Ralf Baechle)
o	Update SGI indy drivers				(Ralf Baechle)
o	Qtronix keyboard driver updates			(P Popov)
o	Add tx3192 frame buffer support			(Steven Hill)
o	MIPS frame buffer updates			(Ralf Baechle)
o	Move vino.h into driver directory		(Ralf Baechle)
o	Ocelot updates			(Jun Sun, G Lonnon, S Kranz, Steve J)
o	DDB5 updates					(Jun Sun)
o	MIPS jazz update				(Ralf Baechle)
o	SGI wd33c93 update				(Ralf Baechle)
o	Baget updates					(Ralf Baechle)
o	SNI updates					(Ralf Baechle)
o	Alchemy Au1000 support				(P Popov)
o	MIPS eval board updates		(Ralf Baechle, Carsten Langgaard)
o	Update Decstation serial support		(Maciej W. Rozycki)
o	NEC Vrc5477 audio driver			(Steve L)
o	General MIPS32 updates		(Jun Sun, Ralf Baechle, Matt Porter,
					 Kevin Kissell, Carsten Langgaard,
					 Jan-Benedict Glaw)
o	MIPS scsi updates				(Ralf Baechle)
o	Notifier signal oops fix		(Benjamin Herrenschmidt)

2.4.9-ac1
o	Merge the fat and iso changes from 2.4.9
o	Merge the sunrpc changes from 2.4.9
o	Merge (hopefully correctly) the nfs changes
o	Switch to the 2.4.9 emu10k1 driver
o	Merge vfs directory type changes
o	Merge other oddments
	- This leaves min/max and the vm/buffer changes
	  both of which are pretty dubious anyway
o	lock_kiovec page unwind fix			(Velizar B)
o	do_swap_page recheck pte before failing		(Linus, Jeremy Linton)
o	do_swap_page doesn't mkwrite when deleting	(Linus)
	| From 2.4.9 with extra comments etc		(Hugh Dickins)

 
---
Alan Cox <alan@lxorguk.ukuu.org.uk>
Red Hat Kernel Hacker
& Linux 2.2 Maintainer                        Brainbench MVP for TCP/IP
http://www.linux.org.uk/diary                 http://www.brainbench.com
