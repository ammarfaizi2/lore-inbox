Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131645AbQLVBUo>; Thu, 21 Dec 2000 20:20:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131695AbQLVBUe>; Thu, 21 Dec 2000 20:20:34 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:29456 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131645AbQLVBUW>; Thu, 21 Dec 2000 20:20:22 -0500
Subject: Linux 2.2.19pre3
To: linux-kernel@vger.kernel.org
Date: Fri, 22 Dec 2000 00:52:32 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Message-Id: <E149GRm-0003sX-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


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

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
