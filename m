Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129545AbRBPR6L>; Fri, 16 Feb 2001 12:58:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129647AbRBPR5v>; Fri, 16 Feb 2001 12:57:51 -0500
Received: from jkd.penguinfarm.com ([12.32.79.69]:4480 "HELO
	jkd.penguinfarm.com") by vger.kernel.org with SMTP
	id <S129545AbRBPR5o>; Fri, 16 Feb 2001 12:57:44 -0500
Message-ID: <3A8D69E4.7DC6EED6@penguinfarm.com>
Date: Fri, 16 Feb 2001 12:56:52 -0500
From: Jason Straight <junfan@penguinfarm.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-ac15 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: (2.4.1-ac15) Wont set using_dma = 1 with hdparm
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With 2.2.18 I can set using_dma = 1 with hdparm on my Dell Inspiron
8000, I cannot with 2.4.1-ac15, so my HD works about 1/3 the speed with
2.4.1.

[root@jkd junfan]# hdparm -I /dev/hda

/dev/hda:

 Model=IHATHC_IKD32AB2- 0                      , FwRev=000E0A2D,
SerialNo=              11S59T
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=36477, SectSize=579, ECCbytes=4
 BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=?0?
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=39070080
 IORDY=yes, tPIO={min:400,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4 
 DMA modes: sdma0 sdma1 sdma2 mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3
*udma4


/dev/hda:
 setting using_dma to 1 (on)
 HDIO_SET_DMA failed: Operation not permitted
 using_dma    =  0 (off)

hdparm v3.9





-- 
Jason Straight
