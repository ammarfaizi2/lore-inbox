Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293683AbSCPDAj>; Fri, 15 Mar 2002 22:00:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293686AbSCPDAa>; Fri, 15 Mar 2002 22:00:30 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:30450
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S293683AbSCPDAW>; Fri, 15 Mar 2002 22:00:22 -0500
Date: Fri, 15 Mar 2002 19:01:37 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19pre2-ac1
Message-ID: <20020316030137.GC23938@matchmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <E16gyy2-0005oW-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16gyy2-0005oW-00@the-village.bc.nu>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- 2.4.19-pre1-ac2	Fri Mar 15 18:59:32 2002
+++ 2.4.19-pre2-ac1	Fri Mar 15 18:57:44 2002
@@ -41,37 +66,37 @@
 o	Fix trap when extending a single extent of	(Dave Kleikamp)
 	over 64Gb in JFS
 *	NBD deadlock fix				(Steven Whitehouse)
-+	Fix device ref counting in netrom stack		(Tomi Manninen)
+*	Fix device ref counting in netrom stack		(Tomi Manninen)
 *	Fix shmemfs link counting			(Christoph Rohland)
-+	Fix potential scsi disk oops			(Peter Wong)
+*	Fix potential scsi disk oops			(Peter Wong)
 *	eepro100 carrier init fix			(Jeff Garzik)
-+	Fix wrong kfree in netrom stack			(Tomi Manninen)
-+	Add TI1250 inits to ZV bus support		(me)
+*	Fix wrong kfree in netrom stack			(Tomi Manninen)
+*	Add TI1250 inits to ZV bus support		(me)
 	| Zoom video now works on the IBM TP600 at least..
-+	Fix off by one on loop devices limit		(Heinz Mauelshagen)
+*	Fix off by one on loop devices limit		(Heinz Mauelshagen)
 o	Improve handling of psaux open with no mouse	(Christoph Hellwig)
 	present
-+	3COM 3c359 token ring driver			(Mike Phillips)
+*	3COM 3c359 token ring driver			(Mike Phillips)
 *	Fix a case where hpfs didnt set block size	(Chris Mason)
 	early enough
-+	Remove use of lock_kernel in softdog driver	(me)
-+	Make olympic driver use spinlocks not 		(Mike Phillips)
+*	Remove use of lock_kernel in softdog driver	(me)
+*	Make olympic driver use spinlocks not 		(Mike Phillips)
 	lock_kernel
 o	Fix type of detected devices in md.c		(Jakob Kemi)
-+	Changes and defconfig update			(Niels Jensen)
+*	Changes and defconfig update			(Niels Jensen)
 o	PNP BIOS driver updates				(Thomas Hood)
-+	Turn off excess printks in pnp quirk reporting	(Andrey Panin)
-o	Add documentation for ITE I2C			(Steven Cole)
+*	Turn off excess printks in pnp quirk reporting	(Andrey Panin)
+*	Add documentation for ITE I2C			(Steven Cole)
 o	Add documentation for other zoran cards		(Steven Cole)
 o	Add an SC520 watchdog, and enable wd8387ff 	(Scott Jennings)
 o	Cleaned up and fixed some SC520 watchdog bugs	(me)
 	| Scott - can you double check these
-+	Fix return on generic lib/string.c memcmp	(Georg Nikodym)
-+	Further zoom video cleanups			(me)
+*	Fix return on generic lib/string.c memcmp	(Georg Nikodym)
+*	Further zoom video cleanups			(me)
 
 Linux 2.4.18rc2-ac1
 o	Merge with 2.4.18rc2
-+	Ignore i810 modem codecs			(me)
+*	Ignore i810 modem codecs			(me)
 o	Core of address space accounting code		(me)
 	| Enforcement, ptrace and some shmem corner bits to do
 *	Fix security hole in shmfs			(me)
@@ -84,23 +109,23 @@
 o	Make i2o_pci.c 64bit/BE clean			(me)
 o	Maybe fix crash on i2o scsi abort/reset paths	(me)
 o	Make i2o use the passed scsi direction flag	(me)
