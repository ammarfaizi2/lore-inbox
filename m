Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318932AbSH1TEr>; Wed, 28 Aug 2002 15:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318933AbSH1TEr>; Wed, 28 Aug 2002 15:04:47 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:23720 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S318932AbSH1TEq>;
	Wed, 28 Aug 2002 15:04:46 -0400
Date: Wed, 28 Aug 2002 21:09:00 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: "Fr?d?ric L. W. Meunier" <0@pervalidus.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ECS K7S5A: IDE performance
Message-ID: <20020828210900.A20650@ucw.cz>
References: <Pine.LNX.4.44.0208281552190.213-100000@pervalidus.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0208281552190.213-100000@pervalidus.dyndns.org>; from 0@pervalidus.net on Wed, Aug 28, 2002 at 04:00:26PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2002 at 04:00:26PM -0300, Fr?d?ric L. W. Meunier wrote:

> I have an ECS K7S5A 3.1A. It works fine with 2.4.19. No
> corruption. Now I tested it with hdparm and:
> 
> hdparm -tT /dev/hda
> 
> /dev/hda:
>  Timing buffer-cache reads:   128 MB in  0.79 seconds =162.03 MB/sec
>  Timing buffered disk reads:  64 MB in  1.68 seconds = 38.10 MB/sec
> 
> Only 38.10 ?

That's quite a LOT for an IDE drive.

> hdparm -i /dev/hda
> 
> /dev/hda:
> 
>  Model=MAXTOR 6L060J3, FwRev=A93.0500, SerialNo=663200252994
>  Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
>  RawCHS=16383/16/63, TrkSize=32256, SectSize=21298, ECCbytes=4
>  BuffType=DualPortCache, BuffSize=1819kB, MaxMultSect=16, MultSect=off
>  CurCHS=4047/16/255, CurSects=16511760, LBA=yes, LBAsects=117266688
>  IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
>  PIO modes:  pio0 pio1 pio2 pio3 pio4
>  DMA modes:  mdma0 mdma1 mdma2
>  UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5 udma6
>  AdvancedPM=no WriteCache=enabled
>  Drive conforms to: ATA/ATAPI-5 T13 1321D revision 1:  1 2 3 4 5
> 
> SIS5513: IDE controller on PCI bus 00 dev 15
> SIS5513: chipset revision 208
> SIS5513: not 100% native mode: will probe irqs later
> SiS735    ATA 100 controller
>     ide0: BM-DMA at 0xff00-0xff07, BIOS settings: hda:DMA, hdb:DMA
>     ide1: BM-DMA at 0xff08-0xff0f, BIOS settings: hdc:DMA, hdd:DMA
> hda: MAXTOR 6L060J3, ATA DISK drive
> 
> hda: 117266688 sectors (60041 MB) w/1819KiB Cache, CHS=7299/255/63, UDMA(100)
> 
> -- 
> 0@pervalidus.{net, {dyndns.}org} ICQ: 156552241
> Tel: +55 (21) 2717-2399 (with voice mailbox)
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Vojtech Pavlik
SuSE Labs
