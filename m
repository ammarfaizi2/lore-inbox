Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129998AbRB1ARv>; Tue, 27 Feb 2001 19:17:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129981AbRB1ARl>; Tue, 27 Feb 2001 19:17:41 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:21266 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129976AbRB1AR2>; Tue, 27 Feb 2001 19:17:28 -0500
Subject: Linux 2.2.19pre16
To: linux-kernel@vger.kernel.org
Date: Wed, 28 Feb 2001 00:20:44 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Message-Id: <E14XuMJ-0004ZQ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


2.2.19pre16
o	Add Epson 1240 usb scanner id			(Joel Becker)
o	Starfire driver updates				(Ion Badulescu)
o	Make xconfig fix 				(Craig Rogers)
o	Update credits for Richard Guenther		(Richard Guenther)
o	strnlen_user fixups				(Solar Designer)
o	Fix starfire netif_stop/start bug		(Ion Badulescu)
o	SIGIO from irq context fixes			(Andi Kleen)

2.2.19pre15
o	Hugh Blemings has moved				(Hugh Blemings)
o	Add support for usb hubs with many ports	(Randy Dunlap)
o	Reapply make xconfig isdn fix		(Andrzej Krzysztofowicz)
o	Fix the tcp problems				(Alexey Kuznetsov)
o	Kai Petzke has moved				(Kai Petzke)
o	Add BUG() to S/390				(Ulrich Weigand)
o	Further S/390 fixes				(Ulrich Weigand)
o	Add keventd from 2.4 to 2.2			(Ulrich Weigand)
	| Needed for S/390 drivers
o	Remove dead isdn_init call		(Andrzej Krzysztofowicz)
o	Remove bogus aha1542/aha1740 sense check	(Nick Holloway)
o	FPU emu fix					(Ulrich Weigand)
o	EEpro100 posted writes fix			(Andrey Savochkin,
							 Don Becker)

