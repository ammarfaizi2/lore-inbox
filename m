Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276377AbRI1XjN>; Fri, 28 Sep 2001 19:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276378AbRI1XjF>; Fri, 28 Sep 2001 19:39:05 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:38924 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276377AbRI1Xiz>; Fri, 28 Sep 2001 19:38:55 -0400
Date: Sat, 29 Sep 2001 00:44:12 +0100
From: Alan Cox <laughing@shared-source.org>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.9-ac17
Message-ID: <20010929004412.A1335@lightning.swansea.linux.org.uk>
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

*	Next batch of bugfixes and updates
*	I want to get these in before I import the Linus changes
	beyond 2.4.10pre9 which is where the merge currently sits

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

2.4.8-ac12
o	Merge the majority of 2.4.9 except
	- min/max mess
	- fat/isofs changes
	- drm changes (some collisions with other
			fixes)
	- vm/buffer handling changes
	- emu10k1
	- vfs directory type changes
	- nfs/nfsd/sunrpc
	I'm trying to make sure I can keep this testable
	as 2.4.9 vanilla isnt being stable on my test sets 
	This is basically a merge of all the "boring" bits.

o	Update usb network fixes			(Herbert Xu)
o	HID id matching fix				(Pete Zaitcev)
o	ARM i/o fixes					(Russell King)
o	ARM alignment trap fixes			(Russell King)
o	ARM softirq fix					(Russell King)
o	Miscellaneous arm updates			(Russell King)
o	Configure.help updates			(Andrzej Krzysztofowicz,
							 Steven Cole)
o	Prefetchw macro fix				(Andreas Franck)
o	Kill another bogus wbinvd macro in ACPI		(Dave Jones)
o	Switch PnPBIOS to spinlocks and irq off		(me)
o	Large PPC merge					(Paul Mackerras)
o	Remove surplus macintosh rtc printks		(Paul Mackerras)
o	Add modem power features to the mac serial 	(Paul Mackerras)
o	Powerbook trackpad lockup fix			(Paul Mackerras)
o	Adb updates					(Paul Mackerras)
o	Fix serial port base offsets			(Paul Mackerras)
o	PPC sysctl code to use PPC32 not __powerpc__	(Paul Mackerras)
	| The latter is both 32 and 64 bit...
o	PowerMac pmu updates				(Paul Mackerras)
o	S/390 3270 driver update			(Richard Hitt)
o	MIPS docs update				(Ralf Baechle)
o	Update mips maintainers entry			(Ralf Baechle)
o	Update mips configure.help			(Ralf Baechle)
o	Add some mips pci ids				(Ralf Baechle)
o	DECstation turbochannel update			(Maciej W. Rozycki,
							 Ralf Baechle)
o	MIPS64 update					(Ralf Baechle)

2.4.8-ac11
o	Remove bogus wbinvd macro in ACPI		(Dave Jones)
o	Fix highmem high page races			(Ben LaHaise)
o	SCSI generic driver updates			(Doug Gilbert)
o	Remove unneeded fusion init call		(Adam J Richter)
o	Fix init/const clashes in pci			(Dave Jones)
o	Merge newer qlogic fc firmware set		(Ricky Beam)
o	Add NEC DV5800A to the blacklist for DMA	(Matt Domsch)
o	Add passive ISDN over USB support		(Frode Isaksen,
							 Kai Germaschewski)
o	Fix aha1542 flags type				(Andi Kleen)
o	Macsonic kmalloc type fixes			(Dave Jones)
o	lock clear_page_tables versus kswapd		(Ben LaHaise)
o	Honour PnPBIOS region reservations		(Gerd Knorr)
o	Made them __init and fixed problems when the	(me)
	resource declaration spanned 0x100
o	Fix a rio serial type warning			(me)
o	Add another byteswapped Vaio BIOS		(Roger Luethi)
o	USB serial tidy ups				(Greg Kroah-Hartmann)
o	Fix dev->actconfig changing in probe in USB	(Michael Stickel)
	causing later errors

2.4.8-ac10
o	Fix the USB device timeout problem		(Pete Zaitcev)
o	rio usb locking fixes				(Oliver Neukum)
o	Fix vm86 v segment reload part 1		(Andi Kleen)
	| Still not all sorted yet
o	Airo driver update				(Javier Achirica)
o	Fix bugs in usb skeleton driver			(Greg Kroah-Hartmann)
o	Add support for USB clie serial devices		(Greg Kroah-Hartmann)
o	USB config fix for serial debug			(Greg Kroah-Hartmann)
o	Add support for massworks id75 usb		(Greg Kroah-Hartmann)
o	Rationalise lvm version numbers			(A J Lewis)
o	LVM locking changes				(Joe Thornber)
o	Pull pv flush out of lvm ioctls			(Heinz Mauelshagen)
o	Switch to lv_v5_t structures/types in LVM		(Heinz Mauelshagen)
o	Defer LVM I/O when moving an extent		(Joe Thornber,
							 Andreas Dilger)
