Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279818AbRKFQ6v>; Tue, 6 Nov 2001 11:58:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279812AbRKFQ6l>; Tue, 6 Nov 2001 11:58:41 -0500
Received: from adsl-pool54-170-109.chicago.il.ameritech.net ([64.109.170.109]:54400
	"EHLO turtle.mine.nu") by vger.kernel.org with ESMTP
	id <S279788AbRKFQ6d>; Tue, 6 Nov 2001 11:58:33 -0500
Date: Tue, 6 Nov 2001 10:50:44 -0600 (CST)
From: EricMarts <martser@turtle.mine.nu>
To: Jamie <darkshad@home.com>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>, <becker@webserv.gsfc.nasa.gov>,
        <jam@McQuil.com>, <hendriks@lanl.gov>, <jgolds@resilience.com>,
        <sdegler@degler.net>, <tulip-users@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>,
        Anders Hedborg <ahe@systemkoreograferna.com>
Subject: Re: Tulip Drivers Problem in 2.4.xx Kernel
In-Reply-To: <000b01c16662$81ccdf00$0300a8c0@theburbs.com>
Message-ID: <Pine.LNX.4.33.0111061043240.4321-100000@turtle.mine.nu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,

Donald Becker had given be some pointers.

I had problems on Windows 95 as well.

Here is what I came up with ... in terms of the system.

The old HP Pavalion uses a Intel motherboard and the
Intel bios (with HP logo etc..)

The PCI is only 2.0? compliant and the card is meant for
2.1 systems..

The on board sounnd and graphics was a pain. Not a like I could
just pull out the graphics or sound PCI card to free up 
resources.

Windows wanted to use PCI Steering -- I couldn't get it turned
off (IRQ sharing with the onboard video card..)
 
Long story short....

I was able to through a Netgear ISA card in assign the IRQ iomem
address via the DOS config tool (writes EEPROM?), and cfdisk, and install

RH 7.0

Does the PCI 2.0 - PCI 2.1 make a difference.

Do I have a chance here to get PCI card up and running?

Thanks,

Eric

  
On Mon, 5 Nov 2001, Jamie wrote:

> Ok Jeff thanks I will definately give that a try I have never tried the
> dec4x5 drivers I will see if it works
> for my NIC.
> 
> Thanks,
> 
> Jamie
> 
> ----- Original Message -----
> From: "Jeff Garzik" <jgarzik@mandrakesoft.com>
> To: "Jamie" <darkshad@home.com>
> Cc: <becker@webserv.gsfc.nasa.gov>; <jam@McQuil.com>; <hendriks@lanl.gov>;
> <jgolds@resilience.com>; <sdegler@degler.net>;
> <tulip-users@lists.sourceforge.net>; <linux-kernel@vger.kernel.org>; "Anders
> Hedborg" <ahe@systemkoreograferna.com>
> Sent: Monday, November 05, 2001 7:07 PM
> Subject: Re: Tulip Drivers Problem in 2.4.xx Kernel
> 
> 
> Currently there is a bug in 2.4.x-current tulip drivers that prevents
> 21041 from initializing correctly.  Until then you can use the 'de4x5'
> driver or download the latest stable version on the tulip web page:
> http://sourceforge.net/projects/tulip/
> --
> Jeff Garzik      | Only so many songs can be sung
> Building 1024    | with two lips, two lungs, and one tongue.
> MandrakeSoft     |         - nomeansno
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> _______________________________________________
> Tulip-users mailing list
> Tulip-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/tulip-users
> 

