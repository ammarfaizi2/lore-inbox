Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132333AbQK3AaV>; Wed, 29 Nov 2000 19:30:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132369AbQK3AaL>; Wed, 29 Nov 2000 19:30:11 -0500
Received: from smtp.lax.megapath.net ([216.34.237.2]:27666 "EHLO
        smtp.lax.megapath.net") by vger.kernel.org with ESMTP
        id <S132333AbQK3AaD>; Wed, 29 Nov 2000 19:30:03 -0500
Message-ID: <3A2597E7.1000100@megapathdsl.net>
Date: Wed, 29 Nov 2000 15:57:27 -0800
From: Miles Lane <miles@megapathdsl.net>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0-test12 i686; en-US; m18) Gecko/20001127
X-Accept-Language: en
MIME-Version: 1.0
To: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
CC: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: PCI bug? -- Re: USB doesn't work with 440MX chipset, PCI IRQ problem?
In-Reply-To: <20001130004123.B1327@arthur.ubicom.tudelft.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Mouw wrote:

> Hi all,
> 
> I got a new laptop with an Intel 440MX chipset, and USB doesn't work at
> all. I tried both the UHCI drivers, but none of them works. The drivers
> load OK, the USB hardware is detected, but as soon as I plug in a USB
> device, I get the following debug messages (this is with a Logitech USB
> mouse):

Erik,

This looks more like a PCI bug than a USB bug.

	Miles

> PCI: BIOS32 Service Directory structure at 0xc00f6bf0
> PCI: BIOS32 Service Directory entry at 0xfd762
> PCI: BIOS probe returned s=00 hw=01 ver=02.10 l=01
> PCI: PCI BIOS revision 2.10 entry at 0xfd987, last bus=1
> PCI: Using configuration type 1
> PCI: Probing PCI hardware
> PCI: IDE base address fixup for 00:07.1
> PCI: Scanning for ghost devices on bus 0
> PCI: IRQ init
> PCI: Interrupt Routing Table found at 0xc00fdf50
> 00:07 slot=00 0:00/def8 1:00/def8 2:00/def8 3:63/0800
> 00:09 slot=00 0:62/0800 1:00/def8 2:00/def8 3:00/def8
> 01:04 slot=00 0:60/0800 1:00/def8 2:00/def8 3:00/def8
> 01:08 slot=00 0:60/0800 1:00/def8 2:00/def8 3:00/def8
> 00:0a slot=00 0:60/0800 1:00/def8 2:00/def8 3:00/def8
> 00:02 slot=00 0:60/0800 1:00/def8 2:00/def8 3:00/def8
> 00:00 slot=00 0:00/def8 1:61/08e0 2:00/def8 3:00/def8
> PCI: Using IRQ router PIIX [8086/7198] at 00:07.0
> PCI: IRQ fixup
> 00:0a.0: ignoring bogus IRQ 255
> IRQ for 00:0a.0(0) via 00:0a.0 -> PIRQ 60, mask 0800, excl 0000 -> got IRQ 11
> PCI: Found IRQ 11 for device 00:0a.0
> PCI: The same IRQ used for device 00:02.0
> PCI: Allocating resources
> PCI: Resource 0000f800-0000f8ff (f=101, d=0, p=0)
> PCI: Resource 0000fc00-0000fc3f (f=101, d=0, p=0)
> PCI: Resource f8000000-fbffffff (f=200, d=0, p=0)
> PCI: Resource 0000fc90-0000fc9f (f=101, d=0, p=0)
> PCI: Resource 0000fca0-0000fcbf (f=101, d=0, p=0)
> PCI: Resource fedffc00-fedffcff (f=200, d=0, p=0)
> PCI: Resource 0000fc88-0000fc8f (f=109, d=0, p=0)
> PCI: Resource 0000f400-0000f4ff (f=101, d=0, p=0)
>   got res[10000000:10000fff] for resource 0 of Ricoh Co Ltd RL5c475
> PCI: Sorting device list...


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
