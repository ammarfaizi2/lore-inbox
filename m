Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <154620-24313>; Tue, 25 Aug 1998 22:43:42 -0400
Received: from post-20.mail.demon.net ([194.217.242.27]:32846 "EHLO post.mail.demon.net" ident: "NO-IDENT-SERVICE[2]") by vger.rutgers.edu with ESMTP id <155546-24313>; Tue, 25 Aug 1998 21:29:06 -0400
Message-ID: <19980826010302.A2527@tantalophile.demon.co.uk>
Date: Wed, 26 Aug 1998 01:03:02 +0100
From: Jamie Lokier <lkd@tantalophile.demon.co.uk>
To: linux-kernel@vger.rutgers.edu
Subject: Re: Fuzzy hash stuff.. (was Re: 2.1.xxx makes Electric Fence 22x slower)
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
In-Reply-To: <no.id>; from Keith Owens on Tue, Aug 25, 1998 at 10:47:26PM +1000
Sender: owner-linux-kernel@vger.rutgers.edu

"David S. Miller" <davem@dm.cobaltmicro.com> wrote:
>As promised here is my work in progress fuzzy hash VMA lookup stuff.

On Tue, Aug 25, 1998 at 10:47:26PM +1000, Keith Owens wrote:
> Lots of code with very few comments snipped.  Come on Davem, make it
> understandable for us mere mortals.  If it took two people to fix
> quirks and bugs and converge the algorithm, surely a few notes on how
> it works would not go astray.

Nope, I can't see how it works either.

BTW, a splay tree would also be as fast as what we have now in the
common case, without need for a special one entry cache.  The root of
the tree automatically acts as the cache.

-- Jamie

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.altern.org/andrebalsa/doc/lkml-faq.html
