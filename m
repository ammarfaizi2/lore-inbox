Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132390AbRAaUxN>; Wed, 31 Jan 2001 15:53:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132438AbRAaUwy>; Wed, 31 Jan 2001 15:52:54 -0500
Received: from ns.snowman.net ([63.80.4.34]:43278 "EHLO ns.snowman.net")
	by vger.kernel.org with ESMTP id <S131680AbRAaUwu>;
	Wed, 31 Jan 2001 15:52:50 -0500
Date: Wed, 31 Jan 2001 15:52:25 -0500 (EST)
From: <nick@snowman.net>
To: Scott Laird <laird@internap.com>
cc: George <greerga@entropy.muc.muohio.edu>,
        Peter Samuelson <peter@cadcamlab.org>,
        Bernd Eckenfels <inka-user@lina.inka.de>, linux-kernel@vger.kernel.org
Subject: Re: Request: increase in PCI bus limit
In-Reply-To: <Pine.LNX.4.31.0101311243340.13278-100000@lairdtest1.internap.com>
Message-ID: <Pine.LNX.4.21.0101311551090.12055-100000@ns>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

depends on the network card.  The adaptecs have one.  the Obsidion X16 and
X24 have them.  Many dual channel SCSI cards use them, and even some nicer
motherboards have them onboard.  I would like to recommend autodetection
at boot, but I'm assuming that someone has looked into it and determined
it impractical?
	Nick

On Wed, 31 Jan 2001, Scott Laird wrote:

> 
> 
> On Wed, 31 Jan 2001, George wrote:
> >
> > If someone says 1 bus, give them one bus.
> >
> > Just make the description say:
> >   Add 1 for every PCI
> >   Add 1 for every AGP
> >   Add 1 for every CardBus
> >   Also account for anything else funny in the system.
> >
> > Then panic on boot if they're wrong (sort of like processor type).
> 
> Where do cards with PCI-PCI bridges, like multiport PCI ethernet cards,
> fit into this?  I can easily add 3 or 4 extra busses into a box just by
> grabbing a couple extra Intel dual-port Ethernet cards.
> 
> 
> Scott
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
