Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129667AbRBPLYo>; Fri, 16 Feb 2001 06:24:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129243AbRBPLYe>; Fri, 16 Feb 2001 06:24:34 -0500
Received: from zeus.kernel.org ([209.10.41.242]:25828 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129942AbRBPLYT>;
	Fri, 16 Feb 2001 06:24:19 -0500
Date: Fri, 16 Feb 2001 11:19:21 +0000 (GMT)
From: James Sutherland <jas88@cam.ac.uk>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
cc: Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>,
        linux-kernel@vger.kernel.org
Subject: Re: 8139 full duplex?
In-Reply-To: <200102161003.LAA02713@cave.bitwizard.nl>
Message-ID: <Pine.SOL.4.21.0102161117080.3048-100000@orange.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Feb 2001, Rogier Wolff wrote:
> Jeff Garzik wrote:
> > On Fri, 16 Feb 2001, Rogier Wolff wrote:
> > > I have a bunch of computers with 8139 cards. When I moved the cables
> > > over from my hub to my new switch all the "full duplex" lights came on
> > > immediately.
> > > 
> > > Would this mean that the driver/card already were in full-duplex? That
> > > would explain me seeing way too many collisions on that old hub (which
> > > obviously doesn't support full-duplex).
> > > 
> > > (Some machines run 2.2 kernels, others run 2.4 kernels some run the
> > > old driver, others run the 8139too driver). 
> > 
> > Some versions of the driver bork the LED register, which may lead to
> > false assumptions.
> 
> Does the driver control the led on my switch?????

No, the switch does that.

> (My cards just have a "link" led, and a "100Mbps" led)

Ah... Mine have an FD indicator. I think - it's a while since I last
looked closely enough at the back of the machine to tell :)

> I'm not going back to the hub after upgrading just to see the
> changeover messages. I'm confident that we're running full-duplex now
> on the switch and that that's OK with the switch. I was just wondering
> wether this confirmed my suspicion that there was something wrong with
> the /duplexicity/. 

I suppose one machine could have auto-negotiated wrongly - was it a Linux
box? I've seen Win2k fail to negotiate the best settings - running HD on a
switch - but I haven't seen FD on a hub...


James.

