Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262875AbSLOVrF>; Sun, 15 Dec 2002 16:47:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262924AbSLOVrE>; Sun, 15 Dec 2002 16:47:04 -0500
Received: from smtp-02.inode.at ([62.99.194.4]:6052 "EHLO smtp.inode.at")
	by vger.kernel.org with ESMTP id <S262875AbSLOVrE> convert rfc822-to-8bit;
	Sun, 15 Dec 2002 16:47:04 -0500
Content-Type: text/plain; charset=US-ASCII
From: Patrick Petermair <black666@inode.at>
Reply-To: black666@inode.at
To: linux-kernel@vger.kernel.org
Subject: Re: IDE-CD and VT8235 issue!!!
Date: Sun, 15 Dec 2002 22:56:25 +0100
User-Agent: KMail/1.4.3
References: <3DFB7B21.7040004@tin.it> <3DFBC4F3.2070603@tin.it> <20021215215057.A12689@ucw.cz>
In-Reply-To: <20021215215057.A12689@ucw.cz>
Cc: Vojtech Pavlik <vojtech@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212152256.25266.black666@inode.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik:

> You're not alone with this problem. I suspect some fishy stuff in the
> vt8235, because the driver programs it exactly the same as vt8233a,
> but while the vt8233a doesn't seem to have problems with DVDs and
> CDs, the vt8235 fails for many people.

Thanks for the info ... like I expected ...

> Can you send me 'hdparm -i' of the drive?

starbase:/# hdparm -i /dev/hdc

/dev/hdc:

 Model=TOSHIBA DVD-ROM SD-M1302, FwRev=1006, SerialNo=X900304741
 Config={ Fixed Removeable DTR<=5Mbs DTR>10Mbs nonMagnetic }
 RawCHS=0/0/0, TrkSize=0, SectSize=0, ECCbytes=0
 BuffType=unknown, BuffSize=256kB, MaxMultSect=0
 (maybe): CurCHS=0/0/0, CurSects=0, LBA=yes, LBAsects=0
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4 
 DMA modes:  sdma0 sdma1 sdma2 mdma0 mdma1 mdma2 
 UDMA modes: udma0 udma1 *udma2 
 AdvancedPM=no

Thanks for all your effort here. It's great to see such a good 
community.

Patrick

