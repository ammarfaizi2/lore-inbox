Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293676AbSCPCnE>; Fri, 15 Mar 2002 21:43:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293677AbSCPCmz>; Fri, 15 Mar 2002 21:42:55 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:4082
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S293676AbSCPCms>; Fri, 15 Mar 2002 21:42:48 -0500
Date: Fri, 15 Mar 2002 18:44:02 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19-pre3-ac1
Message-ID: <20020316024402.GA23938@matchmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <E16lgjZ-0002Uh-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E16lgjZ-0002Uh-00@the-village.bc.nu>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since Alan is going through all the trouble to update this list, we should
probably be able to see it.

It does show some characters that came in from the previous mail.  I'm sure
there's a command that'll fix it up for me, but I haven't looked yet. (if
you know reply offline please).

Mike

--- 2.4.19-pre2-ac4.log	Fri Mar 15 18:35:42 2002
+++ 2.4.19-pre3-ac1.log	Fri Mar 15 18:36:00 2002
@@ -7,21 +39,21 @@
 o	mp table parsing corner case fix		(James Cleverdon)
 o	NFS over JFS directory offset fix		(Christoph Hellwig)
 o	Update reisefsprogs version			(Paul Komkoff)
-o	RME Hammerfall driver update			(G=FCnter Geiger)
+o	RME Hammerfall driver update			(Günter Geiger)
 o	Fix an off by one in the bluesmoke reporting	(Dave Jones)
 +	Make irnet disconnect hang up ppp		(Jean Tourrilhes)
 +	Fix abuse of cli() in irda socket connect	(Jean Tourrilhes)
 +	Add help text to patch-kernel script		(Damjan Lango)
-+	USB irda updates				(Jean Tourrilhes)
+*	USB irda updates				(Jean Tourrilhes)
 +	IRDA link layer updates				(Jean Tourrilhes)
 o	Add WD xd signature to 2.4 (from 2.2)		(Jim Freeman)
 o	Update sc1200 watchdog				(Zwane Mwaikambo)
 o	Switch wdt501 watchdog driver to bitops		(me)
 o	Much updated LSI logic MPT fusion drivers	(Pam Delaney)
-+	Wavelan driver updates				(Jean Tourrilhes)
+*	Wavelan driver updates				(Jean Tourrilhes)
 o	Fix a race where we could hit init_idle after	(Kip Walker)
 	freeing it (from rest_init)
-+	Raylink driver bugfixes				(Jean Tourrilhes)
+*	Raylink driver bugfixes				(Jean Tourrilhes)
 o	Switch 2.4 to using a shared zlib		(David Woodhouse)
 o	Fix w83877 SMP deadlock, clean up locking	(me)
 o	IBM lanstreamer update				(Kent Yoder)
@@ -32,16 +64,16 @@
 o	All pids in use handling			(Paul Larson)
 o	IDE code wasn't using ide_free_irq		(William Jhun)
 o	Fix non procfs build				(Eric Sandeen)
-+	Cyberjack bug fix				(Greg Kroah-Hartmann)
-+	USB vicam fixes					(Oliver Neukum)
-+	Add another device to the ftdi driver		(Greg Kroah-Hartmann)
-+	UHCI performance fixes				(Johannes Erdfelt)
-+	STV680 bug fixes				(Kevin Sisson)
-+	Kaweth bug fixes				(Oliver Neukum)
-+	Update hpusbscsi driver				(Oliver Neukum)
-+	Update OV511 driver				(Mark McClelland)
-+	Update usb-ipaq driver to support journada	(Ganesh Varadarajan)
-+	Fix a bug in the USB skeleton driver		(Holger Waechtler)
+*	Cyberjack bug fix				(Greg Kroah-Hartmann)
+*	USB vicam fixes					(Oliver Neukum)
+*	Add another device to the ftdi driver		(Greg Kroah-Hartmann)
+*	UHCI performance fixes				(Johannes Erdfelt)
+*	STV680 bug fixes				(Kevin Sisson)
+*	Kaweth bug fixes				(Oliver Neukum)
+*	Update hpusbscsi driver				(Oliver Neukum)
+*	Update OV511 driver				(Mark McClelland)
+*	Update usb-ipaq driver to support journada	(Ganesh Varadarajan)
+*	Fix a bug in the USB skeleton driver		(Holger Waechtler)
 o	Further SiS IDE updates				(Lionel Bouton)
 o	Fix ufs mount failure bug			(Andries Brouwer)
 o	Allow the max user frequency for the rtc to	(Mike Shaver)
