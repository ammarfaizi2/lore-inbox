Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129319AbQLGUbe>; Thu, 7 Dec 2000 15:31:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129345AbQLGUbZ>; Thu, 7 Dec 2000 15:31:25 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:50700 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129319AbQLGUbK>; Thu, 7 Dec 2000 15:31:10 -0500
Subject: Linux 2.2.18pre25
To: linux-kernel@vger.kernel.org
Date: Thu, 7 Dec 2000 20:03:00 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Message-Id: <E1447Fx-0002vA-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok we believe the VM crash looping printing error messages is now fixed.
Marcelo finally figured it out and my 8Mb 486 has been running 2.2.18pre
with that fix and stably[1].

So I figure this is it for 2.2.18, subject to evidence to the contrary

Alan


2.2.18pre25
o	Fix tight loop spinning reporting out of free	(Marcelo Tosatti)
	pages
o	Back out ppa changes causing problems for a	(Tim Waugh)
	few users
o	Set master enable on UHCI USB controllers	(Erik Mouw)
o	RIO DCD fixes				(Patrick van de Lageweg)
o	3c59x.c support for 3c556B			(Andrew Morton)
o	S390 cleanups for loopsperjiffy etc		(Kurt Roeckx)
o	Fix acceleport 4 SMP hangs			(Al Borchers)
o	Fix drivers/char/Makefile buglet		(Chip Salzenberg)
o	PPC syscall table fix				(Chip Salzenberg)
o	Move HID sysctl to avoid clash in 2.4 case	(Tom Rini)
o	Small symbios check condition fix		(Gérard Roudier)
o	Fix Makefile module version check		(Eric Lammerts)
o	Fix DRM build on Sparc 				(Dave Miller)
o	Work around Dallas D4201 PCM8 audio bug		(Thomas Sailer)
o	Fix USB memory leak				(Dan Streetman)
o	Fix ioremap fencepost error			(Chip Salzenberg)


2.2.18pre24
o	Expose put_unused_fd for modules		(Andi Kleen)
o	Fix the ps/2 mouse probe I hope			(me)
o	Fix crash in cosa driver			(Jan Kasprzak)
o	Fix procfs negative seek offset error reporting (HJ Lu)
o	Fix ext2 file limit constraints			(Andrea Arcangeli)
o	Fix lockf corner cases				(Andi Kleen, me)
o	Fix NCPfs date limits				(Igor Zhbanov)
o	Update DRM					(Chip Salzenberg)
o	Fix missing Alpha includes			(Matt Wilson)
o	Fix missing symbols on alpha			(Matt Wilson)
 
2.2.18pre23
o	Fix alpha compile problem			(Herbert Xu)
o	Scan DMI bios data to find broken laptops	(me)
o	Fix megaraid module symbols			(Michael Marxmeier)
o	Fix visor/OHCI problem				(Gerg Kroah-Hartman)
o	Fix sysctl_jiffies compile bug			(Tomasz K³oczko)
o	Init mic input low to avoid feedback		(Pete Zaitcev)
o	Fix typo in acenic headers			(Val Henson)
o	David Woodhouse has moved			(David Woodhouse)
o	Compaq raid driver update			(Charles White)
o	Fix aha1542 scribbles on errors			(Phil Stracchino)
o	Update Advansys driver to v3.3D			(Bob Frey)
o	Fix maestro ioctl locking			(Zach Brown)
o	Formatting cleanup for setup.c			(Dave Jones)
o	Fix FAT32 bugs on Alpha				(Bill Nottingham)

2.2.18pre22
o	Fix HZ assumption in USB hub driver		(Oleg Drokin)
o	Fix ndisc range check on ipv6			(Dave Miller)
o	Clear other fields in qcam VIDIOCGWIN return	(Damion de Soto)
o	Fix sparc64 includes for socket.h		(Solar Designer)
o	ELF platform was misset for Pentium IV		(Mikael Pettersson)
o	ADMTek 985 ident was wrong			(Lee Bradshaw)
o	Fix filemark status test on scsi tape		(Robin Miller)
o	Fix file/block when spacing to tape beginning	(Kai Maiksara)
o	Small ISDN documentation fixes			(Kai Germaschewski)
o	Resync icn driver with core isdn tree		(Kai Germaschewski)
o	Fix isdn loopback driver			(Kai Germaschewski)
o	Fix small leaks in lockd			(Trond Myklebust)
o	Add Pentium IV rep nop, ident etc		(Various folks,
							 notably HPA and
							 Linda Wang)