-+	Fix awk failure path in menuconfig		(Andrew Church)
+*	Fix awk failure path in menuconfig		(Andrew Church)
 o	Merge varies doc updates			(Steven Cole)
 o	Add serial support for the Lava Octopus-550	(Jim Treadway)
 *	OPL3SA2 cleanup					(Zwane Mwaikambo)
 o	Add missing blkdev_varyio export		(Todd Roy)
-o/+	Update Changes file, config and experimental	(Niels Jensen)
+o/*	Update Changes file, config and experimental	(Niels Jensen)
 	checks
-+	Fix highmem warning in aacraid			(Andrew Morton)
-+	Make tpqic02 use new style request region	(Marcus Alanen)
+*	Fix highmem warning in aacraid			(Andrew Morton)
+*	Make tpqic02 use new style request region	(Marcus Alanen)
 o	Only turn off mediagx/geode TSC on 5510/5520	(me)
 	| From information provided by Hiroshi MIURA
-+	Massively clean up the AGP enable and bugfix it	(Bjorn Helgaas)
+*	Massively clean up the AGP enable and bugfix it	(Bjorn Helgaas)
 o	Fix oops if you try to use the RW wq locks	(Bob Miller)
 o	Remove FPU usage in neomagic fb			(Denis Kropp)
 o	Merge IBM JFS			(Steve Best, Dave Kleikamp, 
 					 Barry Arndt, Christoph Hellwig, ..)
-+	Updated sis frame buffer driver			(Thomas Winischhofer)
+*	Updated sis frame buffer driver			(Thomas Winischhofer)
 
 Linux 2.4.18pre9-ac3
 *	Clean up various macros and misuse of ;		(Timothy Ball)
@@ -113,15 +138,15 @@
 							 Abraham vd Merwe
 							 and others)
 o	IBM Lanstreamer updates				(Mike Phillips)
-+	Fix acct rlimit problem (I hope)		(me)
+*	Fix acct rlimit problem (I hope)		(me)
 	| Problem noted by Ian Allen
 o	Automatically set file limits based on mem size	(Andi Kleen)
-+	Correct scsi reservation conflict handling	(James Bottomley)
+*	Correct scsi reservation conflict handling	(James Bottomley)
 	and add the scsi reset api code
 o	Add further kernel docs				(me)
 o	Merge to rmap-12e				(Rik van Riel and co)
 	|merge patch from Nick Orlov
-+	Small fix to the eata driver update		(Dario Ballabio)
+*	Small fix to the eata driver update		(Dario Ballabio)
 
 
 Linux 2.4.18pre9-ac2
@@ -129,13 +154,13 @@
 *	Put #error in two files that need FPU fixups	(me)
 *	Correct a specific mmap return to match posix	(Christopher Yeoh)
 *	Add Eepro100/VE ident				(Hanno Boeck)
-+	Add provides for DRM to the kernel make rpm	(Alexander Hoogerhuis)
+*	Add provides for DRM to the kernel make rpm	(Alexander Hoogerhuis)
 *	Fix a problem where vm86 irq releasing could be	(Stas Sergeev)
 	missed
-+	EATA and U14/34F driver updates			(Dario Ballabio)
-+	Handle EMC storage arrays that report SCSI-2 	(Kurt Garloff)
+*	EATA and U14/34F driver updates			(Dario Ballabio)
+*	Handle EMC storage arrays that report SCSI-2 	(Kurt Garloff)
 	but want REPORT_LUNs
-+	Update README, defconfig, remove autogen files	(Niels Jensen)
+*	Update README, defconfig, remove autogen files	(Niels Jensen)
 o	Add AFAVLAB PCI serial support			(Harald Welte)
 *	Fix incorrect resource free in eexpress		(Gianluca Anzolin)
 o	Variable size rawio optimisations		(Badari Pulavarty)
@@ -149,27 +174,27 @@
 o	Initial merge of DVD card driver  (Christian Wolff,Marcus Metzler)
 	| This is just an initial testing piece. DVB needs merging
 	| properly and this is only a first bit of testing
-+	Random number generator support for AMD768	(me)
-+	Add AMD768 to i810 driver pci ident list	(me)
+*	Random number generator support for AMD768	(me)
+*	Add AMD768 to i810 driver pci ident list	(me)
 o	Initial AMD768 power management work		(me)
 	| Unfinished pending some docs clarifications
-+	Fix bugbuf mishandling for modular es1370	(me)
+*	Fix bugbuf mishandling for modular es1370	(me)
 *	Fix up i2o readl abuse, post_wait race, and	(me, Arjan van de Ven)
 	some deadlock cases
 *	Added cpu_relax to yam driver 			(me)
 *	Fixup AMD762 if the BIOS apparently got it wrong(me)
 	(eg ASUS boards)
 *	MP1.4 alignment fixup
-+	pcwd cleanup, backport of fixes from 2.5	(Rob Radez)
-+	Add support for more Moxa cards to mxser	(Damian Wrobel)
-+/*	Add remaining missing MODULE_LICENSE tags	(Hubert Mantel)
-+	Fix floppy reservation ranges			(Anton Altaparmakov)
-+	Fix max file size setup				(Andi Kleen)
+*	pcwd cleanup, backport of fixes from 2.5	(Rob Radez)
+*	Add support for more Moxa cards to mxser	(Damian Wrobel)
+*	Add remaining missing MODULE_LICENSE tags	(Hubert Mantel)
+*	Fix floppy reservation ranges			(Anton Altaparmakov)
+*	Fix max file size setup				(Andi Kleen)
 
 Linux 2.4.18pre7-ac3
 o	Fix a wrong error return in the megaraid driver	(Arjan van de Ven)
 *	FreeVXFS update					(Christoph Hellwig)
-+	Qnxfs update					(Anders Larsen)
+*	Qnxfs update					(Anders Larsen)
 o	Fix non compile with PCI=n			(Adrian Bunk)
 o	Fix DRM 4.0 non compile in i810			(me)
 o	Drop out now dead CLONE thread/parent fixup	(Dave McCracken)
@@ -181,7 +206,7 @@
 o	Mark framebuffer mappings VM_IO			(Andrew Morton)
 o	Neomagic frame buffer driver			(Denis Kropp)
 	- Needs FPU code fixing before it can be merged
-+	Hyperthreading awareness for MTRR driver
+*	Hyperthreading awareness for MTRR driver
 o	Correct NR_IRQ with no apic support		(Brian Gerst)
 *	Fix missing includes in sound drivers		(Michal Jaegermann)
 
@@ -196,22 +221,22 @@
 *	Fix isdn audio compiler behaviour dependancy	(Urs Thuermann)
 *	YAM driver fixes				(Jean-Paul Roubelat)
 *	ROSE protocol stack update/fixes		(Jean-Paul Roubelat)
-+	Fix UFS/CDROM oops				(Zwane Mwaikambo)
-+	Fix nm256 hang on Dell Latitude			(origin unknown)
+*	Fix UFS/CDROM oops				(Zwane Mwaikambo)
+*	Fix nm256 hang on Dell Latitude			(origin unknown)
 	| Please test this tree with other NM256 based boxes and check
 	| those still work...
 o	Merge PnPBIOS patch		(Thomas Hood, David Hinds, Tom Lees,
 					 Christian Schmidt, ..)
-+	Merge new sis frame buffer drivers		(Thomas Winischhofer)
+*	Merge new sis frame buffer drivers		(Thomas Winischhofer)
 *	cs46xx oops fix					(Mike Gorse)
 *	Fix a second cs46xx bug related to this		(me)
 o	Fix acpitable oopses on boot and other problems	(James Cleverdon)
 o	Fix io port type on the hpt366 driver		(Pete Popov)
-+	Updated matrox drivers				(Petr Vandrovec)
+*	Updated matrox drivers				(Petr Vandrovec)
 *	IPchains fixes needed for 2.4.18pre7
 o	IDE config text updates for the IDE patches	(Anton Altaparmakov)
-+	Merge the first bits of ZV support		(Marcus Metzler)
-+	Add initial ZV support to yenta socket driver	(me)
+*	Merge the first bits of ZV support		(Marcus Metzler)
+*	Add initial ZV support to yenta socket driver	(me)
 	for TI cards
 *	Fix pirq routing on the CS5530 			(me)
 	| Finally the palmax pcmcia/cardbus works properly
