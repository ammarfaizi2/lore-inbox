Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314469AbSEMVrI>; Mon, 13 May 2002 17:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314471AbSEMVrH>; Mon, 13 May 2002 17:47:07 -0400
Received: from air-2.osdl.org ([65.201.151.6]:32270 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S314469AbSEMVrH>;
	Mon, 13 May 2002 17:47:07 -0400
Date: Mon, 13 May 2002 14:45:44 -0700 (PDT)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc: <Phillip.Watts@nlynx.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Compact Flash bug
In-Reply-To: <Pine.GSO.3.96.1020513233800.26083k-100000@delta.ds2.pg.gda.pl>
Message-ID: <Pine.LNX.4.33L2.0205131445170.20629-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 May 2002, Maciej W. Rozycki wrote:

| On Mon, 13 May 2002 Phillip.Watts@nlynx.com wrote:
|
| > in 2.4.18  the routine which is determining if Compact Flash
| > has  Sandisk  spelled SunDisk.
|
|  That looks correct.  The company seems to have problems with identity:
|
| # hdparm -i /dev/hda
|
| /dev/hda:
|
|  Model=SunDisk SD35B-64, FwRev=vcb 1.45, SerialNo=MT311213748
|  Config={ HardSect NotMFM Fixed DTR>10Mbs nonMagnetic }
|  RawCHS=490/8/32, TrkSize=0, SectSize=576, ECCbytes=4
|  BuffType=DualPort, BuffSize=1kB, MaxMultSect=1, MultSect=1
|  CurCHS=490/8/32, CurSects=125440, LBA=yes, LBAsects=125440
|  IORDY=no
|  PIO modes: pio0 pio1
|  DMA modes:
|  AdvancedPM=no
|
| (that's a traditional 3.5" ATA flash device).

Yes, the company changed its name (at the urging of Sun IIRC).

-- 
~Randy