o	Update sparc default config			(Dave Miller)
o	Hopefully properly fix the megaraid problem	(Willy Tarreau, AMI
							 and others)
o	Resync tcp bits with Dave			(Dave Miller)
o	Make cpqarray provide randomness		(Nigel Metheringham)
o	Fix wavefront symbols bug			(Carlos E. Gorges)
o	Fix acenic jumbo handling when flushing ring	(Val Henson)
o	Fix ace_set_mac_addr for littleendian hosts	(Stephen Hack)
o	Fix assorted typos in the kernel		(Andries Brouwer)
o	EEPro100 fixes					(Dragan Stancevic)
o	Fix hisax _setup crash case			(David Woodhouse)
o	Fix small cdrom driver bugs			(Jens Axboe)
o	Fix remaining vmalloc corner cases		(Ben LaHaise)
o	Update USB maintainers				(Greg Kroah-Hartman)
o	Fix matroxfb doc bug				(Pavel Rabel)
o	Fix setscheduler lock inversion 		(Andrew Morton)
o	Fix scsi unload/sg ioctl oops			(Paul Clements)

2.2.18pre21
o	Environment controller update for sparc		(Eric Brower)
o	No italian translation for config.help		(Andrea Ferraris)
o	Fix type error in buz driver			(Pete Zaitcev)
o	Resnchronize Apple PowerMac codebase		(Paul Mackerras & co)
o	Merge powermac tree fixes into usb
o	Powermac input device handling changes
o	Fix console switch fonts
o	S/390 merge					(IBM S/390 folks)
					(Merge grunt work done by Kurt Roeckx)
o	Make knfsd TCP an option 			(me)
o	Drop cisco info packets (0x2000)		(Ivan Passos)
o	Add belkin USB serial cable			(William Greathouse)

2.2.18pre20
o	Fix ide-probe SMP build error			(Ian Morgan)
o	Fix appletalk physical layer ioctl handling	(Andi Kleen)
o	Sparc update					(Dave Miller)
o	Update Stephen Tweedie's contact info		(Stephen Tweedie)
o	Fix typo in esp and scsi_obsolete code		(Dave Miller)
o	Bonding ioctl check fix				(Willy Tarreau)
o	Fix ipv6 procfs bug				(Al Viro)
o	Report PIV in proc as family 15 and uname as	(me)
	model 6 as discussed
o	Redo Intel cache decodes as code not tables	(me)
	and add new ones  (based on updates by
	Asit Mallick & Andrew Ip)
o	Fix CMOS locking in machine_power_off paths	(me)
o	Create build tree symlinks only if insmod is
	new enough not to be confused by it		(Keith Owens)
o	Fix cmsg handling				(Philippe Troin)
o	Tiny xpds driver changes			(Dan Hollis)
o	Fix vmalloc sign bug				(Ben LaHaise)
o	SMBFS fixes/changes for find_next problems and	(Urban Widmark)
	to avoid truncate bug in netapps
o	Fix ntfs translation bug			(Anton Altaparmakov)
o	Fix sparc problem with some soundcards and the	(Jeff Garzik)
	_IOC magic
o	Update ppa driver to v2.05			(Tim Waugh)


2.2.18pre19
o	Fix transproxy socket lookup			(Val Henson)
o	Add ICS1893 PHY to the SiS900 driver		(Lei-Chun Chang)
o	Fix documentation error in matroxfb		(Vsevolod Sipakov)
o	Update IDE floppy maintainer			(Paul Bristow)
o	Fix remaining cmos locking			(Paul Gortmaker)
o	Fix sparc bitfield/compiler bits on sound	(Dave Miller)
o	Update Pegasus USB driver			(Petko Manolov)
o	Networking updates - move divert header		(Andi Kleen)
o	Add ETH_P_ATM* defines				(Matti Aarnio)
o	Fix one more missing GFP_KERNEL/sk->allocation	(Dave Miller)
o	Fix ISDN multilink handler bug			(Kai Germaschewski)
o	Fix ymfpci unload cases				(Kai Germaschewski)

2.2.18pre18
o	Fix off by one in net/ipv4/proc			(Dave Miller)
o	Move the fpu emu patch that got away		(Dave Miller)
o	K6 update for MTRR ability			(Dave Jones)
o	Fix raid1/vm deadlock				(Marcelo Tosatti)
o	Fix usb mouse userspace memory accesses		(David Woodhouse)
o	Fix xpdsl if compiled in (typo)			(Arjan van de Ven)
o	Rio fixes for modem handling. Fix a small (Patrick van de Lageweg)
	generic serial bug
