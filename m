Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263606AbRFFQzA>; Wed, 6 Jun 2001 12:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263607AbRFFQyu>; Wed, 6 Jun 2001 12:54:50 -0400
Received: from www.wen-online.de ([212.223.88.39]:36369 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S263606AbRFFQye>;
	Wed, 6 Jun 2001 12:54:34 -0400
Date: Wed, 6 Jun 2001 18:53:31 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>,
        =?ISO-8859-1?Q?Christian_Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>,
        Derek Glidden <dglidden@illusionary.com>
Subject: Re: Requirement: swap = RAM x 2.5 ??
In-Reply-To: <200106061619.f56GJjw15740@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.LNX.4.33.0106061845530.610-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jun 2001, Richard Gooch wrote:

> Jeff Garzik writes:
> > Richard Gooch wrote:
> > >
> > > Jeff Garzik writes:
> > > >
> > > > I'm sorry but this is a regression, plain and simple.
> > > >
> > > > Previous versons of Linux have worked great on diskless workstations
> > > > with NO swap.
> > > >
> > > > Swap is "extra space to be used if we have it" and nothing else.
> > >
> > > Sure. But Linux still works without swap. It's just that if you *do*
> > > have swap, it works best with 2* RAM.
> >
> > Yes, but that's not the point of the discussion.  Currently 2*RAM is
> > more of a requirement than a recommendation.
>
> Um, do you mean "2*RAM is required, always", or "2*RAM or more swap is
> required if swap != 0"?

When Rik starts to reclaim unused swap (didn't he say he was going to
do that?) this will instantly revert to the most respected of rules..
rules are made to be b0rken.

	-Mike

