Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129406AbQLGALH>; Wed, 6 Dec 2000 19:11:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131455AbQLGAK6>; Wed, 6 Dec 2000 19:10:58 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:33802
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S129406AbQLGAKv>; Wed, 6 Dec 2000 19:10:51 -0500
Date: Wed, 6 Dec 2000 15:40:10 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: James Lamanna <jlamanna@its.caltech.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: Problems with PDC202xx driver
In-Reply-To: <3A2EB765.62FEF645@its.caltech.edu>
Message-ID: <Pine.LNX.4.10.10012061522510.23490-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Dec 2000, James Lamanna wrote:

> Here is an excerpt from /proc/pci:
> 
> Bus  0, device  11, function  0:
>     RAID bus controller: Promise Technology, Inc. 20267 (rev 2).
>       IRQ 10.
>       Master Capable.  Latency=32.
>       I/O at 0x9400 [0x9407].
>       I/O at 0x9000 [0x9003].
>       I/O at 0x8800 [0x8807].
>       I/O at 0x8400 [0x8403].
>       I/O at 0x8000 [0x803f].
>       Non-prefetchable 32 bit memory at 0xd5000000 [0xd501ffff].
>   Bus  0, device  17, function  0:
>     Unknown mass storage controller: Promise Technology, Inc. 20265 (rev 2).
>       IRQ 10.
>       Master Capable.  Latency=32.
>       I/O at 0x7800 [0x7807].
>       I/O at 0x7400 [0x7403].
>       I/O at 0x7000 [0x7007].
>       I/O at 0x6800 [0x6803].
>       I/O at 0x6400 [0x643f].
>       Non-prefetchable 32 bit memory at 0xd4800000 [0xd481ffff].

No each device reports itself differently here.
Bus  0, device  11, function  0: == 20267
Bus  0, device  17, function  0: == 20265

You bought a Fasttrak 100 and your mainboard came with an Ultra 100

> 
> Is there a plan to support the Fasttrak BIOS core at some point (I hope..)
> So I guess I'm stuck with loading their proprietary module whenever I want 
> to use the drive....

Yep, until they realize that their simple IP is nothing, and want to
export the raid calls to the Linux Raid Engine, you are "stuck".

> But thanks for the clarification.

Cheers,

Andre Hedrick
CTO Timpanogas Research Group
EVP Linux Development, TRG
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