o	IBMtr driver fixes for cable pulls, pcmcia	(Burt Silverman,
	behaviour etc					 Mike Sullivan)
o	Tidy up /dev/microcode messages			(Daniel Roesen)
o	Add arpfilter					(Andi Kleen)
o	IDE floppy updates for clik support, cleanups	(Paul Bristow)
o	Fix irongate handling on Alpha			(Soohoon Lee)
o	Fix HZ=100 assumption in aha152x.c		(me)
o	Fix power management handling in i810 audio	(me)
	(From an ALSA fix by Godmar Back)
o	Put the NFS block default back to 4K		(Trond Myklebust)
o	Fix misleading comment in printk code		(Riley Williams)
o	Fix fbcon scroll back/paste bug			(Herbert Xu)
o	Fix rtc_lock for ide-probe, and hd.c		(Richard Johnson)
o	Backport of 2.4 PR_GET/SET_KEEPCAPS		(Brian Brunswick)
	(from Chris Evans 2.4 code)
o	LRU list corruption fix				(Andrea Arcangeli)
o	Initial gcc 2.96+ support for kernel building	(H J Lu)
	| Not a recommended compiler for production kernels...
o	ALI silence clearing fix			(Ching-Ling Lee)
o	Fix remaining old-style use of copy_strings	(Solar Designer)
o	Better pci_resource_start macro for 2.2		(Jeff Garzik)
o	Fix nbd deadlock				(Marcelo Tosatti)

2.2.18pre17
o	Move a few escaped m68k headers into the right	(me)
	directory
o	Backport 2.4 AF_UNIX garbage collect speedups	(Dave Miller)
o	TCP fixes for NFS 				(Saadia Khan)
o	Fix USB audio hangs				(David Woodhouse)
o	Sparc64 dcache and exec fixes			(Dave Miller)
o	Fix typing crap in divert.h			(Jeff Garzik)
o	Use pkt_type in diverter, add maintainer info	(Dave Miller)
o	Fix obscure NAT problem in FIB code		(Dave Miller)
o	Fix sk->allocation in TCP sendmsg		(Marcelo Tossati)
o	Elevator fixes					(Andrea Arcangeli)
o	Allow broken_suid on NFS root			(Trond Myklebust)
o	Fix net/ipv6/proc off by one bug		(Dave Miller)
o	Fix AGP oops on Alpha				(Michal Jaegermann)
o	MSR/CPUID init call fixes			(Arjan van de Ven)
o	CS4281 sound hang fixes				(Thomas Woller)
o	AX.25 comment updates, Joerg has moved email	(Joerg Reuter)

2.2.18pre16
o	Finally get the m68k tree merged		(Andrew McPherson
							 and a cast of many)
o	Bring the sparc back in line, make it build 	(Anton Blanchard)
o	USB Bluetooth fixes/docs			(Greg Kroah-Hartman)
o	Fix auth_null credentials bug			(Hai-Pao Fan)
o	Update cpu flag names 				(Dave Jones)
o	Console 'quiet' boot option as in 2.4		(Rusty Russell)
o	Make the sx serial driver work again	(Patrick van de Lageweg)
o	Fix negotation on the SYM53C1010		(Gerard Roudier)
o	Fix alpha loops per jiffy			(Jay Estabrook)
o	Fix pegasus to work with 2.2 kernels		(Greg Kroah-Hartman)
o	Update plusb driver for 2.2.x			(Eric Ayers, 
							 Deti Fliegl)
o	Fix ohci to use __init				(Greg Kroah-Hartman)
o	/sbin/hotplug support for USB as in 2.4		(Greg Kroah-Hartman)
o	Update ksymoops url				(Keith Owens)
o	Update the changes doc about gcc 		(Petri Kaukasoina)
o	Fix AMD flag naming				(Ulrich Windl)
o	Restore old block size on devices after a
	partition scan (needed for powermac for one)	(Michael Schmitz)
o	Fix GPL naming in SubmittingDrivers		(Mike Harris)
o	NFSv3 server patches merge			(Dave Higgen)
o	CS46xx changes					(Nils Faerber)
o	Fix sys_nanosleep for >4GHz CPU changes		(me)
	(Spotted by Ben Herrenschmidt)
