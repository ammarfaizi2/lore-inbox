Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289067AbSANVfM>; Mon, 14 Jan 2002 16:35:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289078AbSANVfC>; Mon, 14 Jan 2002 16:35:02 -0500
Received: from femail44.sdc1.sfba.home.com ([24.254.60.38]:1983 "EHLO
	femail44.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S289067AbSANVey>; Mon, 14 Jan 2002 16:34:54 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Charles Cazabon <charlesc@discworld.dyndns.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Aunt Tillie builds a kernel (was Re: ISA hardware discovery -- the elegant solution)
Date: Mon, 14 Jan 2002 08:32:53 -0500
X-Mailer: KMail [version 1.3.1]
Cc: "Eric S. Raymond" <esr@thyrsus.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Eli Carter <eli.carter@inet.com>,
        "Michael Lazarou \(ETL\)" <Michael.Lazarou@etl.ericsson.se>
In-Reply-To: <20020114125228.B14747@thyrsus.com> <20020114132618.G14747@thyrsus.com> <20020114125508.A3358@twoflower.internal.do>
In-Reply-To: <20020114125508.A3358@twoflower.internal.do>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020114213453.YJCM15906.femail44.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 14 January 2002 01:55 pm, Charles Cazabon wrote:
> Eric S. Raymond <esr@thyrsus.com> wrote:
> > Alan Cox <alan@lxorguk.ukuu.org.uk>:
> > > Now to do everything you describe does not need her to configure a
> > > custom kernel tree. Not one bit. You think apt or up2date build each
> > > user a custom kernel tree ?
> >
> > Is it OK in your world that Aunt Tillie is dependent on a distro maker? 
> > Is it OK that she never gets to have a kernel compiled for anything above
> > the least-common-denominator chip?
>
> Yes, and yes.  Aunt Tillie is running Linux because someone installed a
> distribution for her.

Or, some glorious day in the future, it came preinstalled on her hardware.

> She is never going to need anything out of her kernel that her
> vendor-shipped update kernels do not provide.

I wouldn't go THAT far, but when she does she'll have someone else upgrade it 
for her.  (Just because you CAN learn to change the oil in your car doesn't 
mean you want to.  Can aunt tillie actually unscrew her case and insert a PCI 
card?  More to the point, WOULD she?)

> > But the point of this game is for Aunt Tillie to have more and better
> > choices.  Isn't that what we're supposed to be about?

No.  The point is to offer EVERYBODY more and better choices.  Whether 
they'll be any use to aunt tillie specifically is secondary.

> No.  We're supposed to be about stuff that works.  Vendor-shipped kernels
> work for 99.9% of people.  The remaining 0.1% have no need for an
> "auto-configurator".

I like the auto-configurator.  I build custom kernels for all sorts of 
different machines and it can take me half an hour to walk through the menus 
with a command line open in a second window doing cat /proc/pci, cat 
/proc/bus/usb, and whatever replaced isapnp (cat /proc/bus/isapnp probably) 
to figure out and properly select everything that's in this box.

If the autoprobe saves me that half an hour, I'm all for it.  People who 
don't see much use in an autoprober probably don't work with other people's 
hardware very often.

It's also a nice educational tool for newbies learning the linux kernel, 
which I suspect is the real reason some people actively object to it. :) 

> Charles

Rob
