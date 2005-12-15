Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161047AbVLOExA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161047AbVLOExA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 23:53:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161050AbVLOExA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 23:53:00 -0500
Received: from dial169-93.awalnet.net ([213.184.169.93]:30476 "EHLO
	raad.intranet") by vger.kernel.org with ESMTP id S1161047AbVLOExA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 23:53:00 -0500
From: Al Boldi <a1426z@gawab.com>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: Linux in a binary world... a doomsday scenario
Date: Thu, 15 Dec 2005 07:49:28 +0300
User-Agent: KMail/1.5
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
References: <200512150013.29549.a1426z@gawab.com> <1134595639.9442.14.camel@laptopd505.fenrus.org>
In-Reply-To: <1134595639.9442.14.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200512150749.29064.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Thu, 2005-12-15 at 00:13 +0300, Al Boldi wrote:
> > Greg KH wrote:
> > > For people to think that the kernel developers are just "too dumb" to
> > > make a stable kernel api (and yes, I've had people accuse me of this
> > > many times to my face[1]) shows a total lack of understanding as to
> > > _why_ we change the in-kernel api all the time.  Please see
> > > Documentation/stable_api_nonsense.txt for details on this.
> >
> > I read this doc, and it doesn't make your case any clearer, on the
> > contrary!
> >
> > But first, your work to the kernel represents a not so dumb
> > contribution, especially the replacement of devfs.  Thanks!
> >
> > Now, to call a stable api nonsense is nonsense.  Really, only a _stable_
> > api is worth to be considered an API.  Think about it.
>
> a stable api/abi for the linux kernel would take at least 2 years to
> develop. The current API is not designed for stable-ness, a stable API
> needs stricter separation between the layers and more opaque pointers
> etc etc.

True.  But it would be time well spent.

> There is a price you pay for having such a rigid scheme (it arguably has
> advantages too, those are mostly relevant in a closed source system tho)
> is that it's a lot harder to implement improvements.

This is a common misconception.  What is true is that a closed system is 
forced to implement a stable api by nature.  In an OpenSource system you can 
just hack around, which may seem to speed your development cycle when in 
fact it inhibits it.

> Linux isn't so much designed as evolved, and in evolution, new dominant
> things emerge regularly. A stable API would prevent those from even coming
> into existing, let alone become dominant and implemented.

GNU/OpenSource is unguided by nature.  A stable API contributes to a guided 
development that is scalable.  Scalability is what leads you to new heights, 
or else could you imagine how ugly it would be to send this message using 
asm?

Thanks!

--
Al