o	Fix pas rev D mixer				(??)
o	Fix multiple spelling errors			(André Dahlqvist)
o	ISDN updates					(Kai Germaschewski)
o	XSpeed DSL driver				(Timothy Lee, 
							 Dan Hollis)
o	IDE multi-lun/single-lun handling		(Jens Axboe)
o	Fix alpha generic trident sound support		(Rich Payne)
o	Fix PPC for loops per jiffy			(Cort Dougan)

2.2.18pre15
o	Default msdos behaviour to old (small) letters	(me)
	| An option 'big' goes with 'small'
o	Fix define collision in cpqfc			(Arjan van de Ven)
o	Fix case where scripts/kwhich isnt executable	(me)
o	Alpha FPU divide fix				(Richard Henderson)
o	Add ADMtek985 to the tulip list			(J Katz)
o	Lose excess ymfpci debugging			(Rob Landley)
o	Fix i2c bus id clash				(Russell King)
o	Update the ARM vidc driver			(Russell King)
o	Update the ARM am79c961a driver			(Russell King)
o	Fix parport_pc build with no PCI		(Russell King)
o	Fix ARM memzero					(Russell King)
o	Update ARM for __init and __setup		(Russell King)
o	Update ARM to loops_per_jiffy			(Russell King)
o	Remove arm ecard debug messages			(Russell King)
o	Fix ARM makefiles				(Russell King)
o	Fix iph5526 driver to use mdelay		(Arjan van de Ven)
o	Fix epca, dtlk, aha152x loops_per_sec bits	(Philipp Rumpf)
o	Fix smp tlb invalidate and bogomip printing	(Philipp Rumpf)
o	Fix NLS warnings				(Arjan van de Ven)
o	Fix wavfront conversion to loops_per_jiffies	(me)
o	Fix an audio problem and a sanyo changer 	(Jens Axboe)
	problem
o	Fix include bug with divert			(me)
	| Alternate fix to Willy Tarreau's
o	Fix Alpha for loops_per_jiffy			(Willy Tarreau)

2.2.18pre14
o	Reorder attributes in drm to work with gcc272	(me)
o	GNU cross compilers are foo-bar-gcc 		(Russell King)
o	Add extra strange pcnet32 ident			(Willy Tarreau)
o	Since no vendor can get which right.. use a	(Miquel van Smoorenburg)
	shell script instead
	| Please nobody tell me this fails in some bash version!
o	Should be using bash not bash2 (escaped debug)	(Petri Kaukasoina)
o	spin_unlock_irq wrong debug mode printk		(Willy Tarreau)
o	Fix pcxx for the loops changes			(Arjan van de Ven)
o	Fix ov511/via-rhine name clash			(Arjan van de Ven)
o	Fix bridge compile with loops_per_sec change	(Mitch Adair)
o	8139too driver added				(Jeff Garzik)

2.2.18pre13
o	Change udelay to use loops_per tick		(Philipp Rumpf)
	| Otherwise we bomb out at 2GHz which isnt far enough
	| away with 1.4/1.6GHz stuff due out RSN
o	Fix drivers using big delays to use mdelay	(me)
o	Fix drivers that used loops_per_sec		(Philipp Rumpf, me)
o	Fix yamaha PCI sound SMP bug			(Arjan van de Ven)
o	Change to preferred USB init fix		(David Rees)
o	Fix rio fix					(Arjan van de Ven)
o	Catch the VT but no mouse case in init/main.c	(Arjan van de Ven)
o	Fix the 'which' compiler stuff			(Horst von Brand,
							 Peter Samuelson)
	| Can someone verify for me this works on Slackware and
	| on Caldera ?
o	Add devfs include. Devfs wont be going into 2.2 (Richard Gooch)
	but this again makes it easier to do 2.2/2.4
	drivers.

