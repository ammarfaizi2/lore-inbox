Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264864AbRFTJJq>; Wed, 20 Jun 2001 05:09:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264865AbRFTJJg>; Wed, 20 Jun 2001 05:09:36 -0400
Received: from jdi.jdimedia.nl ([212.204.192.51]:21642 "EHLO jdi.jdimedia.nl")
	by vger.kernel.org with ESMTP id <S264864AbRFTJJY>;
	Wed, 20 Jun 2001 05:09:24 -0400
Date: Wed, 20 Jun 2001 11:09:14 +0200 (CEST)
From: Igmar Palsenberg <i.palsenberg@jdimedia.nl>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.5 strange behaviour
Message-ID: <Pine.LNX.4.30.0106201101360.14975-100000@jdi.jdimedia.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

2.4.5 keeps thinking I can change a CDROM 20 times a second or so.

System :

Compaq Armada 7360 DMT

Relevant stuff from dmesg :

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
PCI_IDE: unknown IDE controller on PCI bus 00 device 71, VID=0e11,
DID=ae33
PCI: Device 00:0e.1 not available because of resource collisions
PCI_IDE: chipset revision 3
PCI_IDE: not 100% native mode: will probe irqs later
hda: IBM-DTCA-23240, ATA DISK drive
hdb: COMPAQ CRD-S88P, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: 6354432 sectors (3253 MB) w/468KiB Cache, CHS=788/128/63
hdb: ATAPI 8X CD-ROM drive, 256kB Cache
Uniform CD-ROM driver Revision: 3.12

If starts spitting messages in the form of

VFS: Disk change detected on device ide0(3,64)

The behaviour seems to be triggered by some event, and if that happens the
only way to resolve == reboot


Second think is that the IrDA subsystem seems to have stopped working. I'm
looking into that (irattach goes fine, detection also, but no contact with
the device itself)

I'm going back to 2.4.4 to see if thing go better.


	Igmar


-- 

Igmar Palsenberg
JDI Media Solutions

Boulevard Heuvelink 102
6828 KT Arnhem
The Netherlands

mailto: i.palsenberg@jdimedia.nl
PGP/GPG key : http://www.jdimedia.nl/formulier/pgp/igmar

