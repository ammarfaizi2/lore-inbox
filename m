Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266674AbUGKX7V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266674AbUGKX7V (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 19:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266676AbUGKX7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 19:59:21 -0400
Received: from chaos.analogic.com ([204.178.40.224]:22658 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S266674AbUGKX7S convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 19:59:18 -0400
Date: Sun, 11 Jul 2004 19:59:08 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Jean Francois Martinez <jfm512@free.fr>
cc: linux-kernel@vger.kernel.org
Subject: Re: Integrated ethernet on SiS chipset doesn't work
In-Reply-To: <1089538014.4690.32.camel@agnes>
Message-ID: <Pine.LNX.4.53.0407111947270.7729@chaos>
References: <1089480939.2779.22.camel@agnes>  <Pine.LNX.4.53.0407102141560.5590@chaos>
 <1089538014.4690.32.camel@agnes>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Jul 2004, Jean Francois Martinez wrote:

> Le dim 11/07/2004 à 03:48, Richard B. Johnson a écrit :
> > On Sat, 10 Jul 2004, Jean Francois Martinez wrote:
> >
> > > I have a friend who owns a computer manufactured by Medion and who
> > > sports an MSI motherboard who has a SiS chipset.  The MSI motherboard
> > > seems to have ben made specially for Medion since it isn't
> > > referenced on MSI's site.  The problems is that the integrated ethernet
> > > doesn't work at all under Linux be it with 2.4 or 2.6 kernel.  He can't
> > > ping or connect to other boxes.  His ethernet works when he boots
> > > Windows.
> > >
> > > I include the output of lspci
> >
> > Tell him to plug a supported ethernet board into a PCI slot
> > and forget trying to get the embeded one working. It probably
> > isn't "turned on" by some secret incantations to some secret
> > registers. If you were to actually find out what was necessary
> > to make the board work, then that software won't work with a
> > regular SiS setup so nobody will put it into the kernel. The
> > usual problem with these imbeded boards is that the vendor
> > saved 18 US cents (actually) by not putting in the serial
> > EEPROM that enables I/O and sets the IEEE station address
> > (the MAC address). If you poke the correct registers, you
> > can get it turned ON, then what MAC address would you use?
> >
> > Buried in some BAR somewhere is the MAC address. Forget it.
> > Get a real ethernet board. Been there, done that.
> >
> >
>
> 1) I have been using several integrated ethernets in both Nvidia aand
> Intel chipsets with good results
>

Did you bother to READ what I took the time to explain?

> 2) The Sis 900 driver is supposed to be _supported_ ie someone is being
> paid for fixing problems.  It has the highest maintenance status so
> its problems are made to be fixed.
>

WTF?    Who is getting paid?  Find them and bitch to them. All the
stuff you see on the linux-kernel list was/is contributed for free.
It's possible that a vendor like Suse or RedHat may have people
working for them that get paid. You find out what company provided
your distribution and contact them.

> 3) The guy is not a hard core Linuxer but someone who is just feeling
> water temperature.  He has made from Linux being able to make his
> ethernet work THE test for deciding if Linux is usable.

So what?  I'm going to decide that THE test to find out about my
electric connection is, "Can a cat walk the wire?"

>
> 4) If I am bothering to submit to the kernel list it is because I want
> the problem fixed for _everyone_ and the road for this doesn't go
> through using another board or performing a trick of black magic
> (putting the thing in half duplex mode).  It goes through having the
> driver fixed and in the interim, since searching for black magic things
> is not acceptable in a professional context, getting the driver to use
> the black magic thing _by default_.  Now I am very willing to help the
> maintainer to find what is wrong with this particular
> submodel/motherboard.

Contact the "maintainer". Using black magic will break it for
real boards that plug into PCI slots. If you had bothered to
read what I wrote, you would know that.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.


