Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262584AbRE3EMM>; Wed, 30 May 2001 00:12:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262585AbRE3EMC>; Wed, 30 May 2001 00:12:02 -0400
Received: from zeus.kernel.org ([209.10.41.242]:50624 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S262584AbRE3ELs>;
	Wed, 30 May 2001 00:11:48 -0400
Date: Tue, 29 May 2001 21:11:27 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: linux-kernel@vger.kernel.org
Subject: Part I of Lameness...
Message-ID: <Pine.LNX.4.10.10105292045120.3596-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Since this was filtered the first time...

Andre Hedrick
Linux ATA Development

---------- Forwarded message ----------
Date: Mon, 28 May 2001 23:21:57 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: linux-kernel@vger.kernel.org
Subject: Lacking Performance my ARSE!


beetle:~ # hdparm -it /dev/hda

/dev/hda:

 Model=Maxtor 5T020H2, FwRev=TAH71DP0, SerialNo=T2J0HBRC
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
 BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=39062500
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 *udma4 udma5
 Drive Supports : Reserved : ATA-1 ATA-2 ATA-3 ATA-4 ATA-5 ATA-6
 Kernel Drive Geometry LogicalCHS=2431/255/63 PhysicalCHS=38752/16/63
 Timing buffered disk reads:  64 MB in  1.75 seconds = 36.57 MB/sec

fttk:~ # hdparm -it /dev/hda

/dev/hda:

 Model=IBM-DTLA-307020, FwRev=TX3OA50C, SerialNo=YHDYHT9S024
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=40
 BuffType=DualPortCache, BuffSize=1916kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=40188960
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5
 Drive Supports : Reserved : ATA-2 ATA-3 ATA-4 ATA-5
 Kernel Drive Geometry LogicalCHS=2501/255/63 PhysicalCHS=39870/16/63
 Timing buffered disk reads:  64 MB in  1.81 seconds = 35.36 MB/sec

athy:~ # hdparm -it /dev/hda

/dev/hda:

 Model=IBM-DTLA-307075, FwRev=TXAOA50C, SerialNo=YSDYSFA5874
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=40
 BuffType=DualPortCache, BuffSize=1916kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=150136560
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 *udma4 udma5
 Drive Supports : Reserved : ATA-2 ATA-3 ATA-4 ATA-5
 Kernel Drive Geometry LogicalCHS=9345/255/63 PhysicalCHS=148945/16/63
 Timing buffered disk reads:  64 MB in  1.78 seconds = 35.96 MB/sec


Just because you can not configure your kernel correctly of have junk for
hardware or any other lame reason like a distro that does not know what
dma is..........your problem not mine.

General bitching pisses me off, especially when you are dead wrong.

Regards,

Andre Hedrick
Linux ATA Development



