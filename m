Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283938AbRLWOlR>; Sun, 23 Dec 2001 09:41:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283782AbRLWOlJ>; Sun, 23 Dec 2001 09:41:09 -0500
Received: from zeus.city.tvnet.hu ([195.38.100.182]:49288 "EHLO
	zeus.city.tvnet.hu") by vger.kernel.org with ESMTP
	id <S283938AbRLWOlA>; Sun, 23 Dec 2001 09:41:00 -0500
Subject: via ide issue info
From: Sipos Ferenc <sferi@dumballah.tvnet.hu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 23 Dec 2001 15:44:47 +0100
Message-Id: <1009118687.1438.14.camel@zeus.city.tvnet.hu>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Ok, here are the requested infos:

----------VIA BusMastering IDE Configuration----------------
Driver Version:                     3.29
South Bridge:                       VIA vt82c686a
Revision:                           ISA 0x14 IDE 0x6
Highest DMA rate:                   UDMA66
BM-DMA base:                        0xffa0
PCI clock:                          33MHz
Master Read  Cycle IRDY:            0ws
Master Write Cycle IRDY:            0ws
BM IDE Status Register Read Retry:  yes
Max DRDY Pulse Width:               No limit
-----------------------Primary IDE-------Secondary IDE------
Read DMA FIFO flush:          yes                 yes
End Sector FIFO flush:         no                  no
Prefetch Buffer:              yes                 yes
Post Write Buffer:            yes                 yes
Enabled:                       no                 yes
Simplex only:                  no                  no
Cable Type:                   40w                 40w
-------------------drive0----drive1----drive2----drive3-----
Transfer Mode:        PIO       PIO      UDMA      UDMA
Address Setup:      120ns     120ns      30ns      30ns
Cmd Active:         480ns     480ns      90ns      90ns
Cmd Recovery:       480ns     480ns      30ns      30ns
Data Active:        330ns     330ns      90ns      90ns
Data Recovery:      270ns     270ns      30ns      30ns
Cycle Time:         600ns     600ns      45ns      60ns
Transfer Rate:    3.3MB/s   3.3MB/s  44.0MB/s  33.0MB/s

/dev/hdc:

 Model=WDC WD136AA, FwRev=80.10A80, SerialNo=WD-WM6780207230
 Config={ HardSect NotMFM HdSw>15uSec SpinMotCtl Fixed DTR>5Mbs
FmtGapReq }
 RawCHS=16383/16/63, TrkSize=57600, SectSize=600, ECCbytes=40
 BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=off
 CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=26564832
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4 
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 
 AdvancedPM=no
 Drive Supports : Reserved : ATA-1 ATA-2 ATA-3 ATA-4 

/dev/hdd:

 Model=Pioneer DVD-ROM ATAPIModel DVD-104S 020, FwRev=E2.06, SerialNo=
 Config={ Fixed Removeable DTR<=5Mbs DTR>10Mbs nonMagnetic }
 RawCHS=0/0/0, TrkSize=0, SectSize=0, ECCbytes=0
 BuffType=13395, BuffSize=64kB, MaxMultSect=0
 (maybe): CurCHS=0/0/0, CurSects=0, LBA=yes, LBAsects=0
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4 
 DMA modes: sdma0 sdma1 sdma2 mdma0 mdma1 mdma2 udma0 udma1 *udma2 
 AdvancedPM=no
 Drive Supports : Reserved : ATA-1 ATA-2 ATA-3 ATA-4 

As I mentioned, the bios recognizes my hd as an udma4 capable device, so
it's not a cable issue, I think, the driver won't detect properly the
cables. By the way, it would be good to have driver parameters, that
help setting the prefetch buffer and post write buffer on, because on
the secondary channel, it's off by default, I'm using powertweak to
enable them. Thx.

Paco