@@ -49,16 +81,15 @@
 o	HPT37x crash on init fixups			(Vojtech Pavlik)
 
 Linux 2.4.19pre2-ac3
-o	Fix quota deadlock and extreme load corruption	(Jan Kara, Chris Mason=
-)
-+	MIPS config fix					(Ralf Baechle)
-+	Update AGP config entry				(Daniele Venzano)
-+	SMBfs NLS oops fix				(Urban Widmark)
+o	Fix quota deadlock and extreme load corruption	(Jan Kara, Chris Mason)
+*	MIPS config fix					(Ralf Baechle)
+*	Update AGP config entry				(Daniele Venzano)
+*	SMBfs NLS oops fix				(Urban Widmark)
 o	Fix expand_stack locking hang on OOM		(Kevin Buhr)
 o	Restore 10Mbit half duplex eepro100 fix		(me)
 o	3c509 full duplex and documentation		(David Ruggiero)
 o	3c509 power management				(Zwane Mwaikambo)
-+	Remove more surplus llseek methods		(Robert Love)
+*	Remove more surplus llseek methods		(Robert Love)
 X	ATM locking fix					(Frode Isaksen)
 o	Merge extra sound help texts			(Steven Cole)
 	| plus one typo fix
@@ -68,23 +99,23 @@
 Linux 2.4.19pre2-ac2
 o	Fix a mismerge (may explain the patch weirdo)
 +	Fix highmem + sblive				(Daniel Bertrand)
-+	Reiserfs updates				(Oleg Drokin)
+*	Reiserfs updates				(Oleg Drokin)
 o	Auto enable HT on HT capable systems		(Arjan van de Ven)
 o	Fix init/do_mounts O(1) scheduler merge glitch	(Greg Louis)
-o	Fix drm build problem on CPU=3D386		(Mark Cooke)
+o	Fix drm build problem on CPU=386		(Mark Cooke)
 o	Fix incorrect sleep in ZR36067 driver		(me)
 o	Add missing cpu_relax to iph5526 driver		(me)
 
 Linux 2.4.19pre2-ac1
 o	Merge aic7xxx update				(Justin Gibbs)
 o	Fix handling of scsi 'medium error: recovered'	(Justin Gibbs)
-+/o	Further request region fixups			(Marcus Alanen)
+*	Further request region fixups			(Marcus Alanen)
 o	Add interlace/doublescan to voodoo1/2 fb driver	(Urs Ganse)
 	| interlace is always handy with 3d glasses..
 o	Merge O(1) scheduler				(Ingo Molnar)
 	| Thanks to Martin Knoblauch for doing the merge work
 	| Non x86 ports may need to clean up their mm/fault.c
-+/o	Lseek usage cleanup				(Robert Love)
+*	Lseek usage cleanup				(Robert Love)
 o	Merge with 2.4.19pre2
 	-	Fixed bogus sysctl definitions
 	-	Fixed incorrect MODULE_LICENSE backout
@@ -94,7 +125,7 @@
 	-	Fixed broken config rules from mips people
 	-	Made cciss build
 	-	Remove half written "meth.c" driver
-+	Fix up some of the watchdog api text		(me)
+*	Fix up some of the watchdog api text		(me)
 	| Janitor job - go through that and make all the drivers
 	| support all the things ('V' NOWAYOUT and ioctl core)
 o	Fix wrong order in MAINTAINERS			(me)
