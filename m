Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270778AbTGVCHb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 22:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270779AbTGVCHb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 22:07:31 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:32786
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S270778AbTGVCH3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 22:07:29 -0400
Date: Mon, 21 Jul 2003 19:14:54 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: dacin <dacin@hotpop.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Interrupt lost { .... }
In-Reply-To: <3F1C4AE8.9020906@hotpop.com>
Message-ID: <Pine.LNX.4.10.10307211913580.29430-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I am looking into this issue as my customer base who pays for fixes has
raised the issue.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

On Tue, 22 Jul 2003, dacin wrote:

> Ello Freinds
> 
> I am facing this problem with kernel 2.4.21 any suggestion.
> 
> hdb: dma_timer_expiry: dma status == 0x64
> hdb: lost interrupt
> hdb: dma_intr: bad DMA status (dma_stat=70)
> hdb: dma_intr: status=0x50 { DriveReady SeekComplete }
> 
> lspci -v | grep IDE
> 00:1f.1 IDE interface: Intel Corp. 82801BA IDE U100 (rev 12) (prog-if 80 
> [Master])
> 
> hdparm -I /dev/hdb
> /dev/hdb:
> 
> ATA device, with non-removable media
>     Model Number:       ST340823A                               
>     Serial Number:      7EF2AWX7            
>     Firmware Revision:  3.11    
> Standards:
>     Supported: 5 4 3 2
>     Likely used: 6
> Configuration:
>     Logical        max    current
>     cylinders    16383    16383
>     heads        16    16
>     sectors/track    63    63
>     --
>     CHS current addressable sectors:   16514064
>     LBA    user addressable sectors:   78165360
>     device size with M = 1024*1024:       38166 MBytes
>     device size with M = 1000*1000:       40020 MBytes (40 GB)
> Capabilities:
>     LBA, IORDY(can be disabled)
>     Queue depth: 1
>     Standby timer values: spec'd by Standard
>     R/W multiple sector transfer: Max = 16    Current = 16
>     Recommended acoustic management value: 128, current value: 128
>     DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5
>          Cycle time: min=120ns recommended=120ns
>     PIO: pio0 pio1 pio2 pio3 pio4
>          Cycle time: no flow control=240ns  IORDY flow control=120ns
> Commands/features:
>     Enabled    Supported:
>        *    READ BUFFER cmd
>        *    WRITE BUFFER cmd
>        *    Host Protected Area feature set
>        *    Look-ahead
>        *    Write cache
>        *    Power Management feature set
>         Security Mode feature set
>        *    SMART feature set
>        *    Automatic Acoustic Management feature set
>         SET MAX security extension
>        *    DOWNLOAD MICROCODE cmd
> Security:
>     Master password revision code = 65534
>         supported
>     not    enabled
>     not    locked
>         frozen
>     not    expired: security count
>     not    supported: enhanced erase
> HW reset results:
>     CBLID- above Vih
>     Device num = 1
> Checksum: correct
> 
> 
> 

