Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263908AbTCVUj5>; Sat, 22 Mar 2003 15:39:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263912AbTCVUj5>; Sat, 22 Mar 2003 15:39:57 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:64475 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S263908AbTCVUjq>; Sat, 22 Mar 2003 15:39:46 -0500
From: Alan Cox <alan@redhat.com>
Message-Id: <200303222050.h2MKopw28918@devserv.devel.redhat.com>
Subject: Linux 2.5.65-ac3
To: linux-kernel@vger.kernel.org
Date: Sat, 22 Mar 2003 15:50:51 -0500 (EST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux 2.5.65-ac3
o	Revert some dead fb stuff I missed		(me)
o	Fix eisa printk for 0 devices			(me)
o	Resync with Linus bk3
	- Drop broken tty changes in Linus tree
o	Implement tty changes properly			(me)
o	Fix up garbage 3ware changes in Linus tree	(me)
o	Make dvb compile again				(John Kim)
o	PCI updates					(Russell King)
o	IDE typo fixes					(Steven Cole)
o	PCMCIA updates					(Dominik Brodowski)
o	Fix 3c527 build					(Adrian Bunk)
o	Fix up another ASUS SMbus			(Dominik Brodowski)
o	Fix airo stack usage				(Randy Dunlap)
o	Update pc9800 ide driver			(Osamu Tomita)
o	Fix quota direct reference to user space	(Chris Wright)
o	Fix missing verification checks on cosa		(Chris Wright)
o	Menuconfig choice help improvements		(Mitch Adair)
o	Fix i2o_config use of user data wrongly		(Chris Wright)
o	Use RPMBUILD not RPM				(Christoph Hellwig)
o	Fix op3sa2 compile				(Daniel Ritz)
o	Fix ISD200 mishandling of cmd_len		(Jan Harkes)
o	Syscalls return long stuff			(Randy Dunlap)
o	Further cleanups for syscall returns long	(Robert Love)
o	Reduce arch-sh stack usage for pcibios		(Randy Dunlap)

Linux 2.5.65-ac2
o	Revert an escaped fb change			(me)
o	Fix floppy unload crash				(Angus Sawyer)
o	ASUS SMbus quirk				(Dominik Brodowski)
o	Typo fix					(Greg Ingram)
o	Handle broken PnPBIOS systems			(me)
o	Fix es968 build					(John Kim)
o	AFFS changes					(Geert Uytterhoeven)
o	Console_init fixes				(Geert Uytterhoeven)
o	M68K time updates				(Geert Uytterhoeven)
o	Sun3 NCR5380 clean ups				(Geert Uytterhoeven)
o	WD33C93 merge fixup				(Geert Uytterhoeven)
o	M68K NCR5380 driver updates			(Geert Uytterhoeven)
o	WD33C93 missing export fix			(Geert Uytterhoeven)
o	M68K rtc updates				(Geert Uytterhoeven)
o	IDE_ACK_INTR clean up				(Geert Uytterhoeven)
o	Amiga serial updates				(Geert Uytterhoeven)
o	M68K SCSI updates				(Geert Uytterhoeven)
o	CS5520 needs module counts adjusting		(Alexander Atanasov)
o	Clean up ide restart historic junk		(Alexander Atanasov)
o	Fix sch_atm build				(Matthew Wilcox)
o	Fix md oops with linear mode and large disk	(Daniel McNeil)
	support
o	Ensure ide 50ms delay is always at least 50ms	(Alexander Atanasov)
o	Exterminate remaining ifdefs/code from old	(Alexander Atanasov)
	style probe code
o	Remove unused ide debug macro			(Alexander Atanasov)
o	Fix max_sectors handling per hwif		(Alexander Atanasov)
o	Switch default to 256 sectors			(me)
	| Should probably move to 1024 for LBA48
o	Add ne2k-cbus driver for PC9800 CBUS ne2000	(Osamu Tomita)
o	Fix SMP compile failure				(me)
o	Fix crash on boot with s390x booting 32bit	(Pete Zaitcev)
	init
o	Merge current 2.4.x PIIX into 2.5.x		(me)
	| Adds Intel ICH5 support
o	Add centrino IDE support			(Dean Gaudet)
o	Fix ioperm setup on first ioperm call		(Brian Gerst)
o	Correct spelling errors in -ac changes		(Steven Cole)
o	I2O requires PCI				(Joern Engel)
o	More typo fixes					(Randy Dunlap)
o	Fix missing module_license on ipfwadm_core	(Geoffrey Lee)

Linux 2.5.65-ac1
	Resync with Linux
	Drop the stale -ac video changes
o	Fix pppoatm build				(John Levon)
o	Rework IDE setup to clean up IRQ allocation	(Manfred Spraul)
	problem and fix a race
o	AFFS crash fix					(Andries Brouwer)
o	Save 90K or CONFIG_NET=n			(Matthew Wilcox)
o	Make device ident string a bit longer		(Ben Collins)
	|Space for EUI + unit on ieee1394
o	sysfs.txt typo fixes				(Geert Uytterhoeven)

Linux 2.5.64-ac4
o	Fix compile error in ide-default		(Maciej Soltysiak)
o	Fix ide-default panic case			(Osamu Tomita)
o	Remove seperation of PCI bus from I2O layer	(me)
o	Fix i2o_proc stack abuse			(Joern Engel)
o	Fix memory leak in ixj driver			(Oleg Drokin)
o	Fix memory leak in emu10k1			(Oleg Drokin)
o	Fix memory leak in cpqfc			(Oleg Drokin)
o	Fix memory leak in specialix serial		(Oleg Drokin)
o	Fix memory leak in kobil driver			(Oleg Drokin)
o	Fix memory leak in clone_thread			(Andi Kleen)
o	Fix pbus_size_mem mis-estimation		(Ivan Kokshaysky)
o	Fix ide-cd queue cleanup			(Alexander Atanasov)
o	Fix cmd640 deadlocks				(Alexander Atanasov)
o	Documentation updates				(Steven Cole)
o	Fix docbook reference to file now gone		(Rusty Lynch)
o	Mass extermination of __NO_VERSION__		(Adrian Bunk)
o	Fix incorrect intel PCI ident in 2.5		(me)
	|Noted by Adrian Bunk
o	Fix jiffies sign problems in aha152x		(Christoph Hellwig)
o	Fix jiffies sign problems in osst		(Christoph Hellwig)
o	v850 updates for NB85CE				(Miles Bader)
o	Fix 8012q memory leak				(Oleg Drokin)
o	Fix ircomm memory leak				(Oleg Drokin)
o	NCPfs mishandling of userspace access fix	(Oleg Drokin)
o	UFS memory leak fix				(Oleg Drokin)
o	Fix do_clock_nanosleep and other resulting	(Todd Mokros)
	timeout hangs
o	Bring oprofile back into line with 2.4		(John Levon)
o	i386 Kconfig typo fixes				(Andreas Mohr)
o	Remove some boot98 Makefile junk		(Osamu Tomita)
o	Update 98kbd driver				(Osamu Tomita)
o	Pull cmos clock handling into mach_ and add	(Osamu Tomita)
	PC9800 support
o	Add PC9800 serial support			(Osamu Tomita)
o	Move base PC resources into mach_ and add	(Osamu Tomita)
	PC9800 support
o	Extract some of the arch specific SMP bits	(Osamu Tomita)
	into mach_ for x86 and add PC9800
o	Fix pcmcia configuration register crash		(Pavel Roskin)
o	Extended attribute handling fix			(Tony Dziedzic)
o	Fix initialisation of i2o retry lock		(Randy Dunlap)
o	Pull timers into mach_ on x86 and add		(Osamu Tomita)
	PC9800 support
o	Add part of the PC9800 ide/hd support		(Osamu Tomita)
o	Update PC9800 core code				(Osamu Tomita)
o	Update PC9800 specific char drivers		(Osamu Tomita)
o	Fix -ac visws mach breakage			(Osamu Tomita)
o	Revert alpha inline change			(Ivan Kokshaysky)
o	Serial8250 warning fix				(Martin Bligh)
o	Fix ethtool lockup with unused interface on	(Jason Lunz)
	e100
o	Update random number generator drivers		(Jeff Garzik)

Linux 2.5.64-ac3
o	Bring core IDE code into sync with the latest	(me)
	2.4.21pre5-ac code base. The drivers are not
	quite current with it yet.

Linux 2.5.64-ac2
o	Fix missing ; in w9966 (#310)			(Frank Davies)
o	Fix missing ; in whiteheat (#314)		(Frank Davies)
o	Fix missing ; in cs46xx (#317)			(Frank Davies)
o	Fix double logical operator in ite_gpio (#321)	(Frank Davies)
o	Fix double logical opeator in advansys (#324)	(me)
o	Fix aha1542 setup to allow full config by	(Hanna Linder)
	setup options (#242)
o	Fix /proc bug in via ide handlers (#374)	(Faik Uygur)
o	Add #error for the mwave race (#185)		(me)
	| Fixing it needs rather more thought
o	Fix apic compile problem			(Adriank Bunk)
o	Fix mremap slab corruption			(Hugh Dickins)
o	Fix sysfs mount permissions			(Patrick Mochel)
o	v850 updates					(Miles Bader)
o	Update all the parport layer to new module	(Bob Miller)
	API's remove check region misuse etc
o	Updated gdth driver from Intel			(Achim Leubner)
o	Small ALi ide setup fixes			(Ivan Kokshaysky)
	| Basically mirror those applied to 2.4 before the 1563
	| support was added
o	Add kerneldoc for user space access		(Jon Foster)
o	Fix incorrect unregister for cciss		(Herbert Xu)
o	cciss hotplug crash fix				(Stephen Cameron)
o	Fix error in 3c501 comments			(Steven Cole)
o	More c99 intialisers 				(Art Haas)
o	Updated mwave driver (still broken in part)	(Paul Schroeder,
							 Wes Schreiner)
o	Fdomain scsi cleanups, fix host list walk etc	(Christoph Hellwig)
o	Qlogic pcmcia scsi update			(Christoph Hellwig)
	| Still needs shared IRQ fix from 2.4.21pre5-ac
o	Fix bracketing error in maestro oss driver	(John Levon)
o	Don't claim too many ports for rtc		(Rusty Lynch)
o	Fix broken checks in i810_audio			(John Levon)
	| Still wants 2.4.21pre5-ac ac97/i810 fixes pulling
o	Fix e1000 hung zerop copy transfer on 82544
o	Add new board to cciss driver			(Stephen Cameron)
o	Fix piix build with CONFIG_PROC_FS=n		(Randy Dunlap)
o	Fix kmod SIGCLD problem				(Stelian Pop)
o	Fix check_region use in ht6560b			(Christoph Hellwig)
o	Fix check/requests in ide-dma			(Christoph Hellwig)
o	Remove dead __NO_VERSION__ from ide		(Christoph Hellwig)
o	Add PC9800 sound driver for CS4232		(Osamu Tomita)
o	Add per mach support for APM (for PC9800)	(Osamu Tomita)
o	PC9800 has different PnP locations to		(Osamu Tomita)
	normal
o	Handle NMI using mach-* scheme			(Osamu Tomita)
o	Fix /proc on slc90e66,sis5513, siimage, 	(Faik Uygur)
	serverworks, sc1200, piix, pdc202xx_old,
	pdc202xx_new, htp366, htp34x, cs5520, 
	amd74xx, aec62xx
o	IRQ stacks are back				(Dave Hansen)
o	Update 3c527 to modern locking (untested)	(James Bottomley)
o	PC9800 FAT handling				(Osamu Tomita)
o	PC9800 partition table handling	(Kyoto University Microcomputer Club)
o	CPIA updates/fixes				(Duncan Haldane)
o	IRDA timer fix					(Jean Tourrilhes)
o	Fix locking in irda discover code		(Jean Tourrilhes)
o	IrLap dynamic window fixes			(Jean Tourrilhes)
o	irda-usb cleanup and fixes			(Jean Tourrilhes)
o	Zerocopy rx for SIR				(Jean Tourrilhes)
o	Fix IrNET refcounting and discovery hints	(Jean Tourrilhes)
o	Fix kernel command line documentation		(Pavel Machek)
o	Fix incorrect __init in mpu401			(Daniel Ritz)
o	Remove unused LINUX_VERSION_CODE from sym53c416	(Adrian Bunk)
o	Fix check_region/request_region for ALSA isa	(Marcus Alanen)
	opti92x/ad1848
o	Update depca driver to eisa/sysfs		(Marc Zyngier)
o	Depca compile fix				(me)
o	Fix serial core stuff, remove obsolete		(me)
	baud changes
o	Fix jiffies wrap check code for 64bit		(Andi Kleen)
o	PCI quirk typo fix				(Geert Uytterhoeven)
o	Fix console initcall on Alpha			(Marc Zyngier)
o	Fix missing return value in pci irq changes	(Andrew Morton)
O	Fix usb-serial warnings with gcc 3.2		(David Gibson)
o	Fix warning in ohci on pwoerbook		(David Gibson)
o	IA64 needs syscall returns to be long		(David Mosberger)
o	S/390 updates					(Martin Schwidefsky)

Linux 2.5.64-ac1
	Merge Linus 2.5.63
	Merge Linus 2.5.64
	Revert broken watchdog changes
	Restore half removed make rpm
o	Revert wrong -ac change to keyboard.c		(me)
o	Fix cpufreq compile				(Bob Miller)
o	Remove incorrect keyboard patch (#407)

Linux 2.5.62-ac1
	Merge Linus 2.5.62
o	UNEXPECTED_IO_APIC can be static		(Pavel Machek)
o	Update IPMI driver to version 18		(Corey Minyard)
o	Tons of spelling fixes				(Steven Cole)
o	FBdev updates					(James Simmons)
o	PC-9800 update					(Osamu Tomita)
o	Remove dead scripts				(Brian Gerst)
o	v850 updates					(Miles Bader)
o	Update 3c523 to new MCA api (untested)		(James Bottomley)
o	Toshiba keyboard workaround			(Pavel Machek)
o	Fix mremap file name in comments		(Paul Larson)
o	Firestream typo fixes				(Maciej Soltysiak)
o	Backport trident reset fix from 2.4		(Muli Ben-Yehuda)
o	Morse code panics are back!			(Tomas Szepe)
o	Fix aicasm build				(Bob Tracy)
o	Fixes for 700/710 drivers			(Rolf Eike Beer)
o	Spelling fixes					(Rolf Eike Beer)
o	Optimise CRC32					(Joakim Tjernlund)
o	Next batch of v850 updates			(Miles Bader)
o	Takayoshi Kochi has moved email			(Takayoshi Kochi)
o	SunRPC race fix					(Trond Myklebust)
o	Refix addr/port naming confusion in IDE iops	(me)
o	Forward port VIA APIC handling quirks		(me)
o	Forward port ALi magick quirk flag handler	(me)
	| Needs bt848 etc to acquire the fix too
o	Forward port IDE bases fix			(me)
o	Forward port pci irq search for legacy IDE	(me)

Linux 2.5.61-ac1
	Merge Linus 2.5.61
o	Fix aic7xxx makefile				(Sam Ravnborg)
o	Fix ieee1394 build on Alpha			(Ben Collins)
o	Fix isdn_net build with X.25			(Adriank Bunk)
o	Typo fix					(Steven Bosscher)
o	A pile of other typo fixes			(Steven Cole)
o	C99 initializers				(Art Haas)
o	dasd typo fix					(Maciej Soltysiak)
o	Remove an unused variable in sunrpc		(Robert Love)
o	Remove duplicate different BSD partition names	(Andries Brouwer)
o	PPC plural fix					(Steven Cole)
o	EISA driver class patches			(Marc Zyngier)
o	VIA Rhine updates				(Roger Luethi)
o	Further ppa scsi fix				(John Kim)
o	Kill unused __beep				(Hugh Dickins)
o	Merge visws support 				(Andrey Panin)
	| Some collisions with pc9800 but should be ok
o	Limits for upward growing stacks		(Matthew Wilcox)
o	ucLinux updates					(Greg Ungerer)
o	68328 frame buffer updates			(Greg Ungerer)
o	Merge ucLinux H8300 support			(Yoshinori Sato)
o	Fix aironet compile				(Ookhoi)
o	Fix DMA mask on OSS trident driver		(Ivan Kokshaysky)
o	Kill some old 2.4 glue code in DRM		(John Kim)
o	Fix compile of old "hd.c" driver		(Paul Gortmaker)
o	Add experimental BOCHS virtualisation		(Kevin Lawton)
o	Clean up intermezzo driver			(Adrian Bunk)
o	Clean up rio use of compatmac			(Adrian Bunk)
o	Remove 2.0 ifdefs from ipchains code		(Adrian Bunk)
o	Remove old junk from efs 			(Adrian Bunk)
o	Remove old 2.0/2.2 junk from media/video	(Adrian Bunk)
o	Remove unused variable in ali-ircc		(Adrian Bunk)
o	Remove 2.0 ifdefs from network drivers		(Adrian Bunk)
o	Clean up uglies in inia100			(Adrian Bunk)
o	Clean up uglies in i91u scsi 			(Adrian Bunk)
o	Clean up wan drivers 2.0/2.2 code		(Adrian Bunk)
o	Restore ontrack remap support			(Jim Houston)
	| I'd really like to see this get turned into device mapper..
o	Forward port emu10k1 driver to 2.5		(Rui Souza)
o	Fix boot on EPOX 4BEA-R and friends		(Alexandar Achenbach)
o	Switch alpha cia code to static inline		(Matt Reppert)
o	Fix pcmcia scsi compile breakages		(Mike Anderson)
o	EHCI workarounds				(David Brownell)

Linux 2.5.60-ac1 (not published)
	Includes Linus BK snapshot
	Merge relevant pieces from old -ac		(me)
	| Dropped visws and stuff thats been redone
	| also dropped out IRQ stacks (port is tricky!)
o	Fix build of cciss driver			(me)
o	Fix build of 3036 tv tuner			(me)
o	Remove i2o_lan					(me)
o	Fix i2o_scsi					(Randy Dunlap)
o	Fix iph5526 scsi changes (not fixed DMA)	(me)
o	Make starfire compile				(me)
o	Make mca-legacy warn if used			(me)
o	Make sim710 build with EISA			(me)
o	Make ultrastor compile				(me)
o	Make aha152x/aha154x build			(Randy Dunlap)
o	Fix aha154x/mca bits				(me)
o	Fix fd_mcs build				(me)
o	Fix NCR53c406a.c				(me)
o	Fix sym53c416.c					(me)
o	Fix ibmmca compile				(me)
o	Fix ppa compile					(me)
o	Fix NCR539x compile				(John Kim)
o	Fix mca_53c9x compile				(me)
