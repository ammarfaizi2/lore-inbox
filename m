Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137007AbREKAHm>; Thu, 10 May 2001 20:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137004AbREKAHd>; Thu, 10 May 2001 20:07:33 -0400
Received: from srvr1.telecom.lt ([212.59.0.10]:56838 "EHLO mail.takas.lt")
	by vger.kernel.org with ESMTP id <S137002AbREKAGV>;
	Thu, 10 May 2001 20:06:21 -0400
Message-Id: <200105110006.CAA2309413@mail.takas.lt>
Date: Fri, 11 May 2001 01:49:03 +0200 (EET)
From: Nerijus Baliunas <nerijus@users.sourceforge.net>
Subject: { DriveReady SeekComplete }
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Disposition: INLINE
X-Mailer: Mahogany, 0.62 'Mars', compiled for Linux 2.2.19 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Just got a message:

hda: status error: status=0x50 { DriveReady SeekComplete }
hda: no DRQ after issuing MULTWRITE

hda is: QUANTUM FIREBALL CX10.2A, 9787MB w/418kB Cache, CHS=19885/16/63, UDMA(33)
Promise Ultra100 controller.

# hdparm /dev/hda

/dev/hda:
 multcount    =  8 (on)
 I/O support  =  3 (32-bit w/sync)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 1247/255/63, sectors = 20044080, start = 0

# hdparm -i /dev/hda

/dev/hda:

 Model=QUANTUM FIREBALL CX10.2A, FwRev=A3F.0B00, SerialNo=133918662657
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=32256, SectSize=21298, ECCbytes=4
 BuffType=DualPortCache, BuffSize=418kB, MaxMultSect=16, MultSect=8
 CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=20044080
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 *udma4
 AdvancedPM=no
 Drive Supports : ATA/ATAPI-4 T13 1153D revision 15 : ATA-1 ATA-2 ATA-3 ATA-4

2.2.19 with ide.2.2.19.03252001.patch.
Is something wrong with disk?

Regards,
Nerijus


