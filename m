Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265543AbTAWSFG>; Thu, 23 Jan 2003 13:05:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265567AbTAWSFG>; Thu, 23 Jan 2003 13:05:06 -0500
Received: from f123.law15.hotmail.com ([64.4.23.123]:33801 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S265543AbTAWSFE>;
	Thu, 23 Jan 2003 13:05:04 -0500
X-Originating-IP: [128.163.162.174]
From: "Santosh Kumar Cheekatmalla" <pyara_indian@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: HDIO_SET_DMA failed: Operation not permitted 
Date: Thu, 23 Jan 2003 13:14:09 -0500
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F123czi9yzu23LiC1h100002733@hotmail.com>
X-OriginalArrivalTime: 23 Jan 2003 18:14:10.0194 (UTC) FILETIME=[39D25F20:01C2C30B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Everyone,

I am using RED HAT Linux 7.3 ...

when i tried to set DMA on

# /sbin/hdparm -d 1 /hda/hdb

I get following message.

/dev/hdb:
setting using_dma to 1 (on)
HDIO_SET_DMA failed: Operation not permitted
using_dma    =  0 (off)

I am using Intelchipset motherborad, and Maxtor hard
drive

Can you please help me enable DMA on my machine.

I am new to linux , so can you be little elaborate in your reply
thanks..

   Another doubt my hard drive is detected as /dev/hdb instead of /dev/hda..
does that make any difference.. Please help.. why is it so.. ?

I just made sure that both my Intel mother borad and
Maxtor hard drive support the DMA. But iam unable to switch it on.

the message in /var/log/messages

Jan 21 18:19:29 backend01 kernel: ide0: unexpected interrupt, status=0x58, 
count=1

and

dmesg gives the following result

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PCI_IDE: unknown IDE controller on PCI bus 00 device f9, VID=8086, DID=24cb
PCI: Device 00:1f.1 not available because of resource collisions
PCI_IDE: (ide_setup_pci_device:) Could not enable device.
hdb: C/H/S=0/0/0 from BIOS ignored
hdb: Maxtor 2F040J0, ATA DISK drive
hdc: CDU5211, ATAPI CD/DVD-ROM drive

# /sbin/hdparm -iv /dev/hdb

/dev/hdb:
multcount    = 16 (on)
I/O support  =  3 (32-bit w/sync)
unmaskirq    =  0 (off)
using_dma    =  0 (off)
keepsettings =  0 (off)
nowerr       =  0 (off)
readonly     =  0 (off)
readahead    =  8 (on)
geometry     = 79656/16/63, sectors = 80293248, start
= 0

Model=Maxtor 2F040J0, FwRev=VAM51JJ0,
SerialNo=F12WD7TE
Config={ Fixed }
RawCHS=16383/16/63, TrkSize=0, SectSize=0,ECCbytes=57
BuffType=DualPortCache, BuffSize=2048kB,MaxMultSect=16, MultSect=16
CurCHS=16383/16/63, CurSects=16514064, LBA=yes,LBAsects=80293248
IORDY=on/off, tPIO={min:120,w/IORDY:120},tDMA={min:120,rec:120}
PIO modes: pio0 pio1 pio2 pio3 pio4
DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3udma4 *udma5 udma6
AdvancedPM=yes: disabled (255) WriteCache=enabled
Drive Supports : ataATA-1 ATA-2 ATA-3 ATA-4 ATA-5ATA-6 ATA-7

busstate     =  1 (on)


Can you please tell me what should i do to enable DMA
support.



Thanks
Santosh


_________________________________________________________________
MSN 8 helps eliminate e-mail viruses. Get 2 months FREE*.  
http://join.msn.com/?page=features/virus

