Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265201AbTAWOGJ>; Thu, 23 Jan 2003 09:06:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265238AbTAWOGJ>; Thu, 23 Jan 2003 09:06:09 -0500
Received: from f13.law15.hotmail.com ([64.4.23.13]:5135 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S265201AbTAWOGI>;
	Thu, 23 Jan 2003 09:06:08 -0500
X-Originating-IP: [12.222.214.124]
From: "Santosh Kumar Cheekatmalla" <pyara_indian@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Can any one please help me..
Date: Thu, 23 Jan 2003 09:09:20 -0500
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F130l8HvNuSNGDQ6on70000056f@hotmail.com>
X-OriginalArrivalTime: 23 Jan 2003 14:09:20.0853 (UTC) FILETIME=[064AD050:01C2C2E9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Everyone,

Can you please help me enable DMA on my machine.

I am new to linux , so can you be little elaborate in your reply
thanks..

I am using RED HAT Linux 7.3 ...

when i tried to set DMA on

# /sbin/hdparm -d 1 /hda/hdb

I get following message.

/dev/hdb:
setting using_dma to 1 (on)
HDIO_SET_DMA failed: Operation not permitted
using_dma    =  0 (off)

I am using Intelchipset motherborad, and Maxtor hard
drive

# /sbin/hdparm -iv /dev/hdb

/dev/hdb:
multcount    = 16 (on)
I/O support  =  3 (32-bit w/sync)
unmaskirq    =  0 (off)
using_dma    =  0 (off)
keepsettings =  0 (off)
nowerr       =  0 (off)
readonly     =  0 (off)
readahead    =  8 (on)
geometry     = 79656/16/63, sectors = 80293248, start
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

busstate     =  1 (on)


Can you please tell me what should i do to enable DMA
support.



Thanks
Santosh

_________________________________________________________________
The new MSN 8: advanced junk mail protection and 2 months FREE*  
http://join.msn.com/?page=features/junkmail

