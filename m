Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269975AbRHUBhH>; Mon, 20 Aug 2001 21:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271007AbRHUBg6>; Mon, 20 Aug 2001 21:36:58 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:26782 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S270958AbRHUBgo>; Mon, 20 Aug 2001 21:36:44 -0400
Date: Mon, 20 Aug 2001 19:36:36 -0600
Message-Id: <200108210136.f7L1aa008756@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Theodore Tso <tytso@mit.edu>
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        Johan Adolfsson <johan.adolfsson@axis.com>,
        Robert Love <rml@tech9.net>, Oliver Xymoron <oxymoron@waste.org>,
        linux-kernel@vger.kernel.org, riel@conectiva.com.br
Subject: Re: [PATCH] let Net Devices feed Entropy, updated (1/2)
In-Reply-To: <20010820211107.A20957@thunk.org>
In-Reply-To: <3B80EADC.234B39F0@evision-ventures.com>
	<2248596630.998319423@[10.132.112.53]>
	<3B811DD6.9648BE0E@evision-ventures.com>
	<20010820211107.A20957@thunk.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Tso writes:
> On Mon, Aug 20, 2001 at 04:25:26PM +0200, Martin Dalecki wrote:
> > 
> > The primary reson of invention of /dev/random was the need
> > for a bit of salt to the initial packet sequence number inside
> > the networking code in linux. And for this purspose the
> > whole /dev/*random stuff is INDEED a gratitious overdesign.
> > For anything else crypto related it just doesn't cut the corner.
> 
> A number of other people helped me with the design and development of
> the /dev/random driver, including one of the primary authors of the
> random number generation routines in PGP 2.x and 5.0.  Most folks feel
> that it does a good job.

Indeed. If Martin has some deep insight as to why the /dev/random
implementation is insufficient for strong crypto, I'd like to hear
it.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