@@ -104,23 +135,23 @@
 o	Fix chown/chmod on shmemfs			(me)
 o	Fix accounting error in the shm code		(me)
 o	Turn on mode2/mode3 overcommit protection	(me)
-+	w83877f watchdog fix compile for SMP		(Mark Cooke)
-+	Fix ide=3Dnodma for serverworks			(Ken Brownfield)
+*	w83877f watchdog fix compile for SMP		(Mark Cooke)
+*	Fix ide=nodma for serverworks			(Ken Brownfield)
 *	USB2 controller support				(Greg Kroah-Hartmann)
 *	Add more devices to the visor driver (m515,clie)(Greg Kroah-Hartmann)
 *	IBM USB camera driver updates			(Greg Kroah-Hartmann)
-+	USB auerswald driver				(Wolfgang Muees)
+*	USB auerswald driver				(Wolfgang Muees)
 o	Trivial random match up with 2.2		(Marco Colombo)
 *	Spelling fixes					(Jim Freeman)
 *	Next batch of time_*() fixups			(Tim Schmielau)
 +	Update video4linux API docs			(Gerd Knorr)
-+	Merge some comment fixups			(John Kim)
+*	Merge some comment fixups			(John Kim)
 o	ymfpci sync					(Pete Zaitcev)
 *	Update maintainers to add pm3fb			(Romain DOLBEAU)
 *	Hotplug updates (docs, fs, compaq driver)	(Greg Kroah-Hartmann)
 *	IBM hotplug support	(Irene Zubarev, Tong Yu, Jyoti Shah, Chuck Cole)
 *	ACPI hotplug driver support		(Hiroshi Aono, Takayoshi Kochi)
-+	Blink keyboard lights on x86 panic		(Andi Kleen)
+*	Blink keyboard lights on x86 panic		(Andi Kleen)
 o	Further Configure.help changes			(Steven Cole)
 o	Merge a version of the sard I/O accounting	(Stephen Tweedie,
 							 Christoph Hellwig)
@@ -195,12 +226,12 @@
 	checks
 *	Fix highmem warning in aacraid			(Andrew Morton)
 *	Make tpqic02 use new style request region	(Marcus Alanen)
-+	Only turn off mediagx/geode TSC on 5510/5520	(me)
+*	Only turn off mediagx/geode TSC on 5510/5520	(me)
 	| From information provided by Hiroshi MIURA
 *	Massively clean up the AGP enable and bugfix it	(Bjorn Helgaas)
 o	Fix oops if you try to use the RW wq locks	(Bob Miller)
 o	Remove FPU usage in neomagic fb			(Denis Kropp)
