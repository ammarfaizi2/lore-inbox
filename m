Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262119AbTIWWy3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 18:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262123AbTIWWy3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 18:54:29 -0400
Received: from fw.osdl.org ([65.172.181.6]:3046 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262119AbTIWWy0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 18:54:26 -0400
Date: Tue, 23 Sep 2003 15:54:22 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Matthew Wilcox <willy@debian.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       Larry McVoy <lm@bitmover.com>
Subject: Re: log-buf-len dynamic
In-Reply-To: <20030923221528.GP1269@velociraptor.random>
Message-ID: <Pine.LNX.4.44.0309231524160.24527-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 24 Sep 2003, Andrea Arcangeli wrote:
> 
> we have cvsps and subversion these days, it's not about cvs only anymore.

Neither of those are anywhere close to bk. 

In particular, they don't support any kind of distributed development.  
They aren't even trying to, I'm sad to say. And to me, distributed
development is the only thing that matters.

And I realise it isn't to you. You don't much care about merging, you only
have your tree you need to worry about. 

And you know what? You shouldn't have to care. I'm not berating you for
using CVS/SVN/whatever. I'm berating you for complaining when _others_
have come to the conclusion that CVS/SVN/whatever really doesn't cut it
for them.

Use CVS and be happy. But don't complain to others that have needs that 
CVS simply can't fill. 

  [ Bad analogy time ]

You're acting like a husband that has a wife that refuses to use make-up,
and thinks that everybody else should have ugly wives too, and calls them 
whores for being prettier.

Actually, in the CVS analogy, I don't think it's that your wife refuses to
use make-up, but that make-up doesn't actually help.

  [ Ok, let's see just _how_ badly I get flamed for that analogy. I
    admit, it really sucks, and is tasteless to boot. My bad. ]

> But note that cvs+cvsps is already perfectly usable for me, most people
> is readonly anyways

Indeed. That's pretty much all non-distributed stuff is useful for, from
where I'm stading.  Small projects with a few developers and a lot of
read-only stuff. And even there the developers will bitch about the
limitations.

Sure, SVN makes branches cheaper, but you still have to work with them
like under CVS, ie merging is a total disaster. And you still can't make 
it your private repository.

But that wasn't really my point. My point is that you're only starting
flame wars, with no actual point to your emails. Please don't.

	"Those that can, do. Those that can't, complain".

You're complaining, right now. Everybody who has ever used BK admits to 
its techical superiority. That's just a fact.

I don't care about source control software, so I'm not likely to start
coding one any time soon (like "ever") - but if I did, I'd be totally
_ashamed_ to push lower-quality stuff on users. I'd make excuses for it,
and I'd 'fess up when they didn't work. And I'd try my best to make it
better. Even if it took me a decade.

In contrast, what you're doing is saying "ignore the good stuff: use this
crap, because I'm buddies with the people developing it. We aren't even
trying to compete on technical terms, but we'll push our version on you
because we've got religion, and this doesn't contain any cow-meat". That's
bad - especially if others DON'T share the religion.

I'm ok with other people using NT. When it's better for them, that's their
choice. I work hard to make sure that the Linux kernel is technically
superior, and if I feel it isn't I want to fix it. Because I do _not_ want
people using Linux for religious reasons. I want people to use Linux
because it is _better_ for them, of because they truly believe that they
can make it so (or at least have fun trying).

Take pride in what you do. But don't make that pride blind you to what is 
good technology, and what isn't. Don't get religion. It's a science.

Oh well. I told you not to start a flamewar, and I told Larry to not raise 
to the bait. Now I'll just take my own advice and stop responding. You too 
please stop baiting,

			Linus

