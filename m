Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129868AbRANDxf>; Sat, 13 Jan 2001 22:53:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130645AbRANDx0>; Sat, 13 Jan 2001 22:53:26 -0500
Received: from technetium.cix.co.uk ([194.153.0.53]:58084 "EHLO
	technetium.cix.co.uk") by vger.kernel.org with ESMTP
	id <S129868AbRANDxK>; Sat, 13 Jan 2001 22:53:10 -0500
X-Envelope-From: mpsons@cix.compulink.co.uk
Date: Sun, 14 Jan 2001 03:53 +0000 (GMT)
From: mpsons@cix.compulink.co.uk (Tony Parsons)
Subject: Re: ide.2.4.1-p3.01112001.patch
To: linux-kernel@vger.kernel.org
Cc: mpsons@cix.compulink.co.uk
Reply-To: mpsons@cix.compulink.co.uk
Message-Id: <memo.318705@cix.compulink.co.uk>
X-Ameol-Version: 2.52.2000, Windows NT 4.0 build 1381 (Service Pack 6)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <87bstbpefi.fsf@pelerin.serpentine.com>
In article <87bstbpefi.fsf@pelerin.serpentine.com>, bos@serpentine.com 
(Bryan O'Sullivan) wrote:

>   /dev/ide/host0/bus0/target0/lun0:hda: dma_intr: status=0x51 { 
> DriveReady SeekComplete Error }   hda: dma_intr: error=0x84 { 
> DriveStatusError BadCRC }   hda: dma_intr: status=0x51 { DriveReady 
> SeekComplete Error }   hda: dma_intr: error=0x84 { DriveStatusError 
> BadCRC }   hda: dma_intr: status=0x51 { DriveReady SeekComplete Error } 
...
>   00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 0305 (rev 
> 02)
>   00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device 8305
>   00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] 
> (rev 22)
>   00:04.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] 
> (rev 10)
>   00:04.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 10)
>   00:04.3 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 10)
>   00:04.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super 
> ACPI] (rev 30)
It's not an Abit KT7 or similar is it?
I was just helping my dad upgrade a machine based with one of those to 2.4 
today and until we turned off Generic PCI bus-master DMA Support and the 
VIA82CXXX drivers we kept getting the same messages the second the system 
booted up. 
It was rather annoying, as I'm not sure if it was because of this or 
something else, but we ended up with some minor disk corruption mainly 
around /usr/src/linux where I made the mistake of doing a make mrproper 
while it was like this. Went back to 2.2 temporarily and it was fine.
Can dig out/try anything on request.

TonyP
mpsons@cix.compulink.co.uk

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
