Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289647AbSBKOLF>; Mon, 11 Feb 2002 09:11:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289646AbSBKOK4>; Mon, 11 Feb 2002 09:10:56 -0500
Received: from ATNSMTP91.24on.cc ([213.225.2.184]:56843 "EHLO
	atnsmtp91.24on.cc") by vger.kernel.org with ESMTP
	id <S289386AbSBKOKu>; Mon, 11 Feb 2002 09:10:50 -0500
Content-Type: text/plain; charset=US-ASCII
From: "sHANT)I(" <shanti@mojo.cc>
Organization: MOJO.cc
Message-Id: <200202111459.36390@@kosh.mojo.cc>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: kernel panic - bug or Hardware ?
Date: Mon, 11 Feb 2002 15:10:42 +0100
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <E16aH4N-0006iG-00@the-village.bc.nu>
In-Reply-To: <E16aH4N-0006iG-00@the-village.bc.nu>
Cc: linux-kernel@vger.kernel.org
VIRTUE: ||||| ... for this will do good YYYYY
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

guess so , but i have to try again .. to be sure .. mainly i installed linux because freebsd (4.4&4.5) crashed with similiar problems but without
debugoutput -- so it tried on linux (for more detail) .. will check it out .. 

this is the part of dmesg when linux just runs on hda (internal-ide-controller) .. there is still no use of the
fasttrack-attached devices, just compiled in.

btw .. i have to say that i use `append=" noapic"` so that the system wont crash on bootstrap

----------snip--------
Feb  4 21:31:56 paladin kernel: PDC20262: IDE controller on PCI bus 01 dev 60
Feb  4 21:31:56 paladin kernel: PDC20262: chipset revision 1
Feb  4 21:31:56 paladin kernel: PDC20262: not 100%% native mode: will probe irqs later
Feb  4 21:31:56 paladin kernel: PDC20262: (U)DMA Burst Bit ENABLED Primary MASTER Mode Secondary MASTER Mode.
Feb  4 21:31:56 paladin kernel:     ide2: BM-DMA at 0xfc80-0xfc87, BIOS settings: hde:pio, hdf:pio
Feb  4 21:31:56 paladin kernel:     ide3: BM-DMA at 0xfc88-0xfc8f, BIOS settings: hdg:pio, hdh:pio
Feb  4 21:31:56 paladin kernel: hda: Maxtor 82161E2, ATA DISK drive
Feb  4 21:31:56 paladin kernel: hde: Maxtor 2B020H1, ATA DISK drive
Feb  4 21:31:56 paladin kernel: hdg: Maxtor 2B020H1, ATA DISK drive
--------snap---------



Am Montag, 11. Februar 2002 15:04 schrieben Sie:
-=> > i run a quad-cpu netserver (64MB parityRAM , 2x onboard Adaptec aic7870 SCSI adapter) under  Debian potato with 2.2.x kernel
-=> > without any problem , but had to compile 2.4.17 for getting my Promise-Fastrack66-controller to work .. and since i run on 2.4 i 
-=> > get strange kernel panic (totally random in time and action) with always the same trace.
-=> > For i really have no idea on kernel debugging, i hope that i am right listed here to find help
-=> 
-=> Hard to tell (you've attached the right things but they dont provide much of
-=> an answer other than 'crap happened').
-=> 
-=> You say you had to built this to get your fasttrack card working. If you run
-=> without the fasttrak card in use (as you did in 2.2) does the box do this ?
-=> 
-=> 

-- 

vaja con dios !

                    sHANT)I(-    service with a sm)le
