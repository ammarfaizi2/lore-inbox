Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129528AbRBOUkb>; Thu, 15 Feb 2001 15:40:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129399AbRBOUkU>; Thu, 15 Feb 2001 15:40:20 -0500
Received: from m1smtpisp01.wanadoo.es ([62.36.220.61]:60642 "EHLO
	smtp.wanadoo.es") by vger.kernel.org with ESMTP id <S129183AbRBOUkR>;
	Thu, 15 Feb 2001 15:40:17 -0500
Date: Thu, 15 Feb 2001 21:43:30 +0100
From: drizzt.dourden@iname.com
To: linux-kernel@vger.kernel.org
Subject: [drizzt.dourden@iname.com: USB mass storage and USB message]
Message-ID: <20010215214330.B2094@menzoberrazan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Forwarded message from drizzt.dourden@iname.com -----

Date: Thu, 15 Feb 2001 21:40:28 +0100
From: drizzt.dourden@iname.com
To: linux-kernel@vger.kernel.org
Subject: USB mass storage and USB message

 I'm using the usb-uhci core with the 8200e storage drivers. I don't why
 the kernel logs the next message:
 
 uhci.c: root-hub INT complete: port1: 495 port2: 58a data: 4
 uhci.c: root-hub INT complete: port1: 495 port2: 58a data: 4
 uhci.c: root-hub INT complete: port1: 495 port2: 58a data: 4
 uhci.c: root-hub INT complete: port1: 495 port2: 58a data: 4
 uhci.c: root-hub INT complete: port1: 495 port2: 58a data: 4
 uhci.c: root-hub INT complete: port1: 495 port2: 58a data: 4
 (well a lot of them)
 
 The kernel is 2.4.1, the hardware a Celeron 566 with a VIA chipset, with the
 next cat /proc/pci
 
 This doesn't hapeng with the uhci module.
 
 I was testing  the cd writer with cdrecord at x1 speed( well, at least it can
 finish th simulation, because with the pre series, it can finished).

> PCI devices found:
>   Bus  0, device   0, function  0:
>     Host bridge: VIA Technologies, Inc. VT8601 [Apollo ProMedia] (rev 5).
>       Prefetchable 32 bit memory at 0xf8000000 [0xfbffffff].
>   Bus  0, device   1, function  0:
>     PCI bridge: VIA Technologies, Inc. VT8601 [Apollo ProMedia AGP] (rev 0).
>       Master Capable.  No bursts.  Min Gnt=12.
>   Bus  0, device   7, function  0:
>     ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 27).
>   Bus  0, device   7, function  1:
>     IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 6).
>       Master Capable.  Latency=64.  
>       I/O at 0x1420 [0x142f].
>   Bus  0, device   7, function  2:
>     USB Controller: VIA Technologies, Inc. UHCI USB (rev 14).
>       IRQ 11.
>       Master Capable.  Latency=64.  
>       I/O at 0x1400 [0x141f].
>   Bus  0, device   7, function  4:
>     ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 32).
>   Bus  0, device   7, function  5:
>     Multimedia audio controller: VIA Technologies, Inc. AC97 Audio Controller (rev 33).
>       IRQ 9.
>       I/O at 0x1000 [0x10ff].
>       I/O at 0x1434 [0x1437].
>       I/O at 0x1430 [0x1433].
>   Bus  0, device   9, function  0:
>     Communication controller: CONEXANT HSP MicroModem 56K (rev 1).
>       IRQ 11.
>       Master Capable.  Latency=64.  
>       Non-prefetchable 32 bit memory at 0xf4000000 [0xf400ffff].
>       I/O at 0x1438 [0x143f].
>   Bus  0, device  10, function  0:
>     CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controller (rev 1).
>       IRQ 9.
>       Master Capable.  Latency=168.  Min Gnt=192.Max Lat=5.
>       Non-prefetchable 32 bit memory at 0x10000000 [0x10000fff].
>   Bus  1, device   0, function  0:
>     VGA compatible controller: Trident Microsystems CyberBlade i1 (rev 106).
>       IRQ 9.
>       Master Capable.  Latency=64.  
>       Non-prefetchable 32 bit memory at 0xf5000000 [0xf57fffff].
>       Non-prefetchable 32 bit memory at 0xf4100000 [0xf411ffff].
>       Non-prefetchable 32 bit memory at 0xf4800000 [0xf4ffffff].
> 
Saludos
Carlos
PD: It's possible don't use the DUL list to blackmail SPAM sites. I usually
use my loca smtp, because a don't trust the smtp of my ISP ( and nethier in
Spain, swith doesn't it a option :( )
-- 
... Windows 95: Emulador de Spectrum para PII.
____________________________________________________________________________
Drizzt Do'Urden                Three rings for the Elves Kings under the Sky   
drizzt.dourden@iname.com       Seven for the Dwarf_lords in their  
                               hall of stone
                               Nine for the Mortal Men doomed to die 

----- End forwarded message -----

-- 
... Castillos no hay muchos, pero fantasmas por todas partes.
____________________________________________________________________________
Drizzt Do'Urden                Three rings for the Elves Kings under the Sky   
drizzt.dourden@iname.com       Seven for the Dwarf_lords in their  
                               hall of stone
                               Nine for the Mortal Men doomed to die 
