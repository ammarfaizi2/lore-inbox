Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266816AbSKOS1R>; Fri, 15 Nov 2002 13:27:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266817AbSKOS1R>; Fri, 15 Nov 2002 13:27:17 -0500
Received: from pc3-stoc3-4-cust114.midd.cable.ntl.com ([80.6.255.114]:56843
	"EHLO buzz.ichilton.co.uk") by vger.kernel.org with ESMTP
	id <S266816AbSKOS1Q>; Fri, 15 Nov 2002 13:27:16 -0500
Date: Fri, 15 Nov 2002 18:34:07 +0000
From: Ian Chilton <mailinglist@ichilton.co.uk>
To: Leopold Gouverneur <lgouv@pi.be>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Anyone use HPT366 + UDMA in Linux?
Message-ID: <20021115183407.GA32543@buzz.ichilton.co.uk>
Reply-To: Ian Chilton <ian@ichilton.co.uk>
References: <20021115123541.GA1889@buzz.ichilton.co.uk> <20021115162704.GA1059@gouv> <20021115162833.GA3717@buzz.ichilton.co.uk> <20021115173120.GA1152@gouv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021115173120.GA1152@gouv>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> I do it in the bios and I have also limited the drive to udma3 to be on
> the safe side (IBM has an utility for doing it )

I have just enabled HPT366 in the kernel but have not touched the bios
or drive. This is what hdparm gives:

[root@buzz:~/hdparm-5.2]# ./hdparm -i /dev/hda

/dev/hda:

 Model=IBM-DTLA-307045, FwRev=TX6OA5AA, SerialNo=YZDYZNM1366
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=40
 BuffType=DualPortCache, BuffSize=1916kB, MaxMultSect=16, MultSect=16
 CurCHS=65535/1/63, CurSects=4128705, LBA=yes, LBAsects=90069840
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 udma2 *udma3 udma4 udma5
 AdvancedPM=yes: disabled (255) WriteCache=enabled
 Drive conforms to: ATA/ATAPI-5 T13 1321D revision 1:  2 3 4 5


Does this mean it's already using udma3?


Thanks!

Ian

