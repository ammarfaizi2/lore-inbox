Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261330AbVDUMPn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261330AbVDUMPn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 08:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261331AbVDUMPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 08:15:43 -0400
Received: from mx1.redhat.com ([66.187.233.31]:27315 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261330AbVDUMPW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 08:15:22 -0400
Subject: Re: nVidia stuff again
From: Doug Ledford <dledford@redhat.com>
To: Dave Airlie <airlied@gmail.com>
Cc: Helge Hafting <helge.hafting@aitel.hist.no>,
       Chris Friesen <cfriesen@nortel.com>, linux-kernel@vger.kernel.org
In-Reply-To: <21d7e997050420161234141e23@mail.gmail.com>
References: <1113298455.16274.72.camel@caveman.xisl.com>
	 <20050412210857.GT11199@shell0.pdx.osdl.net>
	 <1113341579.3105.63.camel@caveman.xisl.com>
	 <425CEAC2.1050306@aitel.hist.no>
	 <20050413125921.GN17865@csclub.uwaterloo.ca>
	 <20050413130646.GF32354@marowsky-bree.de>
	 <20050413132308.GP17865@csclub.uwaterloo.ca> <425D3924.1070809@nortel.com>
	 <425E77BB.5010902@aitel.hist.no>
	 <1114021024.26866.63.camel@compaq-rhel4.xsintricity.com>
	 <21d7e997050420161234141e23@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 21 Apr 2005 08:15:02 -0400
Message-Id: <1114085702.26866.137.camel@compaq-rhel4.xsintricity.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-8) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-04-21 at 09:12 +1000, Dave Airlie wrote:
> > But *that's* the point people keep ignoring: the specs for programming
> > the hardware, in some cases, reveals details about the hardware's
> > implementation that nVidia does *not* want to release (in addition to
> > suggesting their software tricks).  Why is it that people *assume* that
> > just the programming docs tells a person nothing about the hardware?  We
> > already know that knowing the registers of a card and what those
> > registers do tells you implicit information about the card's design and
> > also reveals implicit information about the design of software that
> > works with the card.  How complex the card's registers and programming
> > interface is determines how much you can infer, and the more RISC like
> > or simple the card is and the more that is handled in the driver, the
> > more obviously the design can be inferred just from the programming
> > specs.
> 
>  I think the programming specs for a 3D graphics card can tell you
> very little about it, the R200 specs are very good but I doubt anyone
> would have a clue how to design the internals of the card just from
> looking at them, and now that GPUs are getting more like CPUs in terms
> of shaders and programming languages the specs are getting less and
> less useful to tell what is actually going on....

Ha!  That's the whole damn point Dave.  Use your head.  Just because ATI
is getting more complex with their GPU does *not* mean nVidia is.  Go
back to my original example of the aic7xxx cards.  The alternative to
their simple hardware design is something like the BusLogic or QLogic
cards that are far more complex.  Your assuming that because the ATI
cards are getting more complex and people are less able to discern their
makeup just by reading the specs that the nVidia cards are doing the
same, nVidia is telling you otherwise, and you are just blowing that off
as though you know more about their cards than they do.  Reality is that
they *could* be telling the truth and the fact that their card is a more
simplistic card than ATIs may be the very reason that ATI has ponied up
specs and they haven't.  Therefore, you can reliably discern absolutely
*zero* information about the nVidia cards from a reference to ATI specs.

> The main reasons they don't like open source is from where I'm
> standing, their IP lawyers and probably not being able to do sneaky
> hacks in the driver because people can see them..

"It's what you know, not what you think you know, that matters."  I
don't know why nVidia keeps their specs secret.  All I know is what they
tell the world.  But what I do know is that it's *possible* they could
be telling the truth, and I have no proof otherwise, regardless of any
suspicions.

-- 
Doug Ledford <dledford@redhat.com>
http://people.redhat.com/dledford


