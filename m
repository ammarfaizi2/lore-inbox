Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263069AbTCWOUJ>; Sun, 23 Mar 2003 09:20:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263078AbTCWOUJ>; Sun, 23 Mar 2003 09:20:09 -0500
Received: from 205-158-62-158.outblaze.com ([205.158.62.158]:1200 "HELO
	spf1.us.outblaze.com") by vger.kernel.org with SMTP
	id <S263069AbTCWOUI>; Sun, 23 Mar 2003 09:20:08 -0500
Message-ID: <20030323143108.30109.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Felipe Alfaro Solana" <felipe_alfaro@linuxmail.org>
To: baldrick@wanadoo.fr, alan@redhat.com
Cc: linux-kernel@vger.kernel.org
Date: Sun, 23 Mar 2003 15:31:08 +0100
Subject: Re: 2.5 BK boot hang after ide
X-Originating-Ip: 213.4.13.153
X-Originating-Server: ws5-7.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message ----- 
From: Duncan Sands <baldrick@wanadoo.fr> 
Date: 	Sun, 23 Mar 2003 14:44:21 +0100 
To: alan@redhat.com 
Subject: 2.5 BK boot hang after ide 
 
> Copied down by hand: 
>  
> ... 
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx 
> VP_IDE: IDE controller at PCI slot 00:11.1 
> ACPI: No IRQ known for interrupt pin A of device 00:11.1 - using IRQ 255 
> VP_IDE: Chipset revision 6 
> VP_IDE: not 100% native mode: will probe irqs later 
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx 
> VP_IDE: VIA vt 8235 (rev 00) IDE UDMA 133 controller on pci00:11.1 
> 	ide0: BM_DMA at 0xfc00-0xfc07, BIOS settings: hda: DMA, hdb: DMA 
> 	ide1: BM_DMA at 0xfc08-0xfc0f, BIOS settings: hdc: DMA, hdd: DMA 
> hda: ST320423A, ATA DISK drive 
> hdb: Maxtor 6E030L0, ATA DISK drive 
> id0 at 0x1f0-0x1f7, 0x3f6 on irq 14 
> hdc: TOSHIBA DVD-ROM SD-MI402, ATAPI CD/DVD-ROM drive 
> hdd: LG CD-RW CED-8080B, ATAPI CD/DVD-ROM drive 
> ide1 at 0x170-0x177, 0x376 on irq 15 
> hda: host protected area => 1 
> hda : 40011300 sectors (20486 MB) w/512KiB Cache, CHS=39693/16/63, UDMA(66) 
> 	hda: hda1 hda2 hda3 
> hdb: host protected area => 1 
> hdb : 60058656 sectors (30750 MB) w/2048KiB Cache, CHS=59582/16/63, UDMA(133) 
> 	hdb: hdb1 
> (hangs) 
 
I'm experiencing exactly the same as you: 2.5 won't 
continue past IDE. I've tried 2.5.65-ac3, 2.5.65-bk3 
and 2.5.65-mm4. All of them fail at the same point. 
I've tried using ACPI, APM, disabling preempt, TCQ, 
enabling SysRq support, but had no luck. 
 
The machine is a Pentium 4 2.0Gz, with a QDI 
PlatiniX 2D/533-A (i845E), 2 UDMA100 disks 
(Seagate ST380021A 80GB and IBM-DTLA-307030 
20GB), a Pioneer DVD-ROM and Sony CRX185E3). 
 
-- 
______________________________________________
http://www.linuxmail.org/
Now with e-mail forwarding for only US$5.95/yr

Powered by Outblaze
