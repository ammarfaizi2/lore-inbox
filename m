Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314783AbSESTDh>; Sun, 19 May 2002 15:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314838AbSESTDg>; Sun, 19 May 2002 15:03:36 -0400
Received: from grande.dcc.unicamp.br ([143.106.7.8]:50677 "EHLO
	grande.dcc.unicamp.br") by vger.kernel.org with ESMTP
	id <S314783AbSESTDf>; Sun, 19 May 2002 15:03:35 -0400
Date: Sun, 19 May 2002 16:03:25 -0300 (EST)
From: ULISSES FURQUIM FREIRE DA SILVA <ra993482@ic.unicamp.br>
To: Lionel Bouton <Lionel.Bouton@inet6.fr>
cc: linux-kernel@vger.kernel.org
Subject: Re: Hardware, IDE or ext3 problem?
In-Reply-To: <20020519201359.A17179@bouton.inet6-interne.fr>
Message-ID: <Pine.GSO.4.10.10205191549330.16639-100000@tigre.dcc.unicamp.br>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> What's your exact chipset ?

00:00.0 Host bridge: Silicon Integrated Systems [SiS] 620 Host (rev 03)
00:00.1 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0)

> The IDE code should lower the DMA mode by itself when it sees BadCRC, what's
> the output of `hdparm -i /dev/hda` after these errors show up ?

 # hdparm -i /dev/hda

/dev/hda:

 Model=QUANTUM FIREBALLlct15 20, FwRev=A01.0F00, SerialNo=313061620944
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=32256, SectSize=21298, ECCbytes=4
 BuffType=DualPortCache, BuffSize=418kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=39876480
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4 
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 
 AdvancedPM=no WriteCache=enabled
 Drive Supports : ATA/ATAPI-5 T13 1321D revision 1 : ATA-1 ATA-2 ATA-3
ATA-4 ATA-5 

	I noticed that I have to enable DMA for my CD-ROM(/dev/hdb), cause
it's disabled on boot.

-- Ulisses

