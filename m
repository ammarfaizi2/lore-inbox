Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312931AbSDYFbi>; Thu, 25 Apr 2002 01:31:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312942AbSDYFbi>; Thu, 25 Apr 2002 01:31:38 -0400
Received: from sunny.pacific.net.au ([203.25.148.40]:35313 "EHLO
	sunny.pacific.net.au") by vger.kernel.org with ESMTP
	id <S312931AbSDYFbh>; Thu, 25 Apr 2002 01:31:37 -0400
Message-ID: <005101c1ec19$3f280750$0400a8c0@MrDice>
From: "Geoff Powell" <gbp@pacific.net.au>
To: <linux-kernel@vger.kernel.org>
Subject: 2.2.21-rc3 IDE/Keyboard problem
Date: Thu, 25 Apr 2002 15:22:50 +1000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6700
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I'm having some trouble finding a kernel which will successfully boot on my
computer. It seems to be having trouble during the boot process finding the
IDE devices, parts of my dmesg are below

PCI_IDE: unknown IDE controller on PCI bus 00 device f9, VID=8086, DID=244b
PCI_IDE: not 100% native mode: will prove irqs later
ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
ide1: BM-DMA at 0xf00f, BIOS settings: hdc:DMA, hdd:DMA
hdc: IRQ probe failed (0)
hdc: IRQ probe failed (0)
hdc: CD-ROM 36x/AKU, ATAPI CDROM drive
hdc: IRQ probe failed (0)
hdd: IRQ probe failed (0)
hdd: IRQ probe failed (0)
hdd: 8X4X32, ATAPI CDROM drive
hdd: IRQ probe failed (0)
ide1 at 0x170-0x177,0x376 on irq 15
hdc: lost interrupt
hdc: lost interrupt
hdc: lost interrupt
hdc: ATAPI 36X CD-ROM drive, 128kb Cache
Uniform CD-ROM driver Revision: 3.11
hdd: lost interrupt
hdd: lost interrupt
hdd: lost interrupt
Floppy drive(s): fd0 is 1.44M
floppy0: no floppy controllers found

(after ethernet device is detected)
hda: 8223MB, CHS=16708/16/63
hdb: 29180MB, CHS=3720/255/63
Partition check:
 hda:hda: timeout
 hda: timeout (10 times)

And, earlier in the dmesg I get a keyboard error:
keyboard: Timeout - AT keyboard not present?

My system is a P4, motherboard is the Gigabyte GA-8IDML-C (Intel 845
AGPset), 256M pc133 ram. Both of my hard drives are seagate. I use debian,
the 2.2.19-pre17-idepci rescue kernel works boots fine (no IDE or keyboard
problems), I also tried 2.2.20 which produced the same errors as 2.2.21-rc3.

What is going on?

Geoff

