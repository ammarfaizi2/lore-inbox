Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315163AbSEDSpS>; Sat, 4 May 2002 14:45:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315166AbSEDSpR>; Sat, 4 May 2002 14:45:17 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52236 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315163AbSEDSpR>;
	Sat, 4 May 2002 14:45:17 -0400
Message-ID: <3CD42CB2.3557E21A@zip.com.au>
Date: Sat, 04 May 2002 11:47:14 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Barry K. Nathan" <barryn@pobox.com>
CC: Martin Dalecki <dalecki@evision-ventures.com>,
        Andre Hedrick <andre@linux-ide.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] hpt374 support
In-Reply-To: <no.id> from "Andrew Morton" at May 03, 2002 02:08:21 PM <20020504050112.1B44989BC9@cx518206-b.irvn1.occa.home.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Barry K. Nathan" wrote:
> 
> Andrew Morton wrote:
> > It has a problem with my 80 gigabyte Seagates - in UDMA133
> > mode, writes are inexplicably slow.  I manually set UDMA100
> > and it flies.
> 
> Hmmm... do 80GB Seagates even support UDMA133? I could be mistaken, but
> as an owner of one, I'm pretty sure the answer is "no". In fact, I think
> Maxtor's the only company making UDMA133 drives at this point in time.
> 

Doh.  I have enough disks in this thing to feed a small nation, and
I am easily confused.

/dev/hde:

 Model=Maxtor 4D080K4, FwRev=DAK019K0, SerialNo=D4H0GTPE
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
 BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=160086528
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4 
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5 udma6 
 Drive Supports : Reserved : ATA-1 ATA-2 ATA-3 ATA-4 ATA-5 ATA-6 
 Kernel Drive Geometry LogicalCHS=158816/255/63 PhysicalCHS=158816/255/63

-
