Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132655AbRDGOEZ>; Sat, 7 Apr 2001 10:04:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132653AbRDGOEO>; Sat, 7 Apr 2001 10:04:14 -0400
Received: from endjinn.austria.eu.net ([193.81.13.2]:21965 "EHLO
	relay2.austria.eu.net") by vger.kernel.org with ESMTP
	id <S132652AbRDGOEB>; Sat, 7 Apr 2001 10:04:01 -0400
Message-ID: <3ACF1E35.F11E9673@eunet.at>
Date: Sat, 07 Apr 2001 16:03:33 +0200
From: Michael Reinelt <reinelt@eunet.at>
Organization: netWorks
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Brian Gerst <bgerst@didntduck.org>
CC: =?iso-8859-1?Q?G=E9rard?= Roudier <groudier@club-internet.fr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Multi-function PCI devices
In-Reply-To: <Pine.LNX.4.10.10104071043360.1085-100000@linux.local> <3ACF1525.88BCA48B@didntduck.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-AntiVirus: OK (checked by AntiVir Version 6.6.0.12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Gerst wrote:
> 
> Gérard Roudier wrote:
> >
> > On Sat, 7 Apr 2001, Michael Reinelt wrote:
> >
> > > The card shows up on the PCI bus as one device. For the card provides
> > > both serial and parallel ports, it will be driven by two subsystems, the
> > > serial and the parallel driver.
> >
> > Given your description, this board is certainly not a multi-fonction PCI
> > device. Multi-function PCI devices provide separate resources for each
> > function in a way that allows each function to be driven by separate
> > software drivers. A single function PCI device that provides several
> > functionnalities commonly handled by separate sub-systems, is nothing but
> > a bag of shit we should not want to support in any O/S in my opinion.
> > Let me claim that ingenieers that want O/Ses to support such hardware are
> > either morons or bastards.
> 
> Unfortunately, Windoze supports this configuration, and that's enough
> for most hardware designers.  This is also an issue with the joystick
> ports on many PCI sound cards.  We're not in a position to get up on the
> soap box and decree this hardware "a bag of shit" though, yet.

How about other Multi-I/O-Cards? I think these 2S/1P (or 2P/1S or 2P/2S)
cards are very common. At least they have been as ISA (PnP) cards. I
don't know, but I'm shure there are a lot of these out there in the
field. As mainboards without any ISA slots get more common every day,
there will be even more PCI multi-I/O-cards (apart from everyone running
to USB :-)

I needed another serial and parallel port, and I've got one of these
mainboards (Asus A7V). So I had to buy such a PCI card. Nowadays you
can't even ask for a specific hardware manufacturer, everything the guy
in the shop knows is "yes, it's PCI, and yes, it has two serial and one
parallel port". 

As these cards are very cheap, you can't expect very much from them (I
don't even think there are any expensive ones out there). NetMos does
not produce this cards, they produce _chips_ for such cards. So there
are probably a lot of cards out there with these NetMos chips.

Again, how about other cards? Are there any PCI Multi-I/O-cards out
there, which are supported by linux? I'd be interested in how the driver
looks like....

bye, Michael


-- 
netWorks       	                                  Vox: +43 316  692396
Michael Reinelt                                   Fax: +43 316  692343
Geisslergasse 4					  GSM: +43 676 3079941
A-8045 Graz, Austria			      e-mail: reinelt@eunet.at
