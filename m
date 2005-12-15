Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161072AbVLOIgU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161072AbVLOIgU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 03:36:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161079AbVLOIgU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 03:36:20 -0500
Received: from dial169-160.awalnet.net ([213.184.169.160]:39436 "EHLO
	raad.intranet") by vger.kernel.org with ESMTP id S1161072AbVLOIgT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 03:36:19 -0500
From: Al Boldi <a1426z@gawab.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: Linux in a binary world... a doomsday scenario
Date: Thu, 15 Dec 2005 11:31:39 +0300
User-Agent: KMail/1.5
Cc: Arjan van de Ven <arjan@infradead.org>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
References: <200512150013.29549.a1426z@gawab.com> <200512150749.29064.a1426z@gawab.com> <43A0FE13.8010303@yahoo.com.au>
In-Reply-To: <43A0FE13.8010303@yahoo.com.au>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200512151131.39216.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Al Boldi wrote:
> > Arjan van de Ven wrote:
> >>a stable api/abi for the linux kernel would take at least 2 years to
> >>develop. The current API is not designed for stable-ness, a stable API
> >>needs stricter separation between the layers and more opaque pointers
> >>etc etc.
> >
> > True.  But it would be time well spent.
>
> Who's time would be well spent?
>
> Not mine because I don't want a stable API. Not mine because I
> don't use binary drivers and I don't care to encourage them.
> [that is, unless you manage to convince me below ;)]

The fact that somebody may take advantage of a stable API should not lead us 
to reject the idea per se.

> Anyone else is free to fork the kernel and develop their own
> stable API for it.

That would be sad.

The objective of a stable API would be to aid the collective effort and not 
to divide it.

> >>There is a price you pay for having such a rigid scheme (it arguably has
> >>advantages too, those are mostly relevant in a closed source system tho)
> >>is that it's a lot harder to implement improvements.
> >
> > This is a common misconception.  What is true is that a closed system is
> > forced to implement a stable api by nature.  In an OpenSource system you
> > can just hack around, which may seem to speed your development cycle
> > when in fact it inhibits it.
>
> How? I'm quite willing to listen, but throwing around words like 'guided
> development' and 'scalability' doesn't do anything. How does the lack of a
> stable API inhibit my kernel development work, exactly?

If you are working alone a stable API would be overkill.  But GNU/Linux is a 
collective effort, where stability is paramount to aid scalability.

I hope the concepts here are clear.

> >>Linux isn't so much designed as evolved, and in evolution, new dominant
> >>things emerge regularly. A stable API would prevent those from even
> >> coming into existing, let alone become dominant and implemented.
> >
> > GNU/OpenSource is unguided by nature.
>
> I've got a fairly good idea of what work I'm doing, and what I'm planning
> to do, long term goals, projects, etc. What would be the key differences
> with "non-GNU/OpenSource" development that would make you say they are not
> unguided by nature?

The same goes for OpenSource in general, but GNU/OpenSource has a larger 
community and therefore is in greater need of a stable API.

> >  A stable API contributes to a guided
> > development that is scalable.  Scalability is what leads you to new
> > heights, or else could you imagine how ugly it would be to send this
> > message using asm?
>
> Let's not bother with bad analogies and stick to facts. Do you know how
> many people work on the Linux kernel? And how rapidly the source tree
> changes? Estimates of how many bugs we have? Comparitive numbers from
> projects with stable APIs? That would be very interesting.

You got me here!  It's really common sense as in:
stability breeds scalability, and instability breeds chaos.

Arjan van de Ven wrote:
> I think Linux proves you wrong (and a bit of a troll to be honest ;)

No troll! Just being IMHO. I hope that's OK?

Of course, if your aim is not to be scalable then please ignore this message 
as it will not have any meaning.

Thanks!

--
Al