2.2.18pre12
o	Fix cyrix MTRR handling bug 			(IIZUKA Daisuke)
o	Fix ymfpci poll					(me, Arjan)
o	Update radio-maestro, add Configure.help	(Adam Tla/lka>
o	Fix rio/generic serial build bug		(Marcelo Tossati)
o	USB build bug fix				(Arjan van de Ven)
o	Fix missing ac97_codec.c return value		(Arjan van de Ven)
o	Fix several warnings				(Arjan van de Ven)
o	Made the PS/2 reconnect behaviour optional	(me)
	| Its now 'psaux-reconnect' on the boot line
o	Allow for newer Hauppauge with 4 ports		(Krischan Jodies)
o	Switch sound drivers from library to object	(Arjan van de Ven)
o	Kill the not working ac97 lock on the 810	(me)
o	Automatically select older compilers for kernel
	builds on Debian and RH				(Arjan van de Ven)
o	Start volumes higher on ac97, teach the driver  (Rui Sousa)
	about 5bit and 6bit codec precision and use
	the mute bit.

2.2.18pre11
o	Kill bogus codec_id assignment			(Linus Torvalds)
o	Update codec init code to handle id right	(me)
o	Fix dead/clashing define for NFS		(Trond Myklebust)
o	Remove the find_vga crap from bttv		(me)
o	Fix return on probe failure for cadet		(Arjan van de Ven)
o	Add missing configure.help stuff from 2.4test	(Alan Ford)
o	Fix inia100/megaraid define clash		(Arjan van de Ven)
o	__xchg marked as taking volatiles		(Arjan van de Ven)
o	Fix vwsnd warning in sound core			(Arjan van de Ven)
o	wdt_pci driver should return -EIO on error	(Arjan van de Ven)
o	Fix init_adfs_fs warning			(Arjan van de Ven)
o	Fix the joystick driver option parsing		(Arjan van de Ven)
o	Update mkdep to handle // commenting		(Mike Klar)
o	Thunderlan driver typo fixes			(Torben Mathiasen)
o	Add KX133/KT133 stuff to the AGP/DRM 		(Jeff Nguyen)
o	FIx multiple card bug in eepro driver		(Aristeu Filho)
o	Initial YMF PCI native driver			(Pete Zaitcev)
	| Based on Jaroslav's ALSA driver and I've tweaked it
	| a bit and maybe broken it 8)
o	Fix procfs unlink bugs				(Willy Tarreau)
o	X.25 bugfix backport				(Henner Eisen)
o	Fix incorrect free_dma on DMAless boxes		(Boria)
o	Fix via audio driver merge			(Nick Lamb)
o	Update plusb driver to 2.4 one			(Greg Kroah-Hartman)
o	Put description info in wacom driver		(Greg Kroah-Hartman)
o	Update both UHCI drivers to match 2.4test	(Greg Kroah-Hartman)
o	Masquerade cleanup/warning fixes		(Horst von Brand)

2.2.18pre10
o	Add printk level to partition printk messages	(me)
o	Fix bluesmoke address report/serialize		(Andrea Arcangeli)
o	Add 2.4pre CPUID/MSR docs to 2.2.18pre		(Adrian Bunk)
o	Update to the 2.4pre via audio driver		(Jeff Garzik)
o	Fix small SMP race in set_current_state		(Andrea Arcangeli)
o	Fix __KERNEL__ checks in sparc headers		(Dave Miller)
o	Fix ADFS root directory bug added in pre9	(Russell King)
o	Trap incorrect swap partition sizes		(Andries Brouwer)
o	Fix nfsroot bootp/dhcp on sparc64		(Dave Miller)
o	Tidy up tcp opt parsing				(Dave Miller)
o	Check range on port range sysctl		(Dave Miller)
o	Back out erroneous i2c.h change			(Arjan van de Ven)
o	Fix trident hangs due to over zealous addition	(Eric Brombaugh)
	of midi support
o	Fix big endian/macro bug in ext2fs		(Andi Kleen)
o	Bring dabusb driver into line with 2.4		(Greg Kroah-Hartman)
o	Bring event drivers into line with 2.4		(Franz Sirl,
							 Greg Kroah-Hartman)
o	Fix usb help texts				(Greg Kroah-Hartman)
o	Generic frame diverter				(Benoit Locher)
o	Bring USB serial back into line with 2.4	(Greg Kroah-Hartman)
o	Fix DVD driver rpc state bug			(Jens Axboe)
o	Fix extra sunrpc printk				(Tim Mann)
o	USB init tidy up				(Greg Kroah-Hartman)
o	Allow PlanB video on generic PPC		(Michel Lanners)
o	Doc fixes/trim cvs logs on isdn drivers		(Kai Germaschewski)
o	USB hid, hub, ibmcam, dsbr100 devices updates	(Greg Kroah-Hartman)
o	Return EAFNOSUPPORT for out of range families
o	Fix SMP locking on floppy driver		(Jonathan Corbet)
o	Add module author info to acm.c			(Greg Kroah-Hartman)
o	Update CREDITS to reflect all the USB guys	(Greg Kroah-Hartman)
 
