Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266649AbSKOTOc>; Fri, 15 Nov 2002 14:14:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266660AbSKOTOc>; Fri, 15 Nov 2002 14:14:32 -0500
Received: from adsl-67-114-192-42.dsl.pltn13.pacbell.net ([67.114.192.42]:49945
	"EHLO mx1.corp.rackable.com") by vger.kernel.org with ESMTP
	id <S266649AbSKOTOb>; Fri, 15 Nov 2002 14:14:31 -0500
Message-ID: <3DD547CD.8000307@rackable.com>
Date: Fri, 15 Nov 2002 11:15:25 -0800
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ian Chilton <ian@ichilton.co.uk>
CC: Leopold Gouverneur <lgouv@pi.be>, linux-kernel@vger.kernel.org
Subject: Re: Anyone use HPT366 + UDMA in Linux?
References: <20021115123541.GA1889@buzz.ichilton.co.uk> <20021115162704.GA1059@gouv> <20021115162833.GA3717@buzz.ichilton.co.uk> <20021115173120.GA1152@gouv> <20021115183407.GA32543@buzz.ichilton.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Nov 2002 19:21:21.0987 (UTC) FILETIME=[2E746930:01C28CDC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Chilton wrote:

>[root@buzz:~/hdparm-5.2]# ./hdparm -i /dev/hda
>
>/dev/hda:
>
> Model=IBM-DTLA-307045, FwRev=TX6OA5AA, SerialNo=YZDYZNM1366
> Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
> RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=40
> BuffType=DualPortCache, BuffSize=1916kB, MaxMultSect=16, MultSect=16
> CurCHS=65535/1/63, CurSects=4128705, LBA=yes, LBAsects=90069840
> IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
> PIO modes:  pio0 pio1 pio2 pio3 pio4
> DMA modes:  mdma0 mdma1 mdma2
> UDMA modes: udma0 udma1 udma2 *udma3 udma4 udma5
> AdvancedPM=yes: disabled (255) WriteCache=enabled
> Drive conforms to: ATA/ATAPI-5 T13 1321D revision 1:  2 3 4 5
>
>
>Does this mean it's already using udma3?
>
>
>  
>
   Yes.  hdparm -X 69 /dev/hda attempt to enable udma5, but may crash 
your system.  hdparm -X 67 /dev/hda should revert things.  Be carefull.

