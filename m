Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262602AbSLOVGJ>; Sun, 15 Dec 2002 16:06:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262620AbSLOVGI>; Sun, 15 Dec 2002 16:06:08 -0500
Received: from vsmtp3.tin.it ([212.216.176.223]:45191 "EHLO smtp3.cp.tin.it")
	by vger.kernel.org with ESMTP id <S262602AbSLOVGH>;
	Sun, 15 Dec 2002 16:06:07 -0500
Message-ID: <3DFCF116.6080109@tin.it>
Date: Sun, 15 Dec 2002 22:16:06 +0100
From: AnonimoVeneziano <voloterreno@tin.it>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021210 Debian/1.2.1-3
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: IDE-CD and VT8235 issue!!!
References: <3DFB7B21.7040004@tin.it> <200212142019.14449.black666@inode.at> <3DFBC4F3.2070603@tin.it> <20021215215057.A12689@ucw.cz>
In-Reply-To: <20021215215057.A12689@ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:

>On Sun, Dec 15, 2002 at 12:55:31AM +0100, AnonimoVeneziano wrote:
>  
>
>>Patrick Petermair wrote:
>>
>>    
>>
>>>Hi!
>>>
>>>Same problem here. I have addressed this issue several times...so far no 
>>>solution.
>>>
>>>My specs:
>>>MSI KT3 Ultra2 (VT8235)
>>>TOSHIBA DVD-ROM SD-M1302
>>>YAMAHA CRW8424E
>>>
>>>Kernel 2.4.19:
>>>The one I'm currently using. It doesn't detect the VT8235 and therefore 
>>>I have no dma. But I can access/mount my DVD without a problem.
>>>
>>>Kernel 2.4.20:
>>>Detects the VT8235 at boot but hangs with my DVD Rom (hdc) --> doesn't 
>>>boot. I have posted my problem here an Alan Cox suggested that I should 
>>>try the -ac tree.
>>>
>>>Kernel 2.4.20-ac2:
>>>Some improvements - It detects the VT8235 at boot, also my DVD and CDRW. 
>>>It boots fine and I have DMA on all my discs. But as soon as I try to 
>>>mount a CD/DVD (mount /cdrom) the system hangs and I get this:
>>>      
>>>
> 
>  
>
>>Please, anyone help us, I can't live with a 6 MB HD bandwith!!!:-D
>>    
>>
>
>You're not alone with this problem. I suspect some fishy stuff in the
>vt8235, because the driver programs it exactly the same as vt8233a, but
>while the vt8233a doesn't seem to have problems with DVDs and CDs, the
>vt8235 fails for many people.
>
>It might be some new DVD drive, though.
>
>Can you send me 'hdparm -i' of the drive?
>
>I'll try to make a patch to circumvent the problem ...
>
>Thanks.
>
>  
>
Here the hdparm -i of my first ATAPI drive.

I don't know if my Cd-recorder have the same problem, It have never 
tried to initialize it.

Byez


/dev/hdc:

 Model=_NEC DV-5800A, FwRev=1.90, SerialNo=
 Config={ Removeable DTR<=5Mbs DTR>10Mbs nonMagnetic }
 RawCHS=0/0/0, TrkSize=0, SectSize=0, ECCbytes=0
 BuffType=unknown, BuffSize=0kB, MaxMultSect=0
 (maybe): CurCHS=0/0/0, CurSects=0, LBA=yes, LBAsects=0
 IORDY=yes, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  sdma0 sdma1 sdma2 mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 *udma2
 AdvancedPM=no


