Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269928AbRHJPdR>; Fri, 10 Aug 2001 11:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269933AbRHJPdM>; Fri, 10 Aug 2001 11:33:12 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:57360 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S269928AbRHJPc7>; Fri, 10 Aug 2001 11:32:59 -0400
Date: Fri, 10 Aug 2001 16:35:17 +0100
From: Alan Cox <laughing@shared-source.org>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.7-ac11
Message-ID: <20010810163517.A4581@lightning.swansea.linux.org.uk>
Mail-Followup-To: Alan Cox <laughing@shared-source.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



	ftp://ftp.kernel.org/pub/linux/kernel/people/alan/2.4/

		 Intermediate diffs are available from
			http://www.bzimage.org


2.4.7-ac11
o	Fix dumb bug in the bootflag handling code	(Randy Dunlap)
o	Compaq FC update (makefile clean too)		(Charles White)
o	Add Matt Domsch to the credits			(Matt Domsch)
o	Update Randy Dunlap's contact info		(Randy Dunlap)
o	SA1100 updates					(Russell King)
o	Add PnP support to sf16i			(Ladislav Michl)
o	Acorn drivers update				(Russell King)
o	Fix clashing 'cams' symbol			(Keith Owens)
o	Fix AGP memory leak on serverworks		(Jeff Hartmann)
o	Fix an off by one in shmem.c			(Hugh Dickins)
o	Revert incorrect ATM change			(Mike Westall)
o	DRM makefile fixes				(Keith Owens)
o	Next batch of superblock work			(Al Viro)
o	Fix in2k oopses					(Francois Romieu)
o	Add reboot by SMP reset				(Matt Domsch)
o	Add pm support for laptops that resume the	(Matt Domsch)
	mouse port even if was disabled before..
o	Add DMI quirks for all modern dell systems	(Matt Domsch)
o	Inspiron 4000 needs irqs on for APM		(Arjan van de Ven)
o	YMFPCI fixes, big endian fixes			(Pete Zaitcev)
o	Add winbond W83971D ac_97 codec to tables	(Andrey Panin)
o	pcnet32 oops fix and leak fix			(Paul Gortmaker)
o	Use static inline in sound drivers		(me)
o	Fix DRM build/makefile bugs from merge	(Andrzej Krzysztofowicz)
o	Avoid lp module being pinned down if console	(Tim Waugh)
	enabled

2.4.7-ac10
o	Fix up USB merge mess				(Pete Zaitcev)
	| Fixes a possible USB deadlock
o	IRDA update					(Dag Brattli)
o	Merge DRM for XFree 4.1.x			(XFree86 and others)
o	Update freevxfs idents				(Christoph Hellwig)
o	Fix a bug in access() checks on X_OK with	(Christoph Hellwig)
	DAC ovveride
o	Add another intel bios ident with bad $PIR	(Arjan van de Ven)

2.4.7-ac9
o	Print warnings about buggy 440GX $PIR tables	(Arjan van de Ven)
o	Update ARM softirq code				(Russell King)
o	Compaq FC controller update			(Charles White)
o	Update ARM integrator platform			(Russell King)
o	Miscellaneous ARM fixes				(Russell King)
o	ARM io function updates				(Russell King)
o	Remove duplicate Configure.help items		(Steven Cole)
o	Update ARM shark platform			(Russell King)
o	ARM anakin platform				(Russell King)
o	Allow swap < 2*ram				(Rik van Riel)
o	Set page format bit for scsi-2 tape		(Kai Makisara)
o	Fix compile with shmfs disabled			(Christoph Rohland)
o	RME Hamerfall audio driver			(Guenter Geiger)
o	Further UML fixes				(Jeff Dike)
o	Syncppp fix					(Bob Dunlop)
o	Farsync update					(Bob Dunlop)
o	UML network driver update			(Jeff Dike)
o	Revert aic7xxx makefile changes			(Keith Owens)
o	DaveJ has received enough Rise cpu reports	(Dave Jones)
o	Clean up building without procfs	    (Andrzej Krzysztofowicz)
o	Riscom compile fix			    (Andrzej Krzysztofowicz)

2.4.7-ac8
o	Kill accidental bit of S/390 merge I meant	(Bill Nottingham)
	to skip (hotplug should be working again now)
o	Fix host_info_lock namespace on ieee1394	(Keith Owens)
o	Fix duplicate rio serial init			(Keith Owens)
o	Fix dead init_zoran_cards symbol		(Keith Owens)
o	Don't define EXPORT_SYMTAB in cmpci		(Keith Owens)
o	Don't define EXPORT_SYMTABL in sisfb		(Keith Owens)
o	Fix warnings in ess_solo1 			(me)
o	Fix deadlock in moxa mxser driver		(Christophe Barbé)
o	First of many needed devfs race fixes		(Al Viro)
o	Windows 2000 vfat name mapping fix		(Wolfram Pienkoss)
o	Clean up ubd, CONFIG_IOMEM->CONFIG_MAPPER	(Jeff Dike)
o	Fix a UML crash, make uml devices pluggable	(Jeff Dike)
o	Use page cache in hostfs, fix UML stat64 bits	(Jeff Dike)
o	Complete UML ppc support merge			(Chris Emerson)
o	Complete UML Configure.help			(Bill Stearns)
o	Add rep nop so the poor old Pentium IV doesnt
	go thermal slowdown every long mdelay		(Arjan van de Ven)
o	Fix various invalid Config script items		(Christoph Hellwig)
o	SYS5fs BSD style symlink support (SCO etc)	(Christoph Hellwig)
o	Fix PnPBIOS reporting on io v mem		(Andrey Panin)
o	Fix atyfb compilation problems with vaio bits	(Keith Owens)
o	Make HP support in AMI Megaraid run time 	(Michael Johnson)
o	Fix an ext3 buffer credit accounting bug	(Andrew Morton)
o	Add hardware volume control support to ALi	(Matt Wu)
o	Clean up the above a little for non ALi, fix	(me)
	rmmod crash
o	Adaptec scsi update (6.2.1)			(Justin Gibbs)
	| + gcc 3.0 fixes
o	Handle broken PIV SMP tables			(Maciej Rozycki)
o	Switch to static inline on ARM subtree		(Russell King)
o	SHMfs updates, race fix				(Christoph Rohland)

2.4.7-ac7
o	Import safer bits of 2.4.8pre
	- skipped vm hackery, buffer hacks
	- skipped S/390 (my tree should be newer anyway)
