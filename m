Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131628AbQLPTkB>; Sat, 16 Dec 2000 14:40:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131632AbQLPTjv>; Sat, 16 Dec 2000 14:39:51 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:18701 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131628AbQLPTjm>; Sat, 16 Dec 2000 14:39:42 -0500
Subject: Linux 2.2.19pre2
To: linux-kernel@vger.kernel.org
Date: Sat, 16 Dec 2000 19:11:47 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E147MkJ-00036t-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Merge the Andrea VM changes. Nothing else in this pre-patch so we can be
sure we know if it broke something. The other stuff is still on my in queue
so don't resend it.

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
