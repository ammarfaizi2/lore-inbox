Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313826AbSDUUWm>; Sun, 21 Apr 2002 16:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313827AbSDUUWl>; Sun, 21 Apr 2002 16:22:41 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:23558 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S313826AbSDUUWk>;
	Sun, 21 Apr 2002 16:22:40 -0400
Message-ID: <3CC31F8D.455886F5@zip.com.au>
Date: Sun, 21 Apr 2002 13:22:37 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: dean gaudet <dean-list-linux-kernel@arctic.org>
CC: Daniel Phillips <phillips@bonn-fries.net>, Larry McVoy <lm@bitmover.com>,
        Jeff Garzik <garzik@havoc.gtf.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove Bitkeeper documentation from Linux tree
In-Reply-To: <E16yzOr-0000lT-00@starship> <Pine.LNX.4.44.0204211158160.30929-100000@twinlark.arctic.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dean gaudet wrote:
> 
> On Sat, 20 Apr 2002, Daniel Phillips wrote:
> 
> > Riiiiight.  I have at least forwarded your demands to those who have
> > expressed their positions to me privately.  If you think I'm going to
> > violate their confidence on your whim, you can think again.
> 
> so then you're having private discussions in email, and one of your
> complaints is about other private discussions in email?
> 

The reason why people do not express their disquiet is very plain - any
time anyone dares comes out, they promptly get their head kicked in.

Guys, this problem is permanent, and it's not going away.

Larry has stated that kernel's use of bitkeeper is not providing
collateral sales, and nor was it intended for that.  Fair enough.
But it's inevitable that, in some people's eyes, kernel's very
public use of bitkeeper be viewed as promotion of bitmover's
product, and as endorsement of bitmover's licensing innovations.

Some people don't like this, and never will.  I'm tempted here to
say "get over it".  This disagreement is a permanent part of the
kernel landscape.

Linus took the work of others and used it in a way which they did
not expect, without their permission, and contrary to their wishes.
He knew what he was doing, and he knew that some wouldn't like it.
If he had chosen any other path, he'd be juggling ascii diffs
until the end of time.

My take on Daniel's patch is that it is addressing the symptoms,
not the problem.  And the problem is unsolveable.  The differences
of opinion are irreconcilable.  Both sides are populated by 
perfectly sensible people with perfectly legitimate points of view.

So.  Life goes on.  We will have regular bitkeeper flamewars, and
that's a good thing - it reminds everyone that there are different
opinions and different work practices which need to be accommodated.

Oh.  And the problem of stealth patches is a human one, not a tool
one.  Tree owners should prefer to drop unreviewed patches. Not just
because said patches may have bugs which they miss.  Not just because
having others check the work lightens their workload. Not just because
others may have other, different implementations in the works.  But
also because it keeps everyone informed as to what's going on, and
generally makes for a better development team.

It would help to avoid, say, the situation where random fs maintainer
"A" is amazed to discover one day that a patch from random VFS maintainer
"B" had caused said filesystem to be doing a surprise "up" on a non-downed
semaphore.  Not that this could ever happen.

-