o	Fix duplicates in ldm.h				(Matthew Gardiner)
o	ARM updates					(Russell King)
o	Remove qlogicfc_asm (license clash question + we(Jes Sorensen, me)
	| are shipping qlogic release candidate not final
	| firmware.  Set card to use firmware in flash
o	Example iomem driver + fixes for UML		(Greg Lonnon)
o	Clean up unique UML machine id code		(Henrik Nordstrom)
o	Small UML bug fixes				(Jeff Dike)
o	Fix UML uaccess macro bug			(Jeff Dike)
o	Don't refuse unneccessarily on remount with	(Petr Vandrovec)
	data= option with ext3
o	tdfx driver cleanups				(Paul Mundt)
o	Replace masq crash fixes with corrected and	(Rusty Russell)
	"official" versions.
o	Fix umsdos symlink bug				(Delbert Matlock)
	
2.4.7-ac6
o	Switch JFFS to use completions			(me)
o	Fix wrong unlock in try_to_sync_unused_inodes	(Petr Vandrovec)
o	Update UML to compile again			(Jeff Dike)
o	Clean up all drivers with clashing names for	(me)
	complete, wait_for_completion
o	Some gcc 3.0 warning cleanups
o	Add SCO AFS awareness (read only) to sysv	(Christoph Hellwig)
o	Netfilter crash fixes				(Mark Boucher)
o	Second batch of superblock race/cleanup work	(Al Viro)

2.4.7-ac5
o	Resolve ext3 and superblock change incompat	(me, Al Viro)
	| Fixes hang on journal recovery
o	Fix freevxfs leak				(Andries Brouwer)
o	Add another eepro100 ident			(Matt Wilson)
o	Further tweakes to make rpm based on 
	suggestions by Keith Owens			(Keith Owens, me)
o	Fix ISA dma range check bug in cs89x0		(Paul)
o	Fix ISA dma range check on 3c505		(Paul)
o	Switch md driver to use completions		(Neil Brown)
o	Add more sanity checks to the dmi scanner	(me)
o	Fix hash sign assumptions in reiserfs		(Jeff Mahoney)
	| IMPORTANT: this makes things consistent, it also means
	| that if you have chars > 127 in file names _and_ you are
	| running unsigned char little endian default (probably a tiny tiny
	| number of mips users only) you will need to archive and recreate
	| those files. X86 users are _NOT_ affected.
o	Add the infrastructure for ac97_ops ready for	(me)
	digital audio etc

2.4.7-ac4
o	Fix inode cache shrinkage problems in 2.4.7	(Al Viro)
	| This should cure the problem where it gets 
	| really slow over time. Its not the final fix
o	Make aironet compile again			(Arjan van de Ven)
o	Fix an incredibly stupid i2o_scsi bug causing	(me)
	crashes with the adaptec 2100 and other stuff
o	Fix memory corruption if using gcc 3 and serial	(Thomas Hood)
	probing fails
o	Fix out of memory handling with raid		(Neil Brown)
o	Fix a raid mishandling bug on errors		(Neil Brown)
o	Add promise 20268 software raid card idents	(me)
o	Fix leaktek winview601 problems			(Leandro Lucarella)
o	Merge ntfs 1.1.16				(Anton Altaparmakov)
o	Avoid panic when reiserfs attempts to mount	(Nikita Danilov)
	invalid superblock
o	Error rather than panic on journal replay I/O	(Chris Mason)
	error in reiserfs
o	Update atp870u driver				(Wittman Lee)
o	First batch of superblock handling cleanup	(Al Viro)
o	Restore module oops dumping			(Kai Germaschewski)
o	NFSD update					(Neil Brown)
o	Fix ieee1394 sleep with spinlock held		(Andi Kleen)
o	Add AMD 760-MP to the Agp table			(me)
o	Rip out zillions of duplicated -ESPIPE		(Christoph Hellwig)
	llseek methods for a common one
o	Fix qlogic direction flag handling in 2.4	(Jeff Andre)
o	Clear inode->i-blocks on deletion in reisefs	(Nikita Danilov)
o	Merge rest of S/390 tty driver fixes		(Ulrich Weigand)
o	Finish adapting S/390 to new softirq code	(Ulrich Weigand)
o	Remove accidental duplicate block in Makefile	(Ulrich Weigand)
o	Update DASD drivers				(Ulrich Weigand)
o	Further pnpbios fixes				(Andrey Panin)
o	Switch pnp to use slab not malloc.h	(Arnaldo Carvalho de Melo)
o	Switch parport_cs to slab not malloc.h	(Arnaldo Carvalho de Melo)
o	Further config cleanups				(Steven Cole)
o	Fix make spec with no .version			(Keith Owens)
o	Further ipchains fixes				(Rusty Russell)
o	Add procfs info option for reiserfs stats	(Nikita Danilov)
o	Remove dead code from the reiserfs tree		(Jeff Mahoney)
o	Quota updates					(Jan Kara)
o	FreeVxFS leak fixes, allow block sizes != 1024	(Christoph Hellwig)
o	Improve serial_cs reporting			(Jonathan Corbet)
o	Add v7 fs sanity checks to the sys5 fs code	(Linus Torvalds,
				Christoph Hellwig, Al Viro, Andries Brouwer)

2.4.7-ac3
o	Add "make rpm" target				(me)
	| Remember to install not upgrade kernel rpms
	| as you will want to keep old ones around too
o	Fix FPU emulation breakage			(Brian Gerst)
o	Fix minix subpartition handling			(Andries Brouwer)
o	Add another odd vaio bios to the apm list	(Robert Dunlop)
o	Further Configure.help updates			(Steven Cole)
o	Update usb configure and help texts		(Brad Hards)
o	Fix kmem read loop bug				(Hugh Dickins)
o	Two warning fixes				(Art Haas)
o	Fix missing icmp errors for udp			(Alexey Kuznetsov)
o	Fix 3c59x module load problem			(Hugh Dickins)
o	Update pwc driver				(Nemosoft Unv)
o	Remove old non kernel code from reiserfs tree	(Nikita Danilov)
o	Remove unneeded reiserfsck code from tree	(Nikita Danilov)
o	Replace checks in CONFIG_REISERFS_CHECK with	(Nikita Danilov)
	cleaner macros
o	Add const's correct formatting/typechecking	(Nikita Danilov)
o	Clean up do_reiserfs_warning macro		(Jeff Mahoney)
o	Add Randolph Chung to CREDITS			(Matthew Wilcox)
o	Merge some pa risc tree Configure.help		(Matthew Wilcox)
o	Update the pa risc tree docs 			(Matthew Wilcox)
o	Add pa-risc keyboard drivers	(Debacker Xavier, Marteau Thomas,
					 Djoudi Malek, Philipp Rumpf, 
					 Alex deVries)
o	Update lasi ethernet drivers for pa-risc
o	Correct acenic check for parisc to hppa
o	HPPA port requires pci-setup
o	Add headers for som binary loader		(Matthew Wilcox)

2.4.7-ac2
o	Update motion eye driver, fix stack and hang	(Hugh Dickins)
	problems
o	Fix sigsuspend bug on Alpha			(Richard Henderson)
o	CRIS port updates				(Bjorn Wesen)
o	Add support for Win2K dynamic disk partitions	(Richard Russon,
							 Anton Altaparmakov)
o	ISDN multilink fix				(Karsten Keil)
o	HFC PCI support is now ITU approved		(Werner Cornelius)
o	Update sonypi driver				(Stelian Pop)
o	Fix sleep with irq disabled bug in act2000 	(Kai Germaschewski)
o	Farsync driver cleanups				(Bob Dunlop)
o	Remove surplus tty==NULL checks in isdn tty	(Rob Radez,
							 Kai Germaschewski)
o	Remove sleep with irq disabled in icn driver	(Kai Germaschewski)
o	Remove sleep with irq disabled bug in isdnloop	(Kai Germaschewski)
o	Remove bcopy and duplicate snprintf from eicon	(me)
	driver
o	Remove bzero from eicon driver, use skb_purge	(Armin Schindler)
o	Updated NinjaScsi driver			(YOKOTA Hiroshi)
o	Fix a jffs2 memory leak				(David Woodhouse)
o	Updated bttv driver. Corruption on close fixes	(Gerd Knorr)
o	Audio driver for bt878 tv chip onboard audio	(Gerd Knorr)
o	Correct nvram byte range limit			(Aaron Rendahl)
o	Include linux/smp_lock in shmem			(Clemens)
o	Add DMI/apm support for broken bioses reporting (Marc Boucher)
	battery life wrong endian
o	Fix dumb bug in the sbf code			(me)
o	Fix pnp shutdown oops				(me)

2.4.7-ac1
o	Alpha fixes and updates				(Jay Estabrook)
	- ioremap fixes for AGP on Alpha
	- pci_iommu support for AGP on Alpha
	- AGP arch support code for Alpha UP1x00
	- Fix instruction fault bug with old Jensen/UDB
	  PALcode
o	Further alpha pci iommu cleanups/fixes		(Ivan Kokshaysky)
o	Fix DAC960 for completion change		(Jens Axboe)
o	Fix data corruption on ide tape while reading	(Pete Zaitcev)
	near EOF
o	Switch up_and_exit to complete_and_exit		(David Woodhouse)
o	Fix crash on scsi request alloc failure in sd	(Rasmus Andersen)
o	Handle scsi register failure in ultrastor	(Rasmus Andersen)
o	Clean up ioremap as u32 stuff in ibmtr		(me)
o	Fix max_sector cleanup in paride		(Andrea Arcangeli)
o	
o	Bring IDE floppy up to date with maintainer	(Gunther Mayer)
o	Remove escaped junk from Makefiles		(Christoph Hellwig)
o	Fix cs46xx checks on ioctl calls		(Simon Horman)
o	Update cpqfc driver				(Charles White)
o	NTFS fixes			(Anton Altaparmakov, Rasmus Andersen)
o	Further FATfs updates				(OGAWA Hirofumi)
o	S/390 network driver updates			(Ulrich Weigand + )
o	Core S/390 changes to get it building again	(Martin Schwidefsky)
o	Fix S/390 tree asm blocks to compile with their	(       and
	newest gcc set
o	Update S/390 documentation			(other IBM folks)
o	Update S/390 tape driver			(       "	)
o	Update S/390 console driver			(	"	)
o	Don't do net hotplug during booting		(	"	)
o	Remove tools stuff from S/390 tree		(	"	)
o	Update S/390 irq/softirq handling		(	"	)
o	Add shared kerne support for S/390 VM		(	"	)
o	Update cpqarray driver				(Charles White)
o	Add missing barrier() calls in serial drivers	(me)
o	Fix menuconfig return code on small screen	(Herbert Xu)
o	Small UML fixups				(Jeff Dike)
o	Add COW support to UML block driver		(Jeff Dike)
o	USB network driver updates/fixes		(David Brownell)
o	PnP parsing bug fix				(Andrey Panin)
o	Fix UFS checking of NULL error cases		(Andreas Dilger)
o	Further shmem bits				(Christoph Rohland)
o	Update the mmap changes to handle OSF emulation	(Maciej Rozycki)
o	Fix failed register handling in g_NCR5380	(Rasmus Andersen)
o	Correct errors in devices.txt examples		(Andreas Dilger)
o	Synclink driver update				(Paul Fulghum)
o	Fix scc region requests for latches		(Rob Turk)
o	Fix FB_ACTIVATE_NOW/VBL handling on aty128fb	(Andreas Hundt)
o	Correct CRTC_OFFSET_CNTL on aty128fb		(Andreas Hundt)
o	Add Devfs support to rio500			(Gregory Norris
							 Greg Kroah-Hartmann)
o	3c59x driver updates				(Andrew Morton,
							 Donald Becker)
o	Fix ircomm handling with some mobile phones	(Andrea Arcangeli,
							 Dag Brattli)
o	Clean up resource handling in ibmtr driver	(Rasmus Andersen)
o	Handle out of memory for device alloc in gdth	(Rasmus Andersen)
o	Fix mixer leak in sb driver			(Mike Galbraith)
o	Make printk use vsnprintf			(Andrew Morton)
o	Fix bug in atm_do_connect_dev (bogus EINVALs)	(Germán González)
o	Add Sony DSC-575 to unusual devices usb list	(Denis Benoit)
o	Add gemtek pci radio card driver		(Vladimir Shebordaev)

2.4.6-ac5
o	Fix VIA workaround (I merged the wrong diff)	(me)
o	Small NTFS update				(Anton Altaparmakov)
o	Add io memory emulation to user mode Linux	(Greg Lonnon)
o	Futher uml management console updates		(Jeff Dike)
o	Update uml defconfig, clean up casts,signals 	(Jeff Dike, 
	suser to capable				 James Stevenson)
o	Fix midi via72cxxx 'bad devc' crash		(Adrian Cox)
o	Add snprintf/vsnprintf to the kernel		(Crutcher Dunnavant)
	| Lots of places want tweaking to use snprintf now
	| notably the isdn code with its own snprintf
o	Don't go off the end of the ROM looking for SBF	(me)
o	Fix warning in mce code				(Mikael Pettersson)

2.4.6-ac4
o	Update VIA southbridge bug fix to VIA provided	(me)
	workaround. 
	| Except we apply it even when no sblive is
	| present
o	Fix up includes to use slab.h			(Chris Wedgewood)
o	Switch es1371 internal amp to a table		(Frank Aune, me)
o	Merge improve zone balancing			(Marcelo Tosatti)
	| Should fix a lot of high zone balancing problems
o	Update to megaraid 1.17a			(Atul Mukker)
o	Add large file support to user mode Linux	(Lennert Buytenhek)
o	Add management console to user mode Linux	(Lennert Buytenhek)
o	IDE updates					(Andre Hedrick)
o	Updated SBNI drivers		(Yaroslav Polyakov, Denis I.Timofeev)
o	Fix the i810 'read any kernel memory' bug	(me)

2.4.6-ac3
o	Save registers on pnpbios calls			(me)
o	Avoid re-entrancy on PnPBIOs calls		(me)
o	Catch oopsing in PnPBIOS and print better	(me)
	diagnostics (ie rant about bios vendor)
o	Fix CONFIG_ARM entry				(me)
o	Fix reference to major in mnd_pinnacle		(me)
o	Merge Linus 2.4.7pre6
o	Fix dmi to return null string for string 0	(Matt Domsch)
o	Don't probe MCA serial space on non MCA x86	(me)
	| Fixes the Debian combo MCA/PCI kernel problems
o	Turbo pam isdn fix				(Stelian Pop)
o	Add ISAPnP PCMCIA adapter support		(Andrey Panin)
o	Fix NO_FSBR and ZERO_PACKET user urbs		(Thomas Sailer)
o	Fix types used in sk98 for save/restore flags	(Jes Sorensen)
o	Update Configure.help				(Fumiaki OHATA)
o	Fix scheduler/yield bug				(Andrea Arcangeli)
o	Ext2fs clean up of high/acl usage		(Andreas Dilger)
o	Fix chattr on ext2 directories			(Andreas Dilger)
o	Correct quota read/write check			(Andreas Dilger)
o	Fix i810_tco oops				(Randy Dunlop)
o	Update bootflag handler				(Randy Dunlop)
o	Fix errata/erratum comment errors		(David Woodhouse)
o	Further starfire fixes				(Ion Badulescu)
o	Fix FAT overflow due to signed i_pos		(OGAWA Hirofumi)
o	Fix reiserfs tree balance/filldir race		(Chris Mason)
o	USB check for vendor types in devio		(Dan Streetman)
o	Clean up the dynamic aic7xxx files in make clean(Tim Hockin)
o	Fix pci ordering in headers			(Tim Hockin)
o	Add DMI detection for funny purple laptops	(Stelian Pop)
o	Bluetooth driver update				(Greg Kroah-Hartmann)
o	Fix pnpbios help width				(Randy Dunlop)
o	Edgeport driver update				(Greg Kroah-Hartmann)
o	Fix softirq pending breakage in UML		(Jeff Dike)
o	Add ID for CPIA2 cameras			(Steve Miller)
o	dmi printk fix					(Robert Dunlop)
o	USB storage wrong ID for SDDR-09		(Phil Stracchino)
o	Add configure.help for VAIO LCD mode		(Stelian Pop)
o	Add larger readahead to the ataraid		(Arjan van de Ven)
o	Further ISAPnP idents for SB variants		(Bill Nottingham)
o	Minixfs updates					(Al Viro)
o	Frank Denis has moved email			(Frank Denis)
o	Support triple indirect shmem for S/390x	(Christoph Rohland)
o	shmem race fix					(Christoph Rohland)
o	Fix hole in binfmt_elf loader			(Sebastian ,
							 Solar Designer)
o	Merge farsync synchronous driver		(Bob Dunlop)
o	8139too locking fix				(Masaru Kawashima)
o	Update do_wp_page documentation			(Hugh Dickins)

o	Fix zr36120 range check				(me)
	| This batch is all from the Stanford checker
o	Fix stradis range check				(me)
o	Fix i2c maths overrun security check		(me)
o	Fix bttv range check				(me)
o	Fix zr36067 range check				(me)
o	Limit unique length to 1024 in drm		(me)
o	Bound nframes on cd-rom reading			(me)
o	Add missing range check on ov511		(me)
o	Fix range checks in mga				(me)
	| I've no idea if I've broken the matrox driver in doing so
	| but right now I dont actually care. XFree need to fix it right
o	Ditto for radeon				(me)
o	Ditto for r128					(me)
o	Ditto for matrox pci				(me)
o	And generic drm_addbufs				(me)
o	Fix missing <0 check on sbpcd read audio	(me)
o	Fix wrong kfree order in ali-ircc		(me)
o	Fix use of freed object in CDCEther		(me)
o	Fix double free of urb in usbnet		(me)
o	Fix wrong free in usb_new_device		(me)

* Note that the i810 drm bug reported by the checker looks exploitable. It
needs someone from XFree86 with i810 docs to fix this. In the mean time
people should probably disable the i810 drm support if its an issue.

2.4.6-ac2
o	Merge Linus 2.4.7pre1
o	Drop out various bits that are 2.5 stuff
	AS/400 etc
o	Merge Linus 2.4.7pre2
o	Merge Linus 2.4.7pre3
o	Handle strange USB descriptors in CDCEther	(Brad Hards,
	| Fixe Motorola SB4100 cable modem		 Jason Purdy)
o	Experimentally add aha1505 isapnp support	(Peter Samuelson)
o	Fix SMP race in buffer.c			(Andrew Morton)
o	Fix fs/sysv/dir.c link mishandling		(Al Viro)
o	D-Link 2000 Gigabit ethernet driver		(Edward Peng)
o	EEPro100 fixes					(Kai Germaschewski)
o	Radeon frame buffer driver updates		(Ani Joshi)
o	Incorrect PPC irq assignment fix		(Paul Mackerras)
o	Fix usb scanner ioctl error return		(Paul Mackerras)
o	Fix ohci ppc build				(Paul Mackerras)
o	Avoid oom handler firing excessively early	(Rik van Riel)
o	Fix imsttfb build bug				(Paul Mackerras)
o	Add another kaweth ethernet id			(Fumiaki OHATA)
o	i810 audio driver updates			(Doug Ledford)
o	Vm86 sti handling fixup				(Stas Sergeev)
o	Fix non pnpbios build				(Steve Cole)
o	Remove SGML short forms from video docs		(Erik Mouw)
o	Pnp comments change for remove op		(Jeff Garzik)
o	Revert epic100 MII change			(Jeff Garzik)
o	Update Jes maintainer info			(Jes Sorensen)
o	Add test shared irq support to fdomain driver	(me)
o	Add mising DQUOT_INIT in inode.c		(Al Viro)
o	Fix device locking leak in pppoe	(Arnaldo Carvalho de Melo)
o	Clean up the pnpbios BIOS calling code		(Brian Gerst)
o	Configure.help updates				(Eric Raymond)
o	Don't autoload parport_serial in parport	(Tim Waugh)
o	Update atyfb					(Geert Uytterhoeven)
o	Fix procfs reporting of ataraid			(Arjan van de Ven)
o	Upate ATP870u driver to handle the new		(Wittman Lee)
	6760 U160 hardware
o	Further ALi trident driver updates		(Matt Wu)

2.4.6-ac1
o	Merge with Linus 2.4.6
o	Fix 2.4.6 pci_enable_device breakage		(Kai Germaschewski)
o	Fix missing ";" in ide-tape debug modes		(Johh Guthrie)
o	Update usb serial driver			(Greg Kroah-Hartmann)
o	Fix ppc build error				(Paul Mackerras)
o	Fill out core of pnpbios hotplug structure	(me)
	| ie borrow from PCI

2.4.5-ac24
o	Serverworks AGP support				(Jeff Hartmann)
o	Split I/O requests on pdcraid/hptraid when 	(Arjan van de Ven)
	they cross stride
o	Fix hangs on TI1410 cardbus bridge		(Erik Mouw)
o	Update Configure.help				(Eric Raymond)
o	Fix bug in ext2_new_inode			(Al Viro)
o	Fix double pci_set_power_state stub		(Jeff Garzik)
o	Fix mcheck_disable				(Andrew Morton)
o	Merge 2.4.6-pre9
	- Ignored ATI changes versus old atyfb codebase
	- Remove several totally broken drivers/net/Config.in changes
o	Update act2000 isdn driver			(Kai Germaschewski)
o	Fix ELOOP handling bug				(Al Viro)

2.4.5-ac23
o	Merge with 2.4.6pre8
	| This should make things much more stable
o	Restore backed out shm patches			(Christoph Rohland)
o	Fix quotaoff crash				(Jan Kara)
o	Move stuff into BSS on decnet			(Xavier Bestel)
o	Update ims twinturbo fb maintainer		(Paul Mundt)
o	Update Crutcher Dunnavant's email address	(Crutcher Dunnavant)
o	UML ^S/^Q support for the console and serial	(Livio Soares)
o	code cleanups in UML drivers			(Jeff Dike)
o	UML include and #define cleanups	(Niels Kristian Bech Jensen)
o	UML ubd driver defines blk_size correctly	(Roman Zippel)
o	which allowed clean up of related ubd code	(Jeff Dike)
o	tweak the UML definition is a fixable seg fault	(Jeff Dike)
o	fix the UML TASK_UNINTERRUPTIBLE deadlock 	(Jeff Dike)
o	Update ldconfig scripts for multiple rodata	(Jakub Jelinek)
o	Small isdn.h fixes				(Kai Germaschewski)
o	Add Advantech TurboPAM isdn			(Stelian Pop)
o	Maxine frame buffer cleanups			(Paul Mundt)
o	UDF cleanup				(Arnaldo Carvalho de Melo)
o	Fix jffs2 includes				(Keith Owens)
o	Small cleanups to vt.c			(Arnaldo Carvalho de Melo)
o	Clean up istallion driver		(Arnaldo Carvalho de Melo)
o	Clean up sh-sci driver			(Arnaldo Carvalho de Melo)
o	Clean up selection			(Arnaldo Carvalho de Melo)
o	Small random driver cleanups		(Arnaldo Carvalho de Melo)
o	Small tty_io cleanup			(Arnaldo Carvalho de Melo)
o	Small isdn_tty cleanup			(Arnaldo Carvalho de Melo)
o	Expose scsi_add/del_timer for hosts
	to adjust timeouts when they know better	(Matthew Jacob)
o	Remove unneeded init of data			(Xavier Bestel)
o	Remove unneeded init of data in wavfront	(Xavier Bestel)
o	Remove unneeded init of data in sb		(Xavier Bestel)
o	Remove unneeded init of data in nm256		(Xavier Bestel)
o	Remove unneeded init of data in oss sound	(Xavier Bestel)
o	Remove unneeded init of data in cs4232		(Xavier Bestel)
o	Remove unneeded init of data in ultrastor	(Xavier Bestel)
o	Remove unneeded init of data in scsi/hosts.c	(Xavier Bestel)
o	Remove unneeded init of data in i2o_core	(Xavier Bestel)
o	Fix strange fs/exec.c error return		(Andrew Morton)
o	Remove unneeded init of data in mcd		(Xavier Bestel)
o	Clean up belkin_sa ioctl code		(Arnaldo Carvalho de Melo)
o	Clean up ftdi_sio ioctl code		(Arnaldo Carvalho de Melo)
o	Clean up mct_u232 ioctl code		(Arnaldo Carvalho de Melo)
o	Tidy ircomm_tty_ioctl			(Arnaldo Carvalho de Melo)
o	Work around cypress cy723c693 RTC stability bug	(Ivan Kokshaysky)
o	Clean up autofs user access slightly	(Arnaldo Carvalho de Melo)
o	Small fs/exec.c clean ups		(Arnaldo Carvalho de Melo)
o	Fix eepro100 oops with power management		(Marc Boucher)

2.4.5-ac22
o	Fix the remaining make xconfig mess		(me)
o	Add APM disabling on DMI match			(me)
	| Needed for the Trigem Delhi3 (aka E Machines E-Tower 333cs)
o	Fix pnpbios without hotplug (I hope)		(me)
o	Merge an escaped via midi fixup			(Adrian Cox)
o	Revert minixfs changes

2.4.5-ac21
o	Fix pnpbios compile failure and add docking	(me)
	station hotplug (/sbin/hotplug dock)
o	Fix make xconfig failure			(Keith Owens)
o	Fix cciss pci device table			(Marcus Meissner)
o	Fix bogus math.h include in iphase driver	(Arjan van de Ven)
o	Reiserfs vm deadlock fix			(Chris Mason)
o	Make the i810 tco disable info clearer		(Andrey Panin)
o	Correct bzImage size limit check		(Pavel Machek)
o	Next lvm patch					(Joe Thornber)
o	Fix toshoboe for pm api change			(me)

2.4.5-ac20
o	Commence resync with 2.4.6pre5
	- Merge kernel doc tool changes
	- Merge sunrpc printk check change
	- Merge net core changes
	- Merge Bluetooth stack
	- Merge inet proto register
	- Merge bridge updates
	- Merge net/ipv4 and ipv6 changes
	- Merge x86 arch support
	- Merge m68k port changes
	- Merge ppc port changes
	- Merge sparc32/64 changes
	- Merge ACPI
	- Merge ll_rw_blk changes
	- Merge miro rds changes
	- Merge USB updates

	Kept xtime volatile - pending verification drivers are safe with
		 this change
	Kept old atyfb code (someone needs to sort out which atyfb is the
		one being worked on and get that tree into the kernel)
	
	As with 2.4.6pre power management PCI interface changes
	mean power management is likely to be broken somewhat

	Also there is some kind of deadlock I suspect related to the
	mm changes in 2.4.6pre/2.4.5ac14
o	Resync with 2.4.6pre6
o	Add macserial printk levels		(Arnaldo Carvalho de Melo)
o	Add picturebook vaio wide console mode support	(Marcel Wijlaars)
o	Riscom8 driver printk/regions etc	(Arnaldo Carvalho de Melo)
o	ESP serial driver clean up		(Arnaldo Carvalho de Melo)
o	dz serial driver clean up		(Arnaldo Carvalho de Melo)
o	Fix hangs during heavy buffer I/O		(Arjan van de Ven)
	(eg mke2fs)
o	Clean up doubletalk driver		(Arnaldo Carvalho de Melo)
o	Further imsttfb updates				(Paul Mundt)
o	MTD missing export fixes			(David Woodhouse)
o	MTD configure script fixes			(me)
o	MTD include fixes				(me)
o	Yamaha pci audio cleanup , longer delay		(Pete Zaitcev)
o	i810 ioctl fix					(Damjan Lango)
o	Add printk levels to tty_io.c		(Arnaldo Carvalho de Melo)
	and tty_ioctl.c
o	Small acm serial driver cleanup		(Arnaldo Carvalho de Melo)
o	Printk levels for via-pmu		(Arnaldo Carvalho de Melo)
o	Improve kernel-doc parser			(Christian Kreibich)
o	Disable AMI megaraid 64bit mode			(Martti Hyppänen)
	| Seems the HP board firmware reports 64bit supported but
	| it doesn't actually work reliably on them
	
2.4.5-ac19
o	Update Gareth Hughes contact info		(Gareth Hughes)
o	Make sure NFS atime is handled by server	(Trond Myklebust)
o	Fix Configure.help glitch			(Geert Uytterhoeven)
o	Fix nfs readdir EIO and duplicates bug		(Trond Myklebust)
o	Fix netlink removal of proc directory		(Herbert Rosmanith)
o	Use skb_purge_queue in net stacks	(Arnaldo Carvalho de Melo)
	| lapb, netrom, econet, rose, ax25, atm, sched,
	| socket core, unix
o	Fix reference after free in eql driver	(Arnaldo Carvalho de Melo)
o	Fix reference after free in shaper 	(Arnaldo Carvalho de Melo)
o	Gameport fixes for Alpha			(Jeff Garzik)
o	Configure.help updates				(Eric Raymond)
o	JFFS copyright banner update			(David Woodhouse)
o	Update docs on binfmt_misc java 		(Kurt Huwig)
o	Fix tty release_mem oops			(Tachino Nobuhiro)
o	Pull nfs data out of inode struct		(Al Viro)
o	Assorted UML fixes				(Jeff Dike)
o	Improve missed tick handling on UML		(Jeff Dike)
o	Fix hdc/hdd reporting on disks in /proc/stat	(Martin Wilck)
o	Fix sign extension of dirent's in readdir	(Trond Myklebust)
o	Ensure LVM dropped snapshot is not reactivated	(Joe Thornber)
o	Change kiovec handling in LVM			(Joe Thornber)

2.4.5-ac18
o	Issue scsi retries on 'not ready'		(Khalid Aziz)
o	Lave 1uS gaps in the eepro100 cmd probe, and	(Masaru Kawashima)
	probe for longer on cmd timeout
	| Experiment to see what happens
o	Prefetch the io_request_lock in the i2o block	(me)
	irq handler
o	Prefetch atomics and locks in the i2o_scsi	(me)
	driver
o	Fix wrong config define in asm-i386/processor.h	(Arjan van de Ven)
o	Use skb_queue_purge in atmarpd		(Arnaldo Carvalho de Melo)
o	Fix RLIMIT_NPROC accounting and root problem	(Rik van Riel)
o	Check out of memory case in i2c_parport		(Rasmus Andersen)
o	Enable internal amp on Targus Xtender and	(Frank Aune)
	Mebius PC-MJ100V
o	X.25 cleanups				(Arnaldo Carvalho de Melo)
o	Don't try and load parport_serial if it wasnt	(Niels Jensen)
	built
o	interrupt.h needs sched.h for some ports	(Jeff Garzik)
o	Fix nwflash driver locking problems		(Russell King)
o	Fix bug ac17 added to the i810 tco driver	(Andrey Panin)
o	Fix memory pressure accounting bug		(Rik van Riel)
o	Small syncppp cleanups			(Arnaldo Carvalho de Melo)
o	Fix an sg leak on error path			(Doug Gilbert)
o	Fix comx_proto_fr possible leak		(Arnaldo Carvalho de Melo)
o	Update ataraid driver, add hpt raid support	(Arjan van de Ven)
o	Fix highmem leak in nfs when taking signals	(Trond Myklebust)
o	Update Rik van Riel's credits entry		(Rik van Riel)
o	via audio updates, midi support, endian fixes	(Adrian Cox)
o	Further Configure.help merges			(Eric Raymond)
o	Update AMD756 pci irq routing driver		(Jhon Caicedo)
o	Make nvram allow the full 128 bytes on newer 	(Dave Jones)
	PC's
o	Update the simple boot flag support		(Dave Jones)
	| User space is now expected to set booted ok, via the
	| nvram driver
o	Set -fno-common to catch duplicate variable	(Arjan van de Ven)
	bugs
o	Handle out of memory in sr.c get_capapbilities	(Rasmus Andersen)
o	SIS900 driver warning fix			(Dave Miller)
o	Update 64bit unclear driver checks		(Jeff Garzik)
o	Fealnx and sundance driver updates		(Dave Miller)
o	Small pppo driver cleanups		(Arnaldo Carvalho de Melo)
o	Handle proc entry create failure in videodev	(Rasmus Andersen)

2.4.5-ac17
o	Sanity check the BIOS tables for bootflag	(me)
o	Update multicast support by devices doc		(Ralf Baechle)
o	Fix iohi=0 option in parport			(Tim Waugh)
o	First set of ipt_unclean fixes			(Rusty Russell)
o	Add YUV420P to the pwc driver			('Nemosoft')
	| This is the compromise - its simply an unpacking order option
	| not RGB/YUV
o	Swapfile bugfix					(Stephen Tweedie)
o	Allow readahead to be tuned for big arrays	(Craig Hagan)
o	Add PIRQ router support for the AMD756		(Jhon Caicedo)
o	Fix bootflag bitmasks				(Dave Jones)
o	Fix lseek limit handling			(Martin Frey)
o	The joystick/gameport symbol game continued	(Keith Owens)
o	Update i810 tco driver to know about 815,820 ..	(Andrey Panin)
o	Fix missing allocation failure checks in
	drm, mtd, aironet, skfp, scsi, irda		(Chip Turner)
o	Further lvm updates				(Joe Thornber)
	| Fixes VG_CREATE_OLD problem

2.4.5-ac16
o	Drop the shmem/removepage changes to see if they(me)
	are cuaisng the instabilities in ac15
o	Fix bug in pci_init_module causing serial crash (me)
	| Figured out by Niels Jensen
o	Alpha build fixes for keyboard change		(Jay Thorne)
o	Tidy up imsttfb driver				(Paul Mundt)
o	Fix tdfxfb warning				(Steven Walter)
o	Fix fat fs build on ARM				(Russell King)
o	Fix catc help text				(Brad Hards)
o	Fix missing unlock_kernel in fs/locks.c		(Andrey Savochkin)
o	Minixfs alloc_branch fixes			(Al Viro)
o	Support bootflag extension			(me)
	| Experimental
o	Add EMC Symmetrix to the sparselun list		(Alar Aun)
o	Update the ioc3 ethernet			(Ralf Baechle)
o	Add ataraid to the known root names		(Arjan van de Ven)
o	Further Sony Pi driver upgrades			(Stelian Pop)
o	Add geometry queries to the ataraid driver	(Arjan van de Ven)
o	Add ALi IRDA FIR support			(Benjamin Kong)
o	Fix gameport compile failures			(Keith Owens)
o	Fixes IrLMP states stuck in CONN_PEND state	(Jean Tourrilhes)
o	Small cris config fixes			(Andrzej Krzysztofowicz)
o	Fix some potential irlan bugs/stack abuse	(Ted Unangst)
o	Fix OSS API bug in USB audio			(Bruce Nesbitt)
o	Update the MIPS64 core				(Ralf Baechle,
					 Thiemo Seurer, and others)
o	Update the MIPS32 core		(Ralf Baechle, Kevin Kissell,
					 Carsten Langgaard, Justin Carlson,
					 Jun Sun)
o	Add a driver for the AU1000 ethernet		(P Popov)
o	Fix security problems with i810 and MGA drm	(Jeff Hartmann)
o	Use a saner computation for maxthreads		(Rik van Riel)
o	Update matroxfb, support G100 SGRAM		(Petr Vandrovec)
o	Fix hang in scsi generic with cdrdao		(Doug Gilbert)
o	Correct aha152x abort fix			(Jüergen E. Fischer)

2.4.5-ac15
o	Enable MMX extensions on Cyrix MII		(me)
o	Make pid on core dump configurable		(Ben LaHaise)
o	Random UML fixups, add fcntl64/getdents64	(Jeff Dike)
o	Add multicast support to UML			(Harland Welte)
o	Ensure promise raid driver doesnt look at non	(Arjan van de Ven)
	disk devices
o	Fix IDE chipsets that incorrectly think a 64K	(Mark Lord)
	DMA is in fact zero size
o	Fix generic alpha build trident driver		(Michal Jaegermann)
o	SHM accounting fixes				(Christoph Rohland)
o	Update refill_inactive to match Linus tree	(Rik van Riel)
o	Add Asustek L8400K to the dmi data		(me)
o	Add kernel mode keyboard rate setup		(Sergey Tursanov)
o	Alpha compile fix				(Richard Henderson)
o	Add Ali1533 to the isa dma quirks		(Angelo Di Filippo)
o	Fix a procfs oops				(Al Viro)
o	Alpha symbol/warning fixes			(Michal Jaegermann)
o	Some laptops take a long time for the cs4281	(Rik van Riel)
	and codec bus to wake up 
o	Fix potential flags corruption on error path	(me)
	in comx-mixcom driver

2.4.5-ac14
o	Fix oops on command abort on aha152x		(me)
	| This so far is only a partial fix
o	Switch to unlazy swap cache free up		(Marcelo Tosatti)
o	Page launder changes				(Rik van Riel)
o	Remove dead irda irlap compression code		(Dag Brattli)
o	Fix bug where init/main.c executes freed code	(Hans-Peter Nilsson)
o	Fix ramfs accounting. truncate/freepage hook	(Christoph Rohland)
o	Add MTWEOF ioctl to parallel tape		(Russ Ingram)
o	Add driver for CATC based USB ethernet		(Vojtech Pavlik)
o	Update cris architecture code			(Bjorn Wesen)
o	Clean up reiserfs tail->full page convert	(Chris Mason)
o	Clean up lp init, fix lp= option handling	(Tim Waugh)
o	Don't panic on out of memory during ps/2 setup	(Andrey Panin)
o	Initialise vc_cons objects in full		(Richard Hirst)
o	Futher Configure.help resync			(Eric Raymond)
o	Fix misdeclaration of xtime			(Petr Vandrovec)
o	Add yet more sb variants			(Andrey Panin)
o	Fix bogus VIA warning triggers (I hope)		(me)
o	Fix 3c509 symbols when building nonpnp		(Keith Owens)

2.4.5-ac13
o	Fix i2o_block to use invalidate_device		(me)
o	Fix viodasd to use invalidate_device		(me)
o	Fix missing ipc alloc check			(Manfred Spraul)
o	Use skb_purge_queue in isdn			(Kai Germaschewski)
o	Fix epic100 printk error			(Francois Romieu)
o	Resync with master Configure.help		(Eric Raymond)
o	Avoid oops when reading swap proc during swapon	(Paul Menage)
o	Sony pi driver update				(Stelian Pop)
o	Sony motioneye camera driver			(Stelian Pop, 
							 Andrew Tridgell)
o	Fix eepro100 access by user to some registers	(Andrey Savochkin)
o	Small APM real mode reboot clean ups		(Stephen Rothwell)
o	Fix isofs buffer leak on invalid iocharset	(Tachino Nobuhiro)
o	Fix default encoding on pwc videocam		(Mark Cooke)
o	Clean up FAT further, fix endian bug, and times	(OGAWA Hirofumi)
	before 1/1/1980
o	Support combo parallel/serial PCI cards		(Tim Waugh)
o	CS46xx mmap oops fix				(me)

2.4.5-ac12
o	Report apic timer vector in hex too		(Philip Pokorny)
	| With 0x in front so we can tell on reports..
o	Report card services differently if kernel	(Jeff Garzik)
o	Don't terminate init on sysrq			(Adam Slattery)
	unless forced
o	Add more pci wrappers when PCI is off		(Jeff Garzik)
o	Remove 4K object from the stack in emu10k1	(me)
o	Remove 3.5K object from the i2o_proc stack	(me)
o	Remove 3K object from the ewrk3 ioctl stack	(me)
o	Fix bugs in the es1371 locking			(me)
o	Fix ohci iso alignments				(Roman Weissgaerber)
o	Updated megaraid driver				(Atul Mukker)
	| In paticular this now uses the new PCI api

2.4.5-ac11
o	Fix the megaraid driver ioctl check		(me)
o	Fix the moxa ioctl checks			(me)
o	Fix the i810 dri length check			(me)
o	Fix array check in se401.c			(me)
o	Fix scc irq array problems			(me)
o	Fix sign check on zr36120			(me)
o	Fix sign check in raw driver			(me)
o	Fix zr36067 array size check			(me)
	| All the above from the Stanford checker
o	Fix an irq order assumption in the i810 audio	(Doug Ledford)
o	Make real mode poweroff configurable and also	(Arjan van de Ven)
	add DMI entries for it
o	Clean up Alpha oops reporting			(Will Woods)
o	Fix ia64 build bug from mmap change		(Bill Nottingham)
o	Fix sysinfo padding so m68k comes out right	(Jes Sorensen)
o	Update pci ids related to ide devices		(Andre Hedrick)
o	Update ide registers/ioctl numbers/info		(Andre Hedrick)
o	Fix speed detection on slc90e66			(Andre Hedrick)
o	Update promise IDE driver			(Andre Hedrick)
o	osb4 becomes generic serverworks ide driver	(Andre Hedrick)
o	Use new inits on ide_tape, add a reinit		(Andre Hedrick)
o	Use new inits on ide_floppy add a reinit	(Andre Hedrick)
o	Add amd74xx ide driver				(Andre Hedrick)
o	Tidy up ide disk init/reinit. Add feature	(Andre Hedrick)
	register clear
o	Additional ide updates				(Andre Hedrick)

2.4.5-ac10
o	Fix xircom cardbus filter setup			(Ion Badulescu)
o	Dave Jones has moved				(Dave Jones)
o	Further Configure.help cleanup			(Eric Raymond)
o	Switch usb serial driver locking		(Greg Kroah-Hartmann)
o	Update IRDA Irnet protocol code			(Jean Tourrilhes)
o	Update ide-tape and osst drivers		(Willem Riede)
o	Add ethtool support to ne2k-pci			(Jeff Garzik)
o	Misc small network driver tweaks/cleanup	(Jeff Garzik)
o	Module description strings for net drivers	(Jeff Garzik)
o	Fix thread/unload race in reiserfs		(Nikita Danilov)
o	Fix a race in reiserfs_writepage		(Chris Mason)
o	Add prolific 2203 USB serial support		(Greg Kroah-Hartmann)
o	Update isdn maintainers				(Kai Germaschewski)
o	Add another USS720 device entry			(Steve Tell)
o	Reap dead swap cache pages			(Marcelo Tosatti)
o	Fix USB sign handling error			(Jochen Pernsteiner)
o	Update input driver docs			(Vojtech Pavlik)
o	Fix locking bug in hysdn			(Kai Germaschewski)
o	Fix hid parsing bug with feature reports	(Vojtech Pavlik)
o	Fix ataraid config.in bug			(Jim Wright)

2.4.5-ac9
o	Fix gameport link problems			(Vojtech Pavlik)
o	Fix an oops in the sg driver			(Tachino Nobuhiro)
o	Fix brlock indexing bug				(Takanori Kawano)
o	Add parport_pc_unregister_port			(Tim Waugh)
o	Configure.help updates				(Eric Raymond)
o	Fix xircom_cb problems with some cisco kit	(Ion Badulescu)
o	Fix tdfxfb cursor rendering bug			(Franz Melchior)
o	Add driver for the sony vaio i/o controller	(Stelian Pop, 
				Junchi Morita, Takaya Kinjo, Andrew Tridgell)
o	Orinoco updates for symbol, intel, 3com cards	(Jean Tourrihles)
o	Use list_del_init in uhci driver		(Herbert Xu)
o	Fix a uhci SMP deadlock				(Herbert Xu)
o	Allow faster freeing of reisefs metadata	(Chris Mason)
o	Fix error path leaks in reiserfs		(Chris Mason,
							 Vladimir Saveliev)
o	Fix NFS problems triggered by 2.4.5 mmap change	(Trond Myklebust)
o	Resynchronize with m68k tree			(Jes Sorensen)
o	Add es1371 sound driver locking			(Frank Davis)
o	Fix a small error in the trident locking	(Frank Davis)

2.4.5-ac8
o	Fix sign handling bug in random sysctl		(me)
	| From Stanford tools
o	Add more idents to the NS558 driver		(Vojtech Pavlik)
o	Fix oops on some HID descriptor sets		(Vojtech Pavlik)
o	Fix reuse bug in UML net code + clean up	(Jeff Dike)
o	ES1370 driver locking				(Frank Davis)
o	Update init/main.c patch for umask		(Andrew Tridgell)
o	Fix uml fault race, and looping fault on 	(Jeff Dike)
	protection error
o	Update devices.txt				(H Peter Anvin)
o	Update the airo driver (fix pci pm oops.	(Jeff Garzik)
	spinlock abuse, delete after kfree, unchecked
	copies)
o	Remove old UML umn driver			(Jeff Dike)
o	Fix resource leaks and printk levels in isapnp	(Mike Borrelli)
o	Add new procfs programming documentation	(Erik Mouw)
o	Fix usb xconfig breakage		(Andrzej Krzysztofowicz)
o	Replace accidentaly lost UP_APIC help		(Mikael Pettersson)
o	Olypmic driver update				(Mike Phillips)
o	Clean up LVM spelling, debug macros		(Andreas Dilger)
o	Make various bits of LVM static			(Andreas Dilger)
o	Make lvm_snapshot_use_rate its own function	(Andreas Dilger)
o	Make lvm_do_lv_create loop the right amount
o	Fix lvm stamping on a semaphore causing an oops
o	Fix lvm hardware block size handling		(Andrea Arcangeli)

2.4.5-ac7
o	UML cleanups					(Jeff Dike)
o	Trap invalid addresses in UML ethernet driver	(Jeff Dike)
o	Reimplment UML user space access		(Jeff Dike)
o	Add device node support to hostfs		(Jorgen Cederlof)
o	Fix hang if the UML net helper fails to run	(Jeff Dike)
o	Support setting time in UML kernels		(Livio Baldini Soares)
o	Move more non portable code out of UML core	(Jeff Dike)
o	Merge most of remaining UML ppc changes		(Chris Emerson)
o	Printk cleanups, remove one non portable	(James Stevenson)
o	Add speaker mixer support to the cmpci mixer	(Carlos Gorges)
o	Fix inittdata ordering in i2c docs	     (Andrzej Krzysztofowicz)
o	Add usb skeleton driver				(Greg Kroah-Hartmann)
o	Fix ns558 unload 				(Marcus Meissner)
o	Further cs46xx fixing				(Frank Davies)
o	S/390 updates from the IBM folks		(Martin Schwidefsky)
o	CS46xx pop/crackle fixes on IBM T20		(Thomas Woller)
o	Make USB require PCI				(me)
o	Tulip driver update				(Jeff Garzik)
o	Fix slip/slhc missing symbols problem		(Michael Guntsche)
o	IRDA updates					(Dag Brattli)
o	Add cs4232 isapnp probing			(Marcus Meissner)
o	Merge airo_cs driver		(Benjamin Reed, Javier Achirica,
							Jean Tourrilhes)
o	VIA workarounds for APIC IRQ routing		(Jeff Garzik)
o	Fix bootmem.c comment cut&paste accident	(Richard Urena)
o	Update LVM with new VG_CREATE ioctl (and 	(Joe Thornber)
	VG_CREATE_OLD for back compatibility)
o	Fix pv_t/lv_t confusion in lv_status_bydev_req	(Joe Thornber)
o	Lots of update/fixes for _lv_status_by* code	(Joe Thornber)
o	Add support for I2O IOP's requiring private	(me)
	resource spaces
o	Hopefully fix hid jerkiness			(Michael)

2.4.5-ac6
o	Fix the cs46xx right this time			(me)
o	Further FATfs cleanup				(OGAWA Hirofumi)
o	ISDN PPP code cleanup, cvs tag update		(Kai Germaschewski)
o	Large amount of UFS file system cleanup		(Al Viro)
o	Fix endianness problems in FATfs		(Petr Vandrovec)
o	Fix -ac quota crashes				(Jan Kara)
o	Fix bluetooth out of memory handling		(Greg Kroah-Hartmann)
o	Fix freevxfs readdir				(Christoph Hellwig)
o	Fix freevxfs sign/unsigned issues		(Christoph Hellwig)
o	Fix doctypos, other freevxfs cleanup		(Christoph Hellwig)
o	Fix flush_dirty_buffers warning			(J A Magallon)
o	Add Carlos Gorges to credits			(Carlos Gorges)
o	Further atm cleanup fixes (kmalloc/signedness)	(Mitchell Blank)
o	Fix hotplug variable in matroxfb		(Petr Vandrovec)
o	Fix ns558 crash					(Vojtech Pavlik)
o	Revert to Pete Zaitcev's khub locking		(Pete Zaitcev)
	| It works for me, Johannes changes don't seem to
o	Fix usb Config.in breakage for input devices	(Vojtech Pavlik)
o	Add another 3c509 ISAPnP id			(Marcus Meissner)
o	Fix oopses and null checks on iphase		(Mitchell Blank)
o	CS46xx update					(Thomas Woller)
o	Fix mmap cornercase				(Maciej Rozycki)
o	Tidy up aironet and saa9730 delay abuse	   (Andrzej Krzysztofowicz)
o	Force initial umask to be sane for broken	(Andrew Tridgell)
	init programs
o	Teach CML1 to strip out <file: > from the	(Eric Raymond)
	Configure.help
o	Resync with Eric's master Configure.help	(Eric Raymond)
o	Revert FIOQSIZE	
o	Fix missing copy_*_user in cosa driver		(me)
	| From Stanford tools
o	Fix missing copy_*_user in eicon		(me)
	+ clean up ioctls a bit more
	| From Stanford tools
o	Fix use after free in lpbether			(me)
	| From Stanford tools
o	Fix missing return in rose_dev			(me)
	| From Stanford tools
o	Fix use after free in bpqether			(me)
	| From Stanford tools

2.4.5-ac5
o	Fix bug introduced in cs46xx/trident locking	(me)
o	Fix reiserfs unload/exit locking race		(Paul Mundt)
o	Miscellaneous small UML updates			(Jeff Dike)
o	Further FAT cleanups				(OGAWA Hirofumi)
o	Fix ext2fs oops following disk error		(Andreas Dilger)
o	Optimise segment reloads, syscall path		(Andi Kleen)
o	Clean up .byte abuse where asm is now known	(Brian Gerst)
	by required tools
o	Fix eepro100 on 64bit machine bitops bug	(Andrea Arcangeli)
o	Move the pagecache and pagemap_lru_lock to	(Andrea Arcangeli)
	different cache lines
o	Clean up .byte abuse where asm is now known	(Brian Gerst)
	by required tools
o	Fix user space dereference in bluetooth		(me)
	| From Stanford tools
o	Fix user space dereference in sbc60wdt		(me)
	| From Stanford tools
o	Fix user space dereference in mdc800		(me)
	| From Stanford tools
o	Fix a rather wrong memset in nubus.c		(Chris Peterson)
o	Remove fpu references from dmfe			(Arjan van de Ven)
o	Fix spelling of Portuguese			(Nerijus Baliunas)

2.4.5-ac4
o	APIC parsing updates				(Ingo Molnar)
o	Retry rather than losing I/O on an IDE DMA	(Jens Axboe)
	timeout.
o	Add missing locking to cs46xx			(Frank Davis)
o	Clean up sym53c416 and add PnP support		(me)
o	Tidy up changelog in apm.c			(Stephen Rothwell)
o	Update jffs2, remove abuse of kdev_t		(David Woodhouse)
o	Fix oops on unplugging bluetooth		(Greg Kroah-Hartmann)
o	Move stuff into bss on aironet4500		(Rasmus Andersen)
o	Fix up alpha oops output			(George France)
o	Update SysKonnect PCI id list			(Mirko Lindner)
o	Update SysKonnect GigE driver			(Mirko Lindner)
o	Add ATM DS3/OC12 definitions to atmdev.h	(Mitchell Blank)
o	Clean up atm drivers, fixed up user space	(Mitchell Blank,
	access with irqs off, kmalloc and use after	 John Levon)
	free.
o	Update input device/joystick/gameport drivers	(Vojtech Pavlik)
o	Update USB hid drivers				(Vojtech Pavlik)
o	Fix out of memory oops in hysdn			(Rasmus Andersen)
o	Belarussian should be Belarusian according to	(Nerijus Baliunas)
	the standards
o	Support booting off old 720K floppies		(Niels Jensen, 
							 Chris Noe)

2.4.5-ac3
o	Ignore console writes from an IRQ handler	(me)
o	Make SIGBUS/SIGILL visible to UML debugger	(Jeff Dike)
o	Clean up UML syscalls add missing items		(Jeff Dike)
o	Clean up non portable UML code			(Jeff Dike)
o	Fix off by one and other oddments in hostfs	(Henrik Nordstrom)
o	Update UML to use CONFIG_SMP not __SMP__	(Jeff Dike)
o	Fix UML crash if console is typed at too early	(Jeff Dike)
o	Clean up UML host transports			(Lennert Buytenhek,
							 Jim Leu)
o	Resynchronize UML/ppc				(Chris Emerson)
o	Fix UML crash if it had an address space hole	(Jeff Dike)
	between text and data
o	Fix rd_ioctl crash with initrd			(Go Taniguchi)
o	Fix IRQ ack path on Alpha rawhide		(Richard Henderson)
o	Drop back to older 8139too driver from 2.4.3
	| Seems the new one causes lockups
o 	Experimental promise fastrak raid driver	(Arjan van de Ven)

2.4.5-ac2
o	Restore lock_kernel on umount			(Al Viro)
	| Should cure Reiserfs crash in 2.4.5
o	Fix additional scsi_ioctl leak			(John Martin)
o	Clean up scsi_ioctl error handling		(me)
o	Configure.help typo fixes			(Nerijus Baliunas)
o	Fix hgafb problems with logos			(Ferenc Bakonyi)
o	Fix lock problems in the rio driver		(Rasmus Andersen)
o	Make new cmpci SMP safe				(Carlos E Gorges)
o	Fix missing restore flags in soundmodem		(Rasmus Andersen)
o	Set max sectors in ps2esdi			(Paul Gortmaker)
o	Fix interrupt restore problems in mixcom	(Rasmus Andersen)
o	Fix alpha compile on dp264/generic		(Andrea Arcangeli)
o	Fix irda irport locking restores		(Rasmus Andersen)
o	Fix failed kmalloc handling in hisax		(Kai Germaschewski)
o	Add missing memory barrier in qlogicisp		(?)
o	Fix missing restore_flags in eata_dma		(Rasmus Andersen)
o	Fix procfs locking in irttp			(Rasmus Andersen)
o	Winbond updates					(Manfred Spraul)
o	Stop network eating PF_MEMALLOC ram		(Manfred Spraul)
o	Drop fs/buffer.c low mem flush changes		(me)
o	Drop changes to mm/highmem.c			(me)
	| I don't think the Linus one is quite right but its easier
	| for everyone to be working off one base
o	Revert GFP_FAIL and some other alloc bits	(me)
o	Hopefully fix initrd problem			(me)
o	Fix kmalloc check in ide-tape			(Rasmus Andersen)
o	Fix irda irtty locking				(Rasmus Andersen)
o	Fix missing irq restore in qla1280		(Rasmus Andersen)
o	Fix proc/pid/mem cross exec behaviour		(Arjan van de Ven)
o	Fix direct user space derefs in eicon		(me)
	| From Stanford checker
o	Fix direct user space derefs in ipddp		(me)
	| From Stanford checker
o	Fix direct user space derefs in ixj		(me)
	| From Stanford checker
o	Fix direct user space derefs in decnet		(me)
	| From Stanford checker

2.4.5-ac1
o	Merge Linus 2.4.5 tree

Summary of changes for Linux 2.4.5-ac versus Linus 2.4.5

o	Fix memory leak in wanrouter
o	Fix memory leak in wanmain
o	Use non atomic memory for linearising NFS buffers as they are 
	done in task context
o	Fix dereference of freed memory in NetROM drivers
o	Fix writing to freed memory in ax25_ip
o	Support debugging of slab pools
o	NinjaSCSI pcmcia scsi driver
o	Raw HID device for USB peripheral buttons/controllers
o	Updated NTFS
o	RAMfs with resource limits
o	NMI watchdog available on uniprocessor x86
o	Update CMPCI drivers (not yet SMP safe)
o	Configurable max_map_count
o	Dynamic sysctl key registration
o	SE401 USB camera driver
o	Updated Zoran ZR3606x driver (replaces buz)
o	w9966 parallel port camera driver (partially merged with Linus)
o	Include headers in etags
o	Don't delete empty directories on make distclean
o	Fix halt/reboot handling on Alcor Alpha
o	IDE driver support for Etrax E100
o	IDE infrastructure support for IDE using non standard data transfers
o	Run ~/bin/installkernel if present
o	Support for out of order stores on x86 with this mode (IDT Winchip)
	- worth 20% performance on them
o	Configure level debugging menu
o	Make BUG() default to an oops only - saves 70K
o	Power management help for UP-APIC
o	Work around 440BX APIC hang (eg the ne2000 SMP hang)
o	Run time configurable APM behaviour (interrupts, psr etc)
o	Smarter DMI parser - handles multiple use of names
o	DMI layer has blacklist tables fixing Dell Inspiron 5000e crashes,
	PowerEdge reboot problems , and IBM laptop APM problems
o	PNPBios support
o	Fix atomicity of IRQ error count
o	Handle PCI/ISA boxes that don't list edge levels but have an ELCR
o	Don't erroneously mangle settings on all VIA bridges - cures the 
	horrible performance problem in 2.4.5 vanilla with VIA
o	Fix bootmem corruption on x86 boot
o	Scan and retrieve multipliers for processors (not yet used to handle
	the SMP cases where we need to disable tsc use)
o	Support machine check on Athlon and Pentium
o	Fix SUS violation with signal stacks
o	Handle boxes where firmware resets the timer to 18Hz (this should
	now not show false positives)
o	Better OOPS formatting on x86
o	Fix nasty problems with interrupts being disabled for long periods
	in frame buffer drivers
o	PAE mode alignment assumption fixes
o	32bit UID clean quota
o	Fix quota deadlocks
o	Fix TLB shootdown races
o	Experimental merge of usermode Linux
o	Fix memory leaks and othe rproblems with the iphase driver
o	IBM AS/400 iSeries virtual drivers
o	DAC960 null pointer checks
o	CCISS driver leak fixes
o	MPT fusion drivers for scsi and networking
o	Handle out of memory allocating request queue entries and avoid oops
o	Free the initial ramdisk correctly
o	Small CD-ROM layer updates
o	AGP power management hooks
o	First basic applicom driver fixes
o	Fix copy_from_user with interrupts off in cyclades driver
o	Fix out of memory handling in DRM
o	Clean up dsp56K driver
o	Update generic serial driver with break support
o	Clean up h8 driver namespace
o	Fix keymap changing problems in console drivers
o	Fix locking in machzwd
o	Updated rio serial driver
o	A2232 driver
o	Fix serial driver mangling of some clone uarts
o	Handle xircom serial port setup delay bug
o	Updated sx driver for newer generic_serial
o	W83877F watchdog driver
o	ITE8172 IDE driver support
o	Q40/Q60 IDE support
o	Fix nodma handling bug in alim15x3
o	hpt366 DMA blacklist
o	IDE-CD updates
o	Updated IDE DMA blacklist
o	OOPS catch for sg reuse in IDE driver
o	Support formatting of IDE floppies
o	Support PIIX4U4 (851EM)
o	Enable second port on promise pseudo raid
o	Support nodma on pmac
o	Support more PCI irq sharing on IDE
o	IDE tape updates - DI-50 support, 
o	Much updated VIA IDE support
o	video1394 updated to newer module API
o	Support write on the input event driver
o	Quieten mouse and keyboard input drivers
o	Fix compile problem with pc110pad
o	Fix memory leak in isdnppp
o	LVM updates
o	Fix plan b locking
o	Fix saa5249 locking
o	Fix stradis locking
o	Acenic driver updates
o	aironet4500 cleanups, probe tables
o	Ariadne updated to newer API
o	Don't limit mtu to 68+ in arlan drivers
o	Updated eepro100 driver
o	Fix potential crash on downing a bpqether port
o	Updated nsc-ircc driver
o	Updated toshoboe driver
o	Intel Panther LP486e ethernet driver
o	Remove erroneous check in eth_change_mtu
o	Alternative xircom_cb driver
o	Avoid ibm tr being rebuilt each make
o	Updated ibm token ring drivers
o	Add 'static' to bits of ppp code
o	Add pci probe table to roadrunner
o	Fix memory leak in sk_ge
o	sk_g16 updates
o	sk_mca updates
o	Add tools to generate starfire firmware
o	Synclink driver can be compiled in
o	Fix possible oops in lapbether
o	Fix memory leak in lanmedia driver
o	Fix SDLA_X25 warnings
o	Fix syncppp negotiation loop bug
o	GSC parallel port support
o	PCMCIA parallel port support
o	Support PnPBIOS probing for PC parallel ports
o	Fix leak in PCMCIA bulkmem driver
o	Fix leak in PCMCIA ds driver
o	Add more cards to the ti list for the yenta pcmcia
o	Updated 3ware scsi driver
o	NCR 53c700 and 53c700/66 driver core
o	Fix pci_enable/resource read order on buslogic
o	Updated NCR53c8xx driver
o	Updated SYM53c8xx driver
o	Fix NCR53c406 warnings
o	NCR dual MCA driver
o	AIC7xxx pci probe table for hotplug
o	Updated aic7xxx_old
o	Fix resource leaks in dec esp driver
o	Fix printk levels in dmx3191 driver
o	Allow per device max sector counts. (2.4 workaround until 2.5 does
	this in the block layer per device)
o	Support SCSI2/SCSI3 extended LUN numbering
o	Limit qlogicisp and qlogicpti to 64 sectors/write
o	Fix missing EFAULT return in scsi proc
o	Fix locking of scsi_unregister_host
o	Fix leaks in scsi_ioctl
o	Fix potential lost requests in scsi merges
o	Fix leak on write when scsi driver has no proc write op
o	Extend the scsi black/whitelist
o	Fix locking/eject/rescan on removable scsi disk media
o	Updated scsi generic driver
o	Updated scsi cdrom driver
o	Correct ac97 handling on sparc
o	Fix use after kfree in cs4281
o	Update ess solo to new PCI style and PM
o	Update maestro to new PCI style and PM
o	Add docking station support to maestro
o	Update sonicvies to new PCI api
o	Fix trident locking problems
o	Fix buzzing on ymfpci
o	Power management for ymfpci
o	Fix leak/missized copy on xjack driver
o	CDCEther driver
o	ACM driver with fixed CLOCAL
o	Updated USB audio drivers
o	Fix locking/reporting in USB device list
o	Allow dsbr100 to take a radio_nr option
o	HP5300 series USB scanner driver
o	Updated IBM cam driver
o	Fix USB inode locking
o	Driver for Kawasaki based USB ethernet
o	Small ov511 fixes
o	Updated USB storage drivers
o	Entries for Sony MSC-U01N memory stick, Fujifilm FinePix 1400Zoom,
	Casio QV Digial Camera
o	USB Ultracam driver
o	Fix derefence of freed memory in the USB code
o	Generic USB host->host drivers for anchorchip 2270, ipaq, netchip
	1080, and Prolific PL-2301/2
o	Updated ATI frame buffer drivers
o	Updated clgen and control frame buffer drivers
o	Updated cyber2000 driver
o	Documentation for fbcon driver
o	Additional modes for titanium powerbook (1152x768)
o	Updated matrxofb drivers
o	Support __setup in mdacon
o	Radeon console driver
o	Handle out of memory on sun3 fb
o	Updated tga/vesa fb
o	CMS file system (basic R/O)
o	JFFS journalling flash file system with compression
o	Updated AFFS file system
o	Threaded core dumps
o	Fix security holes in binfmt_misc
o	Allow flushing of low buffers only when we need bounce buffers
o	Use brelse in cramfs
o	Fix memory leaks in freevxfs
o	Updated isofs
o	Small lockd updates (experimental)
o	Fix nfs alignment funnies
o	Report correct SuS errors on some opens
o	Add generic_file_open to get 64bit stuff right
o	Locking on make_inode_number for procfs
o	Report shmem size in shared memory proc field
o	Fail lseek outside of allowed range for filesystem
o	Fix select race with fdset growth
o	Kernel message levels and handle oom on superblock/mount ops
o	Updated frame buffer logos
o	Prefetch support for AMD Athlon
o	Support out of order stores in spinlocks on x86
o	m68k bitop compile fixes
o	Add truncatepage op to address operations
o	shmem filesystem cleanups and updates
o	Fix off by one on real time pre-emption in scheduler
o	Use prefetches in scheduler and wakeups
o	Support GFP_FAIL to avoid highmem deadlocks
 
---
Alan Cox <alan@lxorguk.ukuu.org.uk>
Red Hat Kernel Hacker
& Linux 2.2 Maintainer                        Brainbench MVP for TCP/IP
http://www.linux.org.uk/diary                 http://www.brainbench.com