o	Fix bmap/blkszget issues in LVM			(Andreas Dilger)
o	Tidy naming/devfs registrations for LVM		(Patrick Caulfield)
o	Protect LVM snapshot flag removal, don't
	extend or reduce dropped snapshots, 
o	Handle ELF loader setup arg pages failures	(Evgeny Polyakov)
o	Add udelays to cmpci to see if it fixes		(me)
	the problems a few people have
o	Put config hooks in to make qlogicfc firmware	(me)
	optionally loadable for weird hardware
	| Needs a suitable firmware file adding ..
o	Update pci.ids for a couple of parisc things	(Helge Deller)
o	Irda warning fixes				(Pete Zaitcev)
o	Squash smp race in dsbr100 driver		(Oliver Neukum)
o	Console locking fix on VT_DISALLOCATE race	(Jani Jaakkola,
							 Andrew Morton)
o	ipv4 raw socket oops fix			(Octavian Cerna)
o	Actually use our msr register defines 		(Dave Jones)
o	Correct polish translation info typos		(Steven Cole)
o	mm compile warning fix				(Rik van Riel)
o	Updated 3ware driver				(Adam Radford)
o	Add Sharp PC-RJ/AX to bad apm list		(Arjan van de Ven)

2.4.8-ac9
o	Possible usb -110 error fix			(me)
o	Page laundering fix				(Rik van Riel)
o	Add another vaio to the byteswap list		(Martin Mueller)
o	Fix typos in ide blacklist			(Arjan van de Ven)
o	UMSDOS split directory entry handling		(Istvan Varadi)
o	Update Configure.help further			(Steve Cole)
o	Fix bogus mtrr warning on dual pentiums		(Dave Jones)
o	Update scsi tape driver				(Kai Mäkisara)
o	Change memory probe constants on AWE32/64	(Dave Fennell)
o	Tiny endian reiserfs fix (just cosmetic)	(Jeff Mahoney)
o	Make the md resync delay message informative	(Corin Hartland-Swann)
	rather than scary
o	USB printer fixes				(Oliver Neukum)
o	Add the SIS735 to the SiS AGP			(Adrian)
o	Kill bogus export_objs entry in lib/Makefile	(Keith Owens)
o	VIA rhine fixes					(David Woodhouse)
o	Next set of superblock changes			(Al Viro)
o	Don't reissue a pid that has a tgid matching	(Dave McCracken)
	it still in circulation

2.4.8-ac8
o	Fix double mount hang on scsi cdrom, i2o or lvm	(Al Viro)
o	Fix oops in msdos/umsdos			(OGAWA Hirofumi)
o	Fix qnxfs hang					(Serguei Tzukanov)
o	Add missing Alpha ksyms				(Marc Zyngier)
o	USB oops fixes					(Pete Zaitcev)
o	Apply same fix to kaweth			(me)
o	Fix off by one in pcigart			(Andreas Schwab)
o	Fix dasd leak					(Al Viro)
o	page reactivate correction			(Rik van Riel)
o	Add the 104K to the byteswapped minutes bug	(Daniel Caujolle-Bert)
	list
o	Missing USB config items			(Mike Castle)
o	Fix i2o systab send id order			(Klaus Beyer)
o	VMA merging fixups				(Ben LaHaise)
o	Update ntfs 					(Anton Altaparmakov)
o	Speed up ext2 readdir/stat			(Ted Tso)
o	Comment/docbook fixups				(Dave Jones)
o	Add missing netif_wake_queue calls to USB	(Herbert Xu)
	network drivers
o	Fix cramfs to use kmap				(Herbert Xu)
o	Fix NFS client atomic_dec_and_lock symbol	(Trond Myklebust)
o	Make wake_up_interrutible_sync usable in 	(Jeremy Elson)
	modules
o	Update PPC for kbd_rate support			(Paul Mackerras)
o	Next block of Configure.help tidying	(Andrzej Krzysztofowicz)
o	Next block of superblock cleanup		(Al Viro)
o	Update hp scanner driver for USB		(Oliver Neukum)
o	Clean up ibm partition code			(Al Viro)

2.4.8-ac7
o	Further small DRI/AGP updates			(Jeff Hartmann)
o	Update master makefile to force offset.h/	(Andi Kleen)
	version.h/depend order (needed for x86-64)