2.2.19pre14
o	Update slhc code for endianness			(Dave Miller)
o	Update s390 dasd driver				(Ulrich Weigand)
o	Allow more than 4K of partitions		(Ulrich Weigand)
o	Fix check in sockfilter				(Dave Miller)
o	Sparc updates (quad sbus sunhme detect, BUG())	(Dave Miller)
o	Fix hid locking and ston32 bugs			(Paul Mackerras)
o	Update 3c59x drivers		(Andrew Morton, Maciej Rozycki, 
					 Fred Maciel, Georg Engstrand,
					 Brett Frankenberger, Don Becker,
o	Fix a usb message				(Randy Dunlap)
o	Eicon driver updates				(Armin Schindler)
o	Update 8139too driver				(Jens David)
o	Fix USB hub locks				(Paul Mackerras)
o	Fix missing keyspan config line			(Paul Mackerras)
o	Merge S/390 bug fixes				(Ulrich Weigand)
o	Some S/390 cleanups				(Ulrich Weigand)
o	Update S/390 ELF magic 				(Ulrich Weigand)
o	Update hwc driver				(Ulrich Weigand)
o	Update ctc driver				(Ulrich Weigand)
o	Update iucv driver				(Ulrich Weigand)
o	S/390 warning fixes				(Ulrich Weigand)

2.2.19pre13
o	Fix up missing bits of Soohoon Lee's exec patch	(Michael Jaegerman)
	| not sure where some bits of it escaped too...
o	Revert serial driver locking patch		(me)
	| Seems to be causing crashes
o	PPC BUG(), and other compile fixes needed   (Benjamin Herrenschmidt)
o	ide_pmac_init to fix IDE probe power off    (Benjamin Herrenschmidt)
o	atyfb128 and serial for pmac		    (Benjamin Herrenschmidt)
o	Workaround early imac firmware bug	    (Benjamin Herrenschmidt)
o	Ensure task is running in mm faults		(Roger Larsson)
	| from 2.4
o	Fix nfs cache bug				(Neil Brown)
o	Further config.in cleanups/fixing	    (Andrzej Krzysztofowicz)
o	Clean up tulip changes remove accidental fix	(Jeff Garzik)
	reversions
o	Update defconfig				(Jeff Garzik)
o	Update usb printer driver in 2.2 to match 2.4 	(Randy Dunlap)
o	Fix posix compliance on sockopts

2.2.19pre12
o	Update the DAC960 driver			(Leonard Zubkoff)
o	Small PPC fixes					(Benjamin Herrenschmidt)
o	Document irda options config			(Steven Cole)
o	Small isdn fixes/obsolete code removal		(Kai Germaschewski)
o	Fix alpha kernel builds				(Michal Jaegermann)
o	Update ver_linux to match the 2.4 one		(Steven Cole)
o	AVM isdn driver updates				(Carsten Paeth)
o	ISDN capi/ppp fixes				(Kai Germaschewski)

2.2.19pre11
o	Corrected version of ipc/shm.c fix		(Christoph Rohland)
o	Update/cleanup starfire				(Ion Badulescu)
o	Update isdn makefiles				(Kai Germaschewski)
o	Eicon driver updates/new driver			(Armin Schindler)
	| code 
o	Hysdn driver					(Werner Cornelius)
o	Hisax updates					(Kai Germaschewski)

2.2.19pre10
o	Update aic7xxx driver to 5.1.33			(Doug Ledford)
o	Revert shm change - its unsafe			(Richard Nelson)
o	Update sunrpc code, add rpc ping congestion	(Trond Myklebust)
	checks
o	Fix wrong kfree in cosa driver			(Jan Kasprzak)
o	NFS client fixes				(Trond Myklebust)
o	Better dcache/inode hashes			(Dave Miller)
o	Fix missing skb->protocol init in AX.25		(Thomas Osterried)
o	EEpro100 reporting fix as per 2.4		(Ion Badulescu)
o	Starfire ethernet driver			(Don Becker,
							 Ion Badulescu,
							 Jeff Garzik, ...)
o	Memory handling fixes for ISDN core code	(Kai Germaschewski)
o	ISDN module locking fixes			(Kai Germaschewski)
o	Fix ISDN modem profile reading 			(Kai Germaschewski)
o	Fix missing mark_bh calls in isdn		(Kai Germaschewski)
o	Fix problems make xconfig has with config  (Andrzej Krzysztofowicz)
o	Clean up isdn to user new __init etc		(Kai Germaschewski)

2.2.19pre9
o	Merge all the pending NFS server fixes		(Neil Brown)
o	Neil becomes NFS server maintainer 		(Neil Brown)
o	Update to aic7xxx 5.1.32			(Doug Ledford)
o	Fix cs89x0 media selection			(Frank Copeland)
o	Tidy APM stuff, make buggy bios selector tighter(Stephen Rothwell)
o	Fix i2o config typo				(YOSHIMURA Keitaro)
o	Network updates, fix possible classifier hang	(Dave Miller)
o	Sparc updates (nfs compat, syscalls)		(Dave Miller)
o	Sparc watchdog driver				(Eric Brower)
o	Remove experimental tag on QoS code		(Dave Miller)
o	Move dumpable extra logic into binfmt avoiding	(Solar Designer)
	other changes to arch code. Back out old stuff
o	Fix sysctl miscastings from signed/unsigned	(Greg Kroah-Hartmann)
o	Alpha OSF syscall remove error printk	
o	Don't trust IRQ routing on the ruffian ARC	(Ivan Kokshaysky)

2.2.19pre8
o	Add support for ICS1893 PHY to sis900		(L C Chang)
o	Fix typo in nautilus code			(Tom Vier)
o	Clean up usb bandwidth messages			(Randy Dunlap)
o	USB ACM loosen up end point rules		(Randy Dunlap)
o	Fix tty module count corruptions		(Maciej Rozycki)
o	i2o block updates				(Boji Kannanthanam)
o	menuconfig updates				(Kirk Reiser)
o	Fix dmi/apm ordering bug			(Keith Owens,
							 Neale Banks)
o	Alpha SMP build fix				(Herbert Xu)
o	Fix igmp bugs					(Stefan Jonsson)
o	Fix USB config.in problems			(Greg Kroah-Hartmann)
o	Update Cort Dougan's info			(Cort Dougan)
o	Update to 2.4.0 style A20 gate handler		(Randy Dunlap)
o	Fix unneeded compat defines on S/390 ctc	(Kurt Roeckx)
o	Macintosh HID driver fixes			(Cort Dougan)
o	Fix ppc config/input layer and ksyms		(Cort Dougan)
o	ISDN updates					(Kai Germaschewski)
o	TGAfb as a module			(Andrzej Krzysztofowicz)
o	Syscall table updates for sparc64		(Ben Collins)
o	8139too driver updates				(Jens David)
o	Tighten packet length checks in masq/tproxy	(Julian Anastasov)
o	Fix udp port selection hang			(Dave Miller)

2.2.19pre7
o	Remove dead arm files				(Russell King)
o	Fix VIA rhine build failure for a few folks	(Peter Monta)
o	ARM ptrace fixes				(Russell King)
o	Fix ymfpci setup for legacy devices		(Pete Zaitcev)
o	xspeed dsl needs pci				(Lars Holmberg)
o	Typo fix					(Dave Miller)
o	Update ftdi usb serial driver			(Greg Kroah-Hartmann)
o	Update keyspan usb serial drivers		(Greg Kroah-Hartmann)
o	Sparc updates					(Dave Miller)
o	Remove incorrect lp printk			(Tim Waugh)
o	Fix ppa panic on timeout			(Tim Waugh)
o	Maestro3 needs ac97 codec			(Oleg Krivosheev)
o	Fix kwhich versus old bash			(Pete Zaitcev)
o	Fix ip checksum compiler behaviour assumption	(Dave Miller)
o	Fix real audio masq in presence of options	(John Villalovos)
o	ne2k-pci version printing tweaks		(J. Magallon)
o	Fix incorrect minors for some dasd devices as	(Holger Smolinski)
	root
o	Fix alpha exception table printk	    (Andrzej Krzysztofowicz)
o	USB config updates				(Greg Kroah-Hartmann)
o	USB audio driver updates			(Greg Kroah-Hartmann)
o	Fix missing unlock_kernel in usbdev		(Greg Kroah-Hartmann)
o	Update USB hid driver				(Greg Kroah-Hartmann)
o	USB rio driver update				(Greg Kroah-Hartmann)
o	Hopefully fix CyrixIII panic on boot		(Ingo Oeser, 
							 H Peter Anvin)
o	Further CMOS lock fixes, move ioctls		(Paul Gortmaker)
o	Dumpable should now work right again		(Zack Weinberg,
							 me)

2.2.19pre6
o	Yamaha PCI sound updates			(Pete Zaitcev)
o	Alpha SMP ASN reuse races			(Andrea Arcangeli)
o	Alpha bottom half SMP race fixes		(Andrea Arcangeli)
o	Alpha SMP read_unloc race fix			(Andrea Arcangeli)
o	Show registers across CPUs on SMP alpha death	(Andrea Arcangeli)
o	Print the 8K of stack not the top 4K on x86	(Andrea Arcangeli)
o	Dcache aging					(Andrea Arcangeli)
o	Kill unused parameter in free_inode_memory	(Andrea Arcangeli)

2.2.19pre5
o	Fix dumpable stuff				(Wolfgang Walter)
o	PPA driver update				(Tim Waugh)
o	ARM updates (Russell - ptrace.c errored please	(Russell King)
		resolve)
o	Fix NFS data alignment on ARM			(Russell King)
o	Fix hang on boot with ALi5451 shared irq midi	(Stephen Usher)
o	ESS Maestro 3 driver				(Zach 'Fufu' Brown)
o	Belorussia/Ukraine NLS table (koi8-ru)		(Andy Rysin)

2.2.19pre4
o	Fixed duplicate info on the microcode driver	(Daniel Rogers)
o	Update watchdog structs for nice user export	(Eric Brower)
o	Update Documentation/devices.txt		(H Peter Anvin)
o	Tweak sched.h to handle limit in Sparc		(Andrea Arcangeli)
	'make check_asm'
o	Move isdn pci definitions into pci.h		(Kai Germaschewski)
o	Tidy init data/static vars in the isdn code	(Kai Germaschewski)
o	Fix abuse of int for bitops in isdn		(Kai Germaschewski)
o	Use named initializers on the AVM B1		(Kai Germaschewski)
o	Switch capi message length to unsigned		(Kai Germaschewski)
o	ISDN updates					(Kai Germaschewski)
o	Update microcode code to check features right	(Tigran Aivazian)
	in 2.2
o	E820 handling fixup 				(Andrea Arcangeli)
o	Fix ne2k-pci driver build bug 			(J.A. Magallon)
o	DC390 driver updates				(Kurt Garloff)
o	Handle thinkpad E820 edx overwriting		(Marc Joosen)
o	Update the osst driver to 0.8.6.1		(Kurt Garloff, 
							 Willem Riede)
o	Init the cmpci if compiled in		(Raúl Núñez de Arenas Coronado)
o	ATP870U SCSI updates to fix disconnect bug	(Wittman Li)
o	Clean up the usbdevfs backport			(Dan Streetman)
o	Fix ATI rage makefiles				(Brad Douglas)

2.2.19pre3
o	Merge ADMtek-comet tulip support		(Jim McQuillan)
o	Update microcode driver				(Tigran Aivazian)
o	Merge Don Becker's NE2K full duplex support	(Juan Lacarta)
o	Optimise kernel compiler detect, kgcc before	(Peter Samuelson)
	gcc272 also
o	Fix compile combination problems		(Arjan van de Ven)
o	Update via-rhine driver to include Don's changes(Urban Widmark)
	for VT6102
o	Documentation updates				(Tim Waugh)
o	Add ISDN PCI defines to pci.h			(Kai Germaschewski)
o	Fix smb/fat handling for pre 1980 dates		(Igor Zhbanov)
o	SyncLink updates				(Paul Fulghum)
o	ICP vortex driver updates 			(Andreas Köpf)
o	mdacon clean up					(Pavel Rabel)
o	Fix bugs in es1370/es1371/sonicvibes/solo1/	(Thomas Sailer)
	dabusb
o	Speed up x86 irq/fault paths by avoiding xchg	(Mikael Pettersson)
	locked cycles (from Brian Gerst's 2.4test change)
o	Tighten up K6 check in bug tests		(Mikael Pettersson)
o	Backport configure scripts bug fixes		(Mikael Pettersson)
o	Fix duplicat help entries			(Riley Williams)
o	Fix small asm bug in constant size uaccess	(David Kutz)
o	Update ymfpci driver to handle legacy audio	(Daisuke Nagano)
o	Remove ymfsb driver now no longer needed	(Daisuke Nagano)
o	Add Empeg support to usb-serial			(Gary Brubaker)
o	Fix e820 handling				(Andrea Arcangeli)
o	Fix lanstreamer SMP locking			(George Staikos)
o	Fix S/390 non SMP build				(Kurt Roeckx)
o	Fix the PCI syscall on PowerMac		(Benjamin Herrenschmidt)
o	Fix IPC_RMID behaviour				(Christoph Rohland)
o	Fix NETCTL_GETFD on sparc64			(Dave Miller)
o	Tidy unneeded restore_flags/save sequence  (Arnaldo Carvalho de Melo)
	on the ultrastor
o	Fix resource clean up on error in 89xo     (Arnaldo Carvalho de Melo)
	driver
o	Update wireless headers				(Jean Tourrilhes)
o	Fix non modular emu10k init			(Mikael Pettersson)
o	Fix cpuid/msr driver crashes			(Andrew Morton)
o	Write core files sparse				(Christoph Rohland)
o	Merge the i810 tco (watchdog) timer		(me)
	| original by Jeff Garzik


2.2.19pre2
o	Drop the page aging for a moment to merge the
	Andrea VM
o	Merge Andrea's VM-global patch			(Andrea Arcangeli)

2.2.19pre1
o	Basic page aging				(Neil Schemenauer)
	| This is a beginning to trying to get the VM right
	| Next stage is to go through Andrea's stuff and sort 
	| it out the way I want it.
o	E820 memory detect backport from 2.4		(Michael Chen)
o	Fix cs46xx refusing to run on emachines400	(me)
o	Fix parport docs				(Tim Waugh)
o	Fix USB serial name reporting			(me)
o	Fix else warning in initio scsi			(John Fort)
o	Fix incorrect timeout (that couldnt occur
	fortunately) in sched.c				(Andrew Archibald)
o	Fix A20 fix credits				(Christian Lademann)
o	Support for OnStream SC-x0 tape drives		(Willem Riede, 
							 Kurt Garloff)
o	Intel 815 added to the AGPGART code		(Robert M Love)
o	3Ware scsi fixes			(Arnaldo Carvalho de Melo)
o	Clean up scsi_init_malloc no mem case	(Arnaldo Carvalho de Melo)
o	Fix dead module parameter in ip_masq_user.c	(Keith Owens)
o	Switch max_files and friends to a struct to	(Tigran Aivazian)
	be sure they stay together
o	Update microcode driver				(Tigran Aivazian)
o	Fix free memory dereference in lance driver	(Eli Carter)
o	ISOfs fixes 					(Andries Brouwer)
o	Watchdog driver for Advantech boards		(Marek Michalkiewicz)
o	ISDN updates					(Karsten Keil)
o	Docs fix 					(Pavel Rabel)
o	wake_one semantics for accept()			(Andrew Morton)
o	Masquerade updates				(Juanjo Ciarlante)
o	Add support for long serialnums on the Metricom	(Alex Belits)
o	Onboard ethernet driver for the Intel 'Panther'	(Ard van Breemen,
	boards						 Andries Brouwer)
o	VIA686a timer reset to 18Hz background		(Vojtech Pavlik)
o	3c527 driver rewrite				(Richard Procter)
	| This supercedes my driver because
	| - it works for more people
	| - he has time to use his MCA box to debug it
o	Minix subpartition support			(Anand Krishnamurthy 
							 Rajeev Pillai)
o	Remove unused() crap from DRM. You will need
	to hand load agp as well if needed		(me)


--
Alan Cox <alan@lxorguk.ukuu.org.uk>
Red Hat Kernel Hacker
& Linux 2.2 Maintainer                        Brainbench MVP for TCP/IP
http://www.linux.org.uk/diary                 http://www.brainbench.com