o	ipfw wrong allocation flag fix			(Rusty Russell)
o	Implement Sun style lockf/nfs cache barriers	(Trond Myklebust)
o	Updated ISI serial driver			(Multitech)
	| You may well need their newer firmware set/loader for the
	| later cards too

2.2.18pre9
o	Fix usb module load oops			(Thomas Sailer)
o	Bring USB boot drivers in line with 2.4t8	(Greg Kroah-Hartman)
o	And USB print drivers				(Greg Kroah-Hartman)
o	And USB Rio driver				(Greg Kroah-Hartman)
o	And USB dc2xx driver				(Greg Kroah-Hartman)
o	And USB mdc800 driver				(Greg Kroah-Hartman)
o	NFSv3 support and NFS updates			(Trond Myklebust and co)
o	Compaq 64bit/66Mhz PCI Fibrechannel driver	(Amy Vanzant-Hodge)
o	Disable microtouch driver (doesnt work in 2.2	(Greg Kroah-Hartman)
	currently)
o	Update ADFS support				(Russell King)
o	Update ARM arch specific code and includes	(Russell King)
o	Update ARM specific drivers 			(Russell King)
o	Use both fast and slow A20 gating on boot	(Kira Brown)
	| if your box doesnt boot I want to know about it...
	| Needed for stuff like the AMD Elan

2.2.18pre8
o	Fix mtrr compile bug				(Peter Blomgren)
o	Alpha PCI boot up fix				(Michal Jaegermann)
o	Fix vt/keyboard dependancy in USB config	(Arjan van de Ven)
o	Fix sound hangs on cs4281			(Tom Woller)
o	Fix Alpha vmlinuz.lds				(Andrea Arcangeli)
o	Fix CDROMPLAYTRKIND bug, allow root to open	(Jens Axboe)
	the cd door whenver.
o	Update ov511 to match 2.4			(Greg Kroah-Hartman)
o	Further devio.c fix				(Greg Kroah-Hartman)
o	Update NR_TASKS comment				(Jarkko Kovala)
o	Further sparc64 ioctl translator fixes		(Andi Kleen)

2.2.18pre7
o	Fix the AGP compile in bug			(Arjan van de Ven)
o	Revert old incorrect syncppp state change	(Ivan Passos)
o	Fix i810 rng to actually get built in		(Arjan van de Ven)
o	Megaraid compile fix, joystick, mkiss fixes	(Arjan van de Ven)
o	Kawasaki USB ethernet depends on net		(Arjan van de Ven)
o	Compaq cpqarray update				(Charles White)
o	Fix usb problem with no USB unit found		(Oleg Drokin)
o	Driver for the radio on some maestro cards	(Adam Tlalka)
o	Additional shared map support needed for sparc64(Dave Miller)
o	Fix wdt_pci when compiled in			(me, Arjan van de Ven)
o	Fix usb missing symbol when non modular		(Arjan van de Ven)
o	Identify chip and also handle MTRR for the 	(me)
	Cyrix III
o	Allow binding to all ports multicast		(Andi Kleen)
o	Bring USB docs up to date			(Greg Kroah-Hartman)
o	Bring USB devio up to date			(Greg Kroah-Hartman)
o	pci_resource_len null function for non PCI case	(Arjan van de Ven)
o	Fix synchronous write off end of disk bug	(Jari Ruusu)

2.2.18pre6
o	Fix the IDE PCI not compiling bug		(Dag Wieers)
o	Kill an escaped reference to vger.rutgers	(Dave Miller)
o	Small rtl8139 fixups				(Jeff Garzik)
o	Add USB bluetooth driver			(Greg Kroah-Hartman)
o	Fix oops in visor driver			(Greg Kroah-Hartman)
o	Remove some unneeded ext2 includes,fix a bug	(Andreas Dilger)
	in the UFS code
o	Fix rtc race between timer and rtc irq		(Andrea Arcangeli)
o	Fix slow gettimeofday SMP race			(Andrea Arcangeli)
o	Check lost_ticks in settimeofday to be more	(Andrea Arcangeli)
	precise

2.2.18pre5
o	Added older VIA ide chipsets to the not to be	(me)
	autotuned list