o	Merge x86-64 architecture port code		(Andi Kleen and co)
o	Merge ixj update				(Craig Southern)
o	Further ixj cleanup/merge tweaks		(me)
	| Ie don't blame him ;)
o	Grand config file cleanup		     (Andrzej Krzysztofowicz,
							Steven Cole)
o	Add another byteswap vaio			(Ray Lee)
o	Correct partition check oops fix		(Kevin Flemming)
o	via82cxx IDE DMA updates		 	(Vojtech Pavlik)
	| Enable 8231/8233 support, handle slightly
	| out of spec PCI from 1.3GHz/12.5x Athlon
o	Rip min/max use entirely out of isdn		(Kai Germaschewski)
	| To handle 2.4.9 compat disaster
o	Update K6 bug url				(André Dahlqvist)
o	Possible fix for trix ad1848 fail		(me)
o	Add pci quirk warning for AMD766 errata 22	(me)
	| Based on multiple "yes noapic fixed my
	| dual athlon" reports.

2.4.8-ac6
o	Pull Linus buffer.c/mem fixes into 2.4.8-ac	(Rik van Riel)
o	Make writeout smoother on zone specific		(Marcelo Tosatti)
	shortages
o	Fix an md oops					(Neil Brown)
o	AD1848 isapnp handling				(Miguel Freitas)
o	sr_ioctl capacity reporting fix			(Jens Axboe)
o	Starfire update					(Ion Badulescu)
o	cmpci update					(Carlos Gorges)
o	UDF update, fix delete BUG() trap		(Ben Fennema)
o	Move nmi defines so asm/irq.h isnt required	(Russell King)
o	Add experimental requirement to intermezzo   (Andrzej Krzysztofowicz)
o	Fix missing include 				(Tom Rini)
o	Small eepro100 test updates			(Arjan van de Ven)
o	Reiserfs transaction tracking update		(Chris Mason)
	| Speeds up O_SYNC and fsync
o	Update vfs_permission, handle root exec		(Christoph Hellwig)
	weirdness
o	First piece of the CyberPro 5050 audio merge	(Peter Wächtler)
o	Tidy i810_audio cornercases of OSS compliance	(Laurent Pinchart)
o	IDE cdrom blacklist updates for DMA		(Matt Domsch)
o	Merge some i810 updates 			(Doug Ledford)
o	Fix bug in i810 device removal 			(me)
	| fortunately nobody yet has multiple ICH audio in one box 8)
o	Natsemi gige driver				(Ben LaHaise)
o	Allow more I/O addresses on msnd_pinnacle	(Steve Sycamore)
o	Correct sys_tz definition			(Andi Kleen)
o	Remove unused prototypes from md		(Andi Kleen)
o	Fix flags wrong types in usb			(Andi Kleen)
o	Fix assorted wrong flags, add x86_64 defines	(Andi Kleen)
o	Fix flags types in i2o				(Jes Sorensen)
o	Add another vaio byteswap case			(Stelian Pop)
o	Add devfs support to usb scanner		(Yves Duret)
o	Fix an ess solo warning				(Christoph Hellwig)
o	Fix flags types in 3ware driver			(Jes Sorensen)
o	Fix generic serial warnings			(Christoph Hellwig)
o	Fix flag types in firewire drivers		(Jes Sorensen)
o	Fix flag types in dz serial			(Jes Sorensen)
o	Extend short name handling in fat based fs's	(OGAWA Hirofumi)
o	Fix flag types in n_r3964			(Jes Sorensen)
o	x86_64 ifdef hooks for raid and fbcon		(Andi Kleen)

2.4.8-ac5
o	Next batch of IDE driver updates		(Andre Hedrick)
	| qd6580 driver becomes a qd65xx driver
	| 80pin cable detect for serverworks on Dell
	| Mode5 on SIS chipsets
o	Handle ARM mmap were FIRST_USER_PGD_NR is not	(Russell King)
	zero
o	Make the sl82c105.c code common between ARM	(Paul Mackerras)
	and PPC
o	Update cisco hdlc handling in the isdn layer	(Bjoern Zeeb)
o	Add called party number to isdn tty emulation	(Jan Oberlaender,
							 Kai Germaschewski)
o	Eicon warning fix				(Kai Germaschewski)
o	Tiny agp cleanup in severworks code		(Mike Harris)
o	Switch to 2.4.8 nr_free_buffer_pages		(Rik van Riel)
o	Change bootmem bitmap setup			(Rik van Riel)
o	Unlazy the queue movement when we touch
	inactive cache pages (VM balance assumed this)	(Rik van Riel)
