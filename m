Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319748AbSIMTHd>; Fri, 13 Sep 2002 15:07:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319749AbSIMTHd>; Fri, 13 Sep 2002 15:07:33 -0400
Received: from gw-ipex.infonet.cz ([212.71.128.102]:28663 "EHLO
	cimice.maxinet.cz") by vger.kernel.org with ESMTP
	id <S319748AbSIMTHc>; Fri, 13 Sep 2002 15:07:32 -0400
Message-ID: <001701c25b59$7756a820$4500a8c0@cybernet.cz>
From: "=?iso-8859-2?B?VmxhZGlt7XIgVPhlYmlja/0=?=" <druid@mail.cz>
To: <linux-kernel@vger.kernel.org>
Subject: ALi M1543 on P200
Date: Fri, 13 Sep 2002 21:12:13 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I cannot use DMA on my new disks. UDMA is enabled in BIOS in mode UDMA 2. It
doesn't work even in auto mode. ide0=dma doesn't work either. hdparm -d 1
/dev/hda causes "operation not permitted"

/dev/hda:

 Model=ST320413A, FwRev=3.39, SerialNo=7ED1R0TR
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs RotSpdTol>.5% }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=0
 BuffType=unknown, BuffSize=512kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=39102336
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  mdma0 mdma1 *mdma2
 UDMA modes: udma0 udma1 udma2 udma3 udma4 udma5
 AdvancedPM=no WriteCache=enabled
 Drive conforms to: device does not report version:  1 2 3 4 5

ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ALI15X3: IDE controller at PCI slot 00:0b.0
PCI: Assigned IRQ 10 for device 00:0b.0
ALI15X3: chipset revision 32
ALI15X3: not 100% native mode: will probe irqs later
ALI15X3: simplex device with no drives: DMA disabled
ide0: ALI15X3 Bus-Master DMA disabled (BIOS)
ALI15X3: simplex device with no drives: DMA disabled
ide1: ALI15X3 Bus-Master DMA disabled (BIOS)
hda: ST320413A, ATA DISK drive
hdb: WDC WD300BB-00AUA1, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: host protected area => 1
hda: 39102336 sectors (20020 MB) w/512KiB Cache, CHS=2434/255/63
hdb: host protected area => 1
hdb: 58633344 sectors (30020 MB) w/2048KiB Cache, CHS=3649/255/63


