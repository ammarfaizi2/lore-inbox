Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266907AbSKOWot>; Fri, 15 Nov 2002 17:44:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266911AbSKOWot>; Fri, 15 Nov 2002 17:44:49 -0500
Received: from pc3-stoc3-4-cust114.midd.cable.ntl.com ([80.6.255.114]:46349
	"EHLO buzz.ichilton.co.uk") by vger.kernel.org with ESMTP
	id <S266907AbSKOWoq>; Fri, 15 Nov 2002 17:44:46 -0500
Date: Fri, 15 Nov 2002 22:51:37 +0000
From: Ian Chilton <mailinglist@ichilton.co.uk>
To: Miloslaw Smyk <thorgal@wfmh.org.pl>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Anyone use HPT366 + UDMA in Linux?
Message-ID: <20021115225137.GB6625@buzz.ichilton.co.uk>
Reply-To: Ian Chilton <ian@ichilton.co.uk>
References: <20021115123541.GA1889@buzz.ichilton.co.uk> <1037371184.19971.0.camel@irongate.swansea.linux.org.uk> <3DD571F1.3010502@wfmh.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DD571F1.3010502@wfmh.org.pl>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I booed 2.4.19 with HPT366 compiled in and i have not got it to fall
over yet :)

HPT366: onboard version of chipset, pin1=1 pin2=2
HPT366: IDE controller on PCI bus 00 dev 98
HPT366: chipset revision 1
HPT366: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xb400-0xb407, BIOS settings: hda:DMA, hdb:pio
HPT366: IDE controller on PCI bus 00 dev 99
HPT366: chipset revision 1
HPT366: not 100% native mode: will probe irqs later
    ide1: BM-DMA at 0xc000-0xc007, BIOS settings: hdc:pio, hdd:pio
hda: IBM-DTLA-307045, ATA DISK drive
ide0 at 0xac00-0xac07,0xb002 on irq 15
hda: 90069840 sectors (46116 MB) w/1916KiB Cache, CHS=89355/16/63,
UDMA(44)
Partition check:
 hda: [PTBL] [5606/255/63] hda1 hda3 hda4


[root@buzz:~]# hdparm-5.2/hdparm -i /dev/hda

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


Does this look normal?


Thanks!


Bye for Now,

Ian


                                \|||/ 
                                (o o)
 /---------------------------ooO-(_)-Ooo---------------------------\
 |  Ian Chilton                  Web: http://www.ichilton.co.uk    |
 |  E-Mail: ian@ichilton.co.uk   Backup: ian@linuxfromscratch.org  | 
 |-----------------------------------------------------------------|
 |            There are 10 types of people in the world:           |
 |        Those who understand binary, and those who don't.        |
 \-----------------------------------------------------------------/