o	Update the orinoco drivers			(David Gibson)
o	Update natsemi driver (experimentally anyway)	(Tim Hockin)
o	Update hpt366 blacklists			(Kevin Fleming)
o	Reclaim buffer cache into inactive list when	(Rik van Riel)
	it is too large
o	Documentation tidy ups				(Steven Cole)
o	Switch map_user_kiobuf to use down_read		(Ben LaHaise)

2.4.8-ac4
o	ADFS date/time computation fix			(Russell King)
o	Add ALS120 ident to ns558 joystick		(Filip Van Raemdonck)
o	Make Reiserfs endian and alignment safe		(Jeff Mahoney)
	| Fixes IA64 indirect alignment, S390 alignment
	| Big endian
	| Update inode generator
o	Enable input drivers on ARM			(Russell K
o	Add intermezzo file system kernel side		(Peter Braam and co)
o	First blocks of ppc64 merge	(Paul Mackerras, Anton Blanchard,
					 Tom Gall and the IBM PPC 64 team)
o	Fix return value bug in mac nvram driver	
o	Make oom killer kill all threads of a set	(Eric Lammerts)


2.4.8-ac3
o	Update ISDN cvs idents				(Kai Germaschewski)
o	Update isdn experimental idents			(Kai Germaschewski)
o	Add Compaq Phoenix 4.06 to irqsafe APM		(Arjan van de Ven)
o	Remove rockridge printk generating too much	(Mikael Pettersson)
	debug output
o	Add a needed include of delay.h			(Arjan van de Ven)
o	Revert access DAC change 			(me)
	| Breaks in some cases
o	ARM documentation, credits, maintainer updates	(Russell King)
o	Atyfb build fixups				(Stelian Pop)
o	Configure.help merges				(Steven Cole)
o	Initial merge of dpt_i2o.c		(Deanna Bonds, Bob Pasteur, 
						 Karen White, Mark Salyzyn)
o	Teach i2o_core to skip dpt cards		(me)
o	Sony Pi driver update				(Stelian Pop)

2.4.8-ac2
o	Fix suspend/resume bugs in eepro100		(Arjan van de Ven)
o	Fix missing spec required delays in PCI PM	(me)
o	Disable PM on eepro100, it breaks even with	(me)
	those fixed
o	Resynchronize Configure.help			(Steven Cole)
o	Further superblock handling updates		(Al Viro)
o	Fix various GPL misreferences		(Andrzej Krzysztofowicz)
o	Updated A20 gate switching code to handle	(Peter Anvin)
	odd (Olivetti etc) and no legacy boxes
o	Fix expand_stack race				(Manfred Spraul)
o	Fix a malloc failure path in ipc		(Manfred Spraul)
o	Revert 2.4.8 scsi_lib change (hangs ide-scsi	(Arjan van de Ven)
	on some drives)
o	Fix binfmt elf strlen->strnlen_user		(me)
o	Add additional checking to binfmt_elf		(me)
	| Last two based on Solar Designers 2.2 work
o	Make pnp_bios dock thread exit when it finds 	(me)
	docking isnt supported
o	Ext3 file system updates			(Andrew Morton,
							 Stephen Tweedie)
o	Merge common components of uhci drivers		(Brad Hards)
o	Remove crud from media Makefile			(Keith Owens)
o	Fix build on Alpha				(David Gilbert)
o	DRM warning/oops fix				(Arjan van de Ven)
o	Fix i810 audio return funny			(Laurent Pinchart)
o	Fix ldm partition checking			(Richard Russon)
o	Agpgart typo fix				(Mike Harris)
o	Revert emu10k changes in 2.4.8, wait until the	(me)
	maintainers actually have debugged code and
	want an update
o	Fix a compile fail case for the 53c700 driver (Andrzej Krzysztofowicz)
o	ARM core and video updates			(Russell King)

2.4.8-ac1
o	Merge Linus 2.4.8
	- Skip VM changes for now
o	Fix sblive build problems			(Rui Sousa)
o	Add Fernando Fuganti to credits			(Fernando Fuganti)
O	Revert printk return change			(Andrew Morton)
o	Add drm-4.0 to mod_subdirs			(Brian Dushaw)
o	Bluez bluetooth updates				(Maksim Krasnyanskiy)
o	Fix serverworks AGP memory leak			(Hugh Dickins)
o	Update DRM 4.1 for Alpha AGPGart support	(Jay Estabrook,
							 Jeff Hartmann)
o	Fix depca crash on unload			(Peter Denison)

 
---
Alan Cox <alan@lxorguk.ukuu.org.uk>
Red Hat Kernel Hacker
& Linux 2.2 Maintainer                        Brainbench MVP for TCP/IP
http://www.linux.org.uk/diary                 http://www.brainbench.com