o	Fix crash on boot problem with __setup stuff	(me)
o	Small acenic fix				(Matt Domsch)
o	Fix hfc_pci isdn driver				(Jens David)
o	Fix smbfs configuration problem			(Urban Widmark)
o	Emu10K wrapper/build fixes			(Rui Sousa)
o	Small cleanups					(Arjan van de Ven)
o	Fix sparc32 build bug				(Horst von Brand)
o	Fix quota oops					(Martin Diehl)
o	Add i810 random number driver			(Jeff Garzik)
o	Clear suid bits on ext2 truncate as per SuS	(Andi Kleen)
o	Fix illegal use of section attributes		(Arjan van de Ven)
o	Documentation for nmi watchdog			(Marcelo Tosatti)
o	Fix uninitialised variable warnings		(Arjan van de Ven)
o	Save DR6 condition into the TSS			(Ryan Wallach)
o	Add additional __init's to the kernel	(Andrzej M. Krzysztofowicz)
o	Backport 2.4 wdt_pci driver			(JP Nollman, me)
o	AGP i810 fixes					(Chip Salzenberg)
o	UDMA support for ALI1543 & 1543C IDE devices	(ALI)
o	2.4 MSR/CPUID driver backport			(Dave Jones, 
								H Peter Anvin)
o	Fix incorrect use of kernel v user ptr in NCPfs	(Petr Vandrovec)
o	Updated scsi tape driver			(Kai Makisara)

2.2.18pre4
o	Remove the aacraid driver again, having looked	(me)
	at what is needed to make it acceptable and 
	debug it - Im dumping it back on Adaptec
o	DAC960 update					(Leonard Zubkoff)
o	Add setup vmlinuz.lds changes for Sparc		(Arjan van den Ven)
o	Sparc updates for drm, ioctl and other		(Dave Miller)
o	Megaraid driver update				(Peter Jarrett)
o	Add cd volume 0 to the amp power off on the
	crystal cs46xx					(Bill Nottingham)
o	Fix IPV6 fragment and kfree bugs		(Alexey Kuznetsov)
o	Fix emu10k build bug				(me)
o	Emu10K driver upgrade. Adds emu-aps support	(Rui Sousa)
o	Updated IBM serveraid driver to 4.20		(IBM)
o	Ext2 block handling cleanup from 2.4		(Al Viro)
o	Make the ATI128 driver modular			(Marcelo Tosatti)
o	Fix megaraid build bug with gcc 2.7.2		(Arjan van de Ven)
o	Fix some of the dquot races			(Jan Kara)
o	x86 setup code cleanup				(Dave Jones)
o	Implement 2.4 compatible __setup and __initcall	(Arjan van de Ven)
o	Tidy up smp_call_function stuff			(Keitaro Yosimura)
o	Remove 2.4 compat glue from cs4281 driver	(Marcelo Tosatti)
o	Fix minor bugs in bluesmoke now someone actually
	has a faulty CPU and logs			(me)
o	Fix definition of IPV6_TLV_ROUTERALERT		(Dave Miller)
o	Fix in6_addr, ip_decrease_ttl, other		(Dave Miller)
	minor bits
o	cp932 fixes					(Kazuki Yasumatsu)
o	Updated gdth driver				(Andreas Koepf)
o	Acenic update					(Jes Sorensen)
o	Update USB serial drivers			(Greg Kroah-Hartman)
o	Move pci_resource_len into pci compat		(Marcelo Tosatti)

2.2.18pre3  (versus 2.2.17pre20)
o	Clean up most of the compatibility macros	(me)
	that various people use. I've systematically
	moved the 100% correct ones to the headers
	used in 2.4
o	Fix newly introduced bug in kmem_cache_shrink	(Daniel Roesen)
o	Further updates to symbios drivers		(Gerhard Roudier)
o	Remove emu10K warning and mtrr warning		(Daniel Roesen)
o	Fix symbol clash between cs4281 and esssolo1	(Arjan van de Ven)
o	Fix acenic non modular/module build issues	(Arjan van de Ven)
o	Fix bug in alpha csum_partial_copy that could	(Herbert Xu)
	cause spurious EFAULTs
o	Yet another eepro100 variant sighted		(Torben Mathiasen)
o	Minor microcode.c final tweak			(Daniel Roesen)
o	Document that ATIFB is now modular		(Marcelo Tosatti)
o	Parport update					(Tim Waugh)
o	First set of ext2 updates/fixes			(Al Viro)
o	Bring smbfs back into line with 2.2		(Urban Widmark)
	| This should make OS/2 work again
o	Fix S/390 _stext (still doesnt build dasd)	(Kurt Roeckx)
o	Remove unused vars in arch/i386/kernel/bios32.c	(Daniel Roesen)
o	Update the DHCP initrd support			(Chip Salzenberg)
o	Allow opening empty scsi removables like IDE
	with O_NONBLOCK (needed for some ioctls)	(Chip Salzenberg)
