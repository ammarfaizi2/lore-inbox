Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288116AbSACBsY>; Wed, 2 Jan 2002 20:48:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288117AbSACBsO>; Wed, 2 Jan 2002 20:48:14 -0500
Received: from CPEdeadbeef0000.cpe.net.cable.rogers.com ([24.100.234.67]:1028
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id <S288116AbSACBsH>; Wed, 2 Jan 2002 20:48:07 -0500
Date: Wed, 2 Jan 2002 20:48:49 -0500 (EST)
From: Shawn Starr <spstarr@sh0n.net>
To: Greg KH <greg@kroah.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Strange USB issues...
In-Reply-To: <20020103010106.GO3054@kroah.com>
Message-ID: <Pine.LNX.4.40.0201022042460.161-100000@coredump.sh0n.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here's the mobo specs (im home now)...

AcerOpen AP53(AX) Motherboard:
AP53R3C0

One USB connector for 2 ports
Dallas DS12887A or DS12B887 RTC/Battery.

Motherboard supports PS/2 mouse
AT Keyboard
IrDA - Laptops, PDA, wireless stuff 115Kbs transfer rate at 1 meter.

PCI 2.1 Compliant - OFF because some other weirdo issues
USB Functionality:

NOTE from booklet: USB Shares INTD with PCI slot 4 therefore if you enable
USB only PCI cards that do no not require IRQ such as VGA can be installed
in SLOT 4. The PhP BIOS assigns an IRQ to VGA only if the VGA requests for
it...hmmmmm

Shawn.

On Wed, 2 Jan 2002, Greg KH wrote:

> On Wed, Jan 02, 2002 at 07:32:02PM -0500, Shawn Starr wrote:
> > I have a Pentium 200Mhz AMD Bios (home machine):
> >
> > USB 1.0 - 2 ports
>
> Ouch.  Watch out when using a hub.  They generally want 1.1 support.
>
> > The bios has 2 options:
> >
> > Enable USB controller and enable USB legacy stuff.
> >
> > If I turn on USB and boot to a Linux kernel WITH NO USB support compiled
> > in. I get:
> >
> > 1) Slow loading of kernel into memory on bootup
> > 2) AT keyboard timeout (?) errors and no activity with the keyboard
> > (shift lock/numlock/scroll lock). I  have to reboot to correct the
> > problem by disabling USB in the bios.
>
> Do you only have a USB keyboard, and no PS2 keyboard attached?
> Is the "Enable USB legacy" stuff enabled in your bios?
>
> Does things work better if you load the usb host controller for your
> machine?
>
> thanks,
>
> greg k-h
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>