-o	Merge IBM JFS			(Steve Best, Dave Kleikamp,=20
+o	Merge IBM JFS			(Steve Best, Dave Kleikamp, 
 					 Barry Arndt, Christoph Hellwig, ..)
 *	Updated sis frame buffer driver			(Thomas Winischhofer)
 
@@ -208,8 +239,8 @@
 *	Clean up various macros and misuse of ;		(Timothy Ball)
 *	Correct procfs locking fixup			(Al Viro)
 o	Speed up ext2/ext3 synchronous mounts		(Andrew Morton)
-+	Update IDE DMA blacklist			(Jonathan Kamens)
-o	Update to XFree86 DRM 4.2 (compatible to 4.1)	(Rik Faith,=20
+*	Update IDE DMA blacklist			(Jonathan Kamens)
+o	Update to XFree86 DRM 4.2 (compatible to 4.1)	(Rik Faith, 
 	and adds I830 DRM				 Jeff Hartmann,
 							 Keith Whitwell,
 							 Abraham vd Merwe
@@ -227,7 +258,7 @@
 
 
 Linux 2.4.18pre9-ac2
-+	Nat Semi now use their own ident on the Geode	(Hiroshi Miura)
+*	Nat Semi now use their own ident on the Geode	(Hiroshi Miura)
 *	Put #error in two files that need FPU fixups	(me)
 *	Correct a specific mmap return to match posix	(Christopher Yeoh)
 *	Add Eepro100/VE ident				(Hanno Boeck)
@@ -272,9 +303,9 @@
 o	Fix a wrong error return in the megaraid driver	(Arjan van de Ven)
 *	FreeVXFS update					(Christoph Hellwig)
 *	Qnxfs update					(Anders Larsen)
-o	Fix non compile with PCI=3Dn			(Adrian Bunk)
+o	Fix non compile with PCI=n			(Adrian Bunk)
 o	Fix DRM 4.0 non compile in i810			(me)
-o	Drop out now dead CLONE thread/parent fixup	(Dave McCracken)
+*	Drop out now dead CLONE thread/parent fixup	(Dave McCracken)
 *	Make NetROM incoming frame check stricter	(Tomi Manninen)
 *	Use sock_orphan in AX.25/NetROM			(Jeroen PE1RXQ)
 o	Pegasus update					(Petko Manolov)
@@ -284,14 +315,14 @@
 o	Neomagic frame buffer driver			(Denis Kropp)
 	- Needs FPU code fixing before it can be merged
 *	Hyperthreading awareness for MTRR driver
-+	Correct NR_IRQ with no apic support		(Brian Gerst)
+*	Correct NR_IRQ with no apic support		(Brian Gerst)
 *	Fix missing includes in sound drivers		(Michal Jaegermann)
 
 Linux 2.4.18pre7-ac2
 *	i810 audio driver update			(Doug Ledford)
-+	Early ioremap for x86 specific code		(Mikael Pettersson)
+*	Early ioremap for x86 specific code		(Mikael Pettersson)
 	| This is needed to do things like apic/dmi detect early enough
-+	Pentium IV APIC/NMI watchdog			(Mikael Pettersson)
+*	Pentium IV APIC/NMI watchdog			(Mikael Pettersson)
 *	Add C1MRX support to sonypi driver		(Junichi Morita)
 *	Fix "make rpm" with two '-' in extraversion	(Gerald Britton)
 *	Fix aacraid hang/irq storm on i960 boards	(Chris Pascoe)
@@ -307,7 +338,7 @@
 *	Merge new sis frame buffer drivers		(Thomas Winischhofer)
 *	cs46xx oops fix					(Mike Gorse)
 *	Fix a second cs46xx bug related to this		(me)
-+	Fix acpitable oopses on boot and other problems	(James Cleverdon)
+*	Fix acpitable oopses on boot and other problems	(James Cleverdon)
 o	Fix io port type on the hpt366 driver		(Pete Popov)
 *	Updated matrox drivers				(Petr Vandrovec)
 *	IPchains fixes needed for 2.4.18pre7
@@ -326,7 +357,7 @@
 
 Linux 2.4.18pre3-ac2
 
-+	Re-merge the IDE patches			(Andre Hedrick and co)
+*	Re-merge the IDE patches			(Andre Hedrick and co)
 *	Fix check/request region in ali_ircc and lowcomx(Steven Walter)
 	com90xx, sealevel, sb1000
 *	Remove unused message from 6pack driver		(Adrian Bunk)
@@ -338,7 +369,7 @@
 o	Add bridge resources to the resource tree	(Ivan Kokshaysky)
 *	Fix iphase ATM oops on close in on case	   (Till Immanuel Patzschke)
 *	Enable OOSTORE on winchip processors		(Dave Jones, me)
-	| Worth about 10-20% performance=20
+	| Worth about 10-20% performance 
 *	Code Page 1250 support				(Petr Titera)
 *	Fix sdla and hpfs doc typos			(Sven Vermeulen)
 o	Document /proc/stat				(Sven Heinicke)
