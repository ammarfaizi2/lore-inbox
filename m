Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314707AbSDVTxd>; Mon, 22 Apr 2002 15:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314706AbSDVTxc>; Mon, 22 Apr 2002 15:53:32 -0400
Received: from panic.tn.gatech.edu ([130.207.137.62]:57037 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S314714AbSDVTw3>;
	Mon, 22 Apr 2002 15:52:29 -0400
Date: Mon, 22 Apr 2002 15:52:23 -0400
From: Jeff Garzik <garzik@havoc.gtf.org>
To: "Jonathan A. George" <JGeorge@greshamstorage.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove Bitkeeper documentation from Linux tree
Message-ID: <20020422155223.B20999@havoc.gtf.org>
In-Reply-To: <3CC4585F.4060005@greshamstorage.com> <20020422145850.F11216@havoc.gtf.org> <3CC46231.8080008@greshamstorage.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2002 at 02:19:13PM -0500, Jonathan A. George wrote:
> Jeff Garzik wrote:
> 
> >On Mon, Apr 22, 2002 at 01:37:19PM -0500, Jonathan A. George wrote:
> >  
> >
> >>The BK documentation constitutes an implicit advertisement and 
> >>endorsement of a product with a license which to many developers 
> >>violates the spirit of open source software.
> >>
> >Agreed.  
> >
> >And the simple fact of Linus using BitKeeper does the
> >_exact_ _same_ _thing_.
> >
> Not quite.  Linus uses BK as a tool to facilitate kernel development. 
>  However, he has not made BK _part_ _of_ _the_ _kernel_. ;-)  Obviously 
> anyone can use any tool ON the kernel, but integrating into the kernel 
> is something else.

That's a poor comparison, we are not integrating BitKeeper into the
kernel :)

Like or not, BK is used by several maintainers, including The Big
Penguin himself.  There are plenty of good reasons why this doc
should be in the kernel source, only a single, lone reason against
it:  some people don't like _talking_ about proprietary software in
the kernel sources.


> >Talk Linus out of using BitKeeper, and sure, I'll remove the doc.
> >
> No need.  His tools are his choice.  The kernel itself is ours not his; 
>  thus the distinction.

He is the gatekeeper.  The kernel can be considered his, too, because it
is on his judgement that changes are accepted and rejected.  If he uses
BitKeeper, and some maintainers find it easier to use BitKeeper, that's
a far stronger implicit advertisement for BitKeeper than some doc will
ever be.  If Linus stopped using BitKeeper, that would provide incentive
for other maintainers to stop using BitKeeper, which in turn means there
is technical merit in the removal of the BK doc.


> >>This is not to say that BK 
> >>is not an effective product, nor that the document in question is useful 
> >>for people who choose the tool, but to me it seems comparable to 
> >>including a closed source binary module in the kernel distribution. 
> >>
> >No, it is not comparable at all with that.  There are no license
> >problems with the document -- it is GPL'd.
> >
> The GPL has a specific intent which (though use in the kernel is more 
> like the LGPL because binary modules are permitted) which doesn't 
> explicitly extend to such documentation.  The spirit of the GPL which 
> causes us to exclude binary modules from the distribution very much does 
> apply.  To a lawyer this might not matter, but I expect more from a top 
> free software contributor like you.

The doc is free by any standard.  The _subject_ of the doc is not free.
There are plenty of documents talking about proprietary software
which are free, covered by the GNU FDL if not the GPL or some other
free license.  Separate the licensing of the _subject_ of the doc,
from the doc itself.

I simply don't see a comparison at all.  Closed source and binary
modules by definition hides IP from most.  The doc is hiding nothing.

I don't think it will accomplish anything, but if it satisfies you or
others, I can change the doc's license to GNU FDL.

What matters to me is that other free software contributors are trying
to dictate what we can and cannot _talk about_ in the kernel sources.


> That is a minor detail (as you know).  My suggestion was an attempt to 
> balance the value of your admittedly useful document with the nature of 
> the endorsement.

The nature of the endorsement is implicit when BK is used by kernel
developers, not when a doc is present.

I'm very open to suggestions about combatting the notion that BK
is required for kernel devel.  Removing this doc may satisfy a few
people, but (a) it does not address the fundamental disagreement,
and (b) it is a slippery slope when we start removing docs because
we disagree with their subject on ideological grounds.

Even if I was completely anti-BitKeeper, pro-100%-open-source,
I would find Daniel's patch troubling because of "(b)"

Kernel source is no place to start drawing strict notions of what is
acceptable to discuss.  I weigh that assertion above a token gesture to
the silently-seething developers that does nothing to change the real
status quo.

	Jeff