o	Back out vibra mixer change
o	Fix error returns in sbni driver		(Dawson Engler)
o	Initial merge of the aacraid driver		(Adaptec)
	| Much deuglification left to be done here
o	Report megaraid: on obscure megaraid error	(Daniel Deimert)
	strings
o	Add another CS4299 id string			(Mulder Tjeerd)

2.2.18pre2  (versus 2.2.17pre20)

o	Fix the compile problems with microcode.c	(Dave Jones, 
							 Daniel Roesen)
o	GDTH driver update 				(Achim Leubner)
o	Fix mathsemu miuse of casting with asm		(??)
o	Make msnd_pinnacle driver build on Alpha
o	Acenic 0.45 fixes				(Chip Salzenberg)
o	Compaq CISS driver (SA 5300)			(Charles White, 
	+ cleanups					 me)
	+ gcc 2.95 fixup
o	Modularise pm2fb and atyfb
o	Upgrade AMI Megaraid driver to 1.09		(AMI)
o	Add DEC HSG80 and COMPAQ 'logical volume' to
	scsi multilun list
o	SK PCI FDDI driver support			(Schneider & Koch)
o	Linux 2.2 USB backport				(Vojtech Pavlik)
	backport 3 + further fixes from the USB list
	+ mm/slab.c fix for cache destroy
o	AGP driver backport				(XFree86, Precision
	DRM driver backport				 Insight, XiG, HJ Lu, 
							 VA Linux, 
							 and others)

2.2.18pre1  (versus 2.2.17pre20)

o	Update symbios/ncr driver to 1.7.0/3.4.0	(Gerhard Roudier)
o	Updated ATP870U driver				(ACard)
o	Avoid running tq_scheduler stuff sometimes with	(Andrea Arcangeli)
	interrupts off
o	Futher cpu setup updates			(me)
o	IBM MCA scsi driver updates			(Michael Lang)
o	Fix incorrect out of memory handling in bttv	(Dawson Engler)
o	Fix incorrect out of memory handling in buz	(Dawson Engler)
o	Fix incorrect out of memory handling in qpmouse	(Dawson Engler)
o	Fix error handling memory leak in ipddp		(Dawson Engler)
o	Fix error handling memory leak in sdla		(Dawson Engler)
o	Fix error handling memory leak in softoss	(Dawson Engler)
o	Fix error handling memory leak in ixj 		(Dawson Engler)
o	Fix error handling memory leak in ax25		(Dawson Engler)
o	Merge the microcode driver from 2.4 into 2.2	(Tigran Aivazian)
o	Fix skbuff handling bug in the smc9194 driver	(Arnaldo Melo)
o	Make vfat use the same generation rules as	(H. Kawaguchi,
	in windows 9x					 Chip Salzenberg)
o	Fix oops in the CPQ array driver		(Arnaldo Melo)
o	Fix ac97 codec not setting the id field		(Bill Nottingham)
o	Further work on the cs46xx/CD power bits	(me)
o	Synclink updates 				(Paul Fulgham)
o	Synclink init bug fix				(Arnaldo Melo)
o	Handle odd interrupts from toshiba floppies	(Alain Knaff)
o	Fix trident driver build on nautilus Alpha	(Peter Petrakis)
o	Add later sb16 imix support tot he sb driver	(Massimo Dal Zotto)
o	Ignore luns that report can be connected, but	(Matt Domsch)
	not currently
o	Fix dereference after kfree in uart401.c	(Dawson Engler)
o	Return correct SuS error code for an unknown	(Herbert Xu)
	socket family
o	Add sub window clipping to the bttv driver	(Thomas Jacob)
o	Fix nfs cache locked messages			(Trond Myklebust)
o	Fix the modutils misdocumentation		(Martin Douda)
o	Remove bogus biosparm code from seagate.c	(Andries Brouwer)
o	Return correct error code on failed fasync set	(Chip Salzenberg)
o	Handle dcc resume with newer irc clients when	(Scottie Shore)
	doing an irq masq

--
Alan Cox <alan@lxorguk.ukuu.org.uk>
Red Hat Kernel Hacker
& Linux 2.2 Maintainer                        Brainbench MVP for TCP/IP
http://www.linux.org.uk/diary                 http://www.brainbench.com


[1] It does have the page aging patch too, but I want to merge that in 
2.2.19pre so we can study any suprises it causes.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
