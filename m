Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267203AbSK3BxY>; Fri, 29 Nov 2002 20:53:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267204AbSK3BxY>; Fri, 29 Nov 2002 20:53:24 -0500
Received: from nessie.weebeastie.net ([61.8.7.205]:20864 "EHLO
	theirongiant.weebeastie.net") by vger.kernel.org with ESMTP
	id <S267203AbSK3BxX>; Fri, 29 Nov 2002 20:53:23 -0500
Date: Sat, 30 Nov 2002 13:00:10 +1100
From: CaT <cat@zip.com.au>
To: linux-kernel@vger.kernel.org
Subject: 2.5.50 / ALSA: sound cutouts when playing from hd
Message-ID: <20021130020009.GB612@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I seem to be on a roll today. :)

Whenever I play an mp3 from HD I get sound cutouts. I can't really say
when exactly is happening but putting the mpg into ram by running

dd if=mp3 of=/dev/null 

until no disc activity occurs seems to solve the issues. The laptop is a
p3-700, 128meg free ram, 44 bytes of swap usage and the following is
reported by hdparm:

/dev/hda:
 multcount    = 16 (on)
 I/O support  =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    = 256 (on)
 geometry     = 2584/240/63, sectors = 39070080, start = 0
 busstate     =  1 (on)

/dev/hda:

 Model=TOSHIBA MK2016GAP, FwRev=U0.30 A, SerialNo=X0B70560T
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=46
 BuffType=unknown, BuffSize=0kB, MaxMultSect=16, MultSect=16
 CurCHS=17475/15/63, CurSects=16513875, LBA=yes, LBAsects=39070080
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4 
 DMA modes: sdma0 sdma1 sdma2 mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4 
 AdvancedPM=yes: unknown setting WriteCache=enabled
 Drive Supports : Reserved : ATA-1 ATA-2 ATA-3 ATA-4 ATA-5 

This does not happen with the CD-ROM drive and it's not happening now
with another mp3 (sigh...) but I have had this happen quite a few times
now.

As usual, if you want any more info, please holler.

-- 
        All people are equal,
        But some are more equal then others.
            - George W. Bush Jr, President of the United States
              September 21, 2002 (Abridged version of security speech)
