Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132674AbRDGQQP>; Sat, 7 Apr 2001 12:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132675AbRDGQQE>; Sat, 7 Apr 2001 12:16:04 -0400
Received: from front6m.grolier.fr ([195.36.216.56]:17120 "EHLO
	front6m.grolier.fr") by vger.kernel.org with ESMTP
	id <S132674AbRDGQP4> convert rfc822-to-8bit; Sat, 7 Apr 2001 12:15:56 -0400
Date: Sat, 7 Apr 2001 15:01:57 +0200 (CEST)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@club-internet.fr>
To: Michael Reinelt <reinelt@eunet.at>
cc: Brian Gerst <bgerst@didntduck.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Multi-function PCI devices
In-Reply-To: <3ACF1E35.F11E9673@eunet.at>
Message-ID: <Pine.LNX.4.10.10104071445030.1530-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 7 Apr 2001, Michael Reinelt wrote:

> Brian Gerst wrote:
> > 
> > Gérard Roudier wrote:
> > >
> > > On Sat, 7 Apr 2001, Michael Reinelt wrote:
> > >
> > > > The card shows up on the PCI bus as one device. For the card provides
> > > > both serial and parallel ports, it will be driven by two subsystems, the
> > > > serial and the parallel driver.
> > >
> > > Given your description, this board is certainly not a multi-fonction PCI
> > > device. Multi-function PCI devices provide separate resources for each
> > > function in a way that allows each function to be driven by separate
> > > software drivers. A single function PCI device that provides several
> > > functionnalities commonly handled by separate sub-systems, is nothing but
> > > a bag of shit we should not want to support in any O/S in my opinion.
> > > Let me claim that ingenieers that want O/Ses to support such hardware are
> > > either morons or bastards.
> > 
> > Unfortunately, Windoze supports this configuration, and that's enough
> > for most hardware designers.  This is also an issue with the joystick
> > ports on many PCI sound cards.  We're not in a position to get up on the
> > soap box and decree this hardware "a bag of shit" though, yet.
> 
> How about other Multi-I/O-Cards? I think these 2S/1P (or 2P/1S or 2P/2S)
> cards are very common. At least they have been as ISA (PnP) cards. I

Please donnot compare ISA and PCI. ISA wasted trillions of user hours
because of its inability to allow automatic configuration.
PCI fixed this by assigning configuration space to each device.
These 'a la shitty ISA' Multi-I/O boards just kill the advantage of PCI by
moving again ISA burden to PCI. In year 2001, they stink a lot.

> don't know, but I'm shure there are a lot of these out there in the
> field. As mainboards without any ISA slots get more common every day,
> there will be even more PCI multi-I/O-cards (apart from everyone running
> to USB :-)

PCI multi I/O boards _shall_ provide a separate function for each kind of
IO. Those that donnot are kind of PCI messy IO boards.

> I needed another serial and parallel port, and I've got one of these
> mainboards (Asus A7V). So I had to buy such a PCI card. Nowadays you
> can't even ask for a specific hardware manufacturer, everything the guy
> in the shop knows is "yes, it's PCI, and yes, it has two serial and one
> parallel port". 
> 
> As these cards are very cheap, you can't expect very much from them (I

Cheap for whom?
What happens is that other companies or people that want to to support
such hardware must do additionnal efforts that could have been avoided if
the board had been correctly designed.

> don't even think there are any expensive ones out there). NetMos does
> not produce this cards, they produce _chips_ for such cards. So there
> are probably a lot of cards out there with these NetMos chips.
> 
> Again, how about other cards? Are there any PCI Multi-I/O-cards out
> there, which are supported by linux? I'd be interested in how the driver
> looks like....

I donnot know and will never know. I only use hardware that does not look
too shitty to me. Time is too much important for me to waste even seconds
with dubious hardware. :)

  Gérard.

