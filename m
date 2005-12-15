Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965186AbVLOHLY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965186AbVLOHLY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 02:11:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965184AbVLOHLY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 02:11:24 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:45442 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965187AbVLOHLY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 02:11:24 -0500
Subject: Re: Linux in a binary world... a doomsday scenario
From: Arjan van de Ven <arjan@infradead.org>
To: Al Boldi <a1426z@gawab.com>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200512150749.29064.a1426z@gawab.com>
References: <200512150013.29549.a1426z@gawab.com>
	 <1134595639.9442.14.camel@laptopd505.fenrus.org>
	 <200512150749.29064.a1426z@gawab.com>
Content-Type: text/plain
Date: Thu, 15 Dec 2005 08:11:16 +0100
Message-Id: <1134630676.9442.19.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-15 at 07:49 +0300, Al Boldi wrote:
> Arjan van de Ven wrote:
> > On Thu, 2005-12-15 at 00:13 +0300, Al Boldi wrote:
> > > Greg KH wrote:
> > > > For people to think that the kernel developers are just "too dumb" to
> > > > make a stable kernel api (and yes, I've had people accuse me of this
> > > > many times to my face[1]) shows a total lack of understanding as to
> > > > _why_ we change the in-kernel api all the time.  Please see
> > > > Documentation/stable_api_nonsense.txt for details on this.
> > >
> > > I read this doc, and it doesn't make your case any clearer, on the
> > > contrary!
> > >
> > > But first, your work to the kernel represents a not so dumb
> > > contribution, especially the replacement of devfs.  Thanks!
> > >
> > > Now, to call a stable api nonsense is nonsense.  Really, only a _stable_
> > > api is worth to be considered an API.  Think about it.
> >
> > a stable api/abi for the linux kernel would take at least 2 years to
> > develop. The current API is not designed for stable-ness, a stable API
> > needs stricter separation between the layers and more opaque pointers
> > etc etc.
> 
> True.  But it would be time well spent.

feel free to spend your time on it, you seem to consider it well spent
time. A lot of us don't, so we're not going to spend our time on it....


> > There is a price you pay for having such a rigid scheme (it arguably has
> > advantages too, those are mostly relevant in a closed source system tho)
> > is that it's a lot harder to implement improvements.
> 
> This is a common misconception.

a stable API is more rigid, that is not and can't be a misconception.

>   What is true is that a closed system is 
> forced to implement a stable api by nature.  In an OpenSource system you can 
> just hack around, which may seem to speed your development cycle when in 
> fact it inhibits it.

in practice it doesn't. The kernel drivers are GPL, and API changes when
needed just happen, all callers are fixed. The alternative would be a
"crooked" API which needs workarounds on both sides. No thanks.

> 
> > Linux isn't so much designed as evolved, and in evolution, new dominant
> > things emerge regularly. A stable API would prevent those from even coming
> > into existing, let alone become dominant and implemented.
> 
> GNU/OpenSource is unguided by nature.  A stable API contributes to a guided 
> development that is scalable.  Scalability is what leads you to new heights, 
> or else could you imagine how ugly it would be to send this message using 
> asm?

I think Linux proves you wrong (and a bit of a troll to be honest ;)

Anyway, it's an open system, if you think something should happen... you
can make it happen by contributing and then defending it. If it's the
right thing, it'll then happen.


