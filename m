Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132404AbRAMVPM>; Sat, 13 Jan 2001 16:15:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132405AbRAMVPD>; Sat, 13 Jan 2001 16:15:03 -0500
Received: from smtp-out2.bellatlantic.net ([199.45.40.144]:15008 "EHLO
	smtp-out2.bellatlantic.net") by vger.kernel.org with ESMTP
	id <S132404AbRAMVOw>; Sat, 13 Jan 2001 16:14:52 -0500
Date: Sat, 13 Jan 2001 16:12:13 -0500 (EST)
From: Werner Puschitz <werner.lx@verizon.net>
To: Andre Hedrick <andre@linux-ide.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: HP Pavilion 8290 HANGS on boot 2.4/2.4-test9
In-Reply-To: <Pine.LNX.4.10.10101131219340.3339-100000@master.linux-ide.org>
Message-ID: <Pine.LNX.4.21.0101131608320.1168-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 13 Jan 2001, Andre Hedrick wrote:

> On Sat, 13 Jan 2001, Werner wrote:
> 
> > The first and last message I get is: 
> > "Uncompressing Linux... OK, booting the kernel"
> 
> > # lspci
> > 00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge(rev 02)
> > 00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge(rev 02)
> > 00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
> > 00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
> 
> It is to early to be caught by a DMA engine fault, but you have one of the
> award winning systems that designed flaw in the hardware.  Only if the
> BIOS with INT13 calls are performing DMA stuff until the OS takes over
> could this be a player.
> 
> If you disable DMA in the BIOS does that help?

No, it didn't make any difference.

Is there a safe way to add debug information like simple string prints in
arch/i386/boot/compressed/head.s and in arch/i386/kernel/head.S
so that I can see at the console where the boot process hangs?

Thanks
Werner


> 
> Regards,
> 
> Andre Hedrick
> Linux ATA Development
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
