Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289854AbSBEXSN>; Tue, 5 Feb 2002 18:18:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289855AbSBEXSD>; Tue, 5 Feb 2002 18:18:03 -0500
Received: from darkwing.uoregon.edu ([128.223.142.13]:45991 "EHLO
	darkwing.uoregon.edu") by vger.kernel.org with ESMTP
	id <S289854AbSBEXR7>; Tue, 5 Feb 2002 18:17:59 -0500
Date: Tue, 5 Feb 2002 15:17:58 -0800 (PST)
From: Joel Jaeggli <joelja@darkwing.uoregon.edu>
X-X-Sender: joelja@twin.uoregon.edu
To: Patrick Mochel <mochel@osdl.org>
cc: Andre Hedrick <andre@linuxdiskcert.org>,
        Russell King <rmk@arm.linux.org.uk>, Pavel Machek <pavel@suse.cz>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: driverfs support for motherboard devices
In-Reply-To: <Pine.LNX.4.33.0202051500510.25114-100000@segfault.osdlab.org>
Message-ID: <Pine.LNX.4.44.0202051514560.15039-100000@twin.uoregon.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Feb 2002, Patrick Mochel wrote:

<really big snip>

> 
> Case 3: Quad channel DEC Bridge
> 
> Ok, maybe I don't understand completely what you're talking about, Andre. 
> That's just a 4 channel IDE controller, that happens to be on the board? 
> So, it's looks the same as the last example.
> 
> Unless, I'm missing something, which is always likely.

actually it's two two channel controllers on one board...

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with 
idebus=xx
PIIX3: IDE controller on PCI bus 00 dev 39
PIIX3: chipset revision 0
PIIX3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:pio, hdd:pio
PDC20268: IDE controller on PCI bus 01 dev 10
PDC20268: chipset revision 2
PDC20268: not 100% native mode: will probe irqs later
PDC20268: ROM enabled at 0x000dc000
PDC20268: pci-config space interrupt mirror fixed.
PDC20268: (U)DMA Burst Bit ENABLED Primary MASTER Mode Secondary MASTER Mode.
    ide2: BM-DMA at 0xcc00-0xcc07, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xcc08-0xcc0f, BIOS settings: hdg:pio, hdh:pio
PDC20268: IDE controller on PCI bus 01 dev 08
PDC20268: chipset revision 2
PDC20268: not 100% native mode: will probe irqs later
PDC20268: ROM enabled at 0xeded0000
PDC20268: pci-config space interrupt mirror fixed.
PDC20268: (U)DMA Burst Bit ENABLED Primary MASTER Mode Secondary MASTER Mode.
    ide4: BM-DMA at 0xb800-0xb807, BIOS settings: hdi:pio, hdj:pio
    ide5: BM-DMA at 0xb808-0xb80f, BIOS settings: hdk:pio, hdl:pio

 
> 	-pat
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
-------------------------------------------------------------------------- 
Joel Jaeggli	      Academic User Services   joelja@darkwing.uoregon.edu    
--    PGP Key Fingerprint: 1DE9 8FCA 51FB 4195 B42A 9C32 A30D 121E      --
The accumulation of all powers, legislative, executive, and judiciary, in 
the same hands, whether of one, a few, or many, and whether hereditary, 
selfappointed, or elective, may justly be pronounced the very definition of
tyranny. - James Madison, Federalist Papers 47 -  Feb 1, 1788


