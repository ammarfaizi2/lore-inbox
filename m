Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264957AbTLFFtX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 00:49:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264958AbTLFFtX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 00:49:23 -0500
Received: from fw.osdl.org ([65.172.181.6]:53736 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264957AbTLFFtU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 00:49:20 -0500
Date: Fri, 5 Dec 2003 21:48:56 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Larry McVoy <lm@bitmover.com>
cc: Erik Andersen <andersen@codepoet.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Paul Adams <padamsdev@yahoo.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux GPL and binary module exception clause?
In-Reply-To: <20031206051433.GA25766@work.bitmover.com>
Message-ID: <Pine.LNX.4.58.0312052119050.2092@home.osdl.org>
References: <20031204235055.62846.qmail@web21503.mail.yahoo.com>
 <20031205004653.GA7385@codepoet.org> <Pine.LNX.4.58.0312041956530.27578@montezuma.fsmlabs.com>
 <20031205010349.GA9745@codepoet.org> <20031205012124.GB15799@work.bitmover.com>
 <Pine.LNX.4.58.0312041750270.6638@home.osdl.org> <20031206030037.GB28765@work.bitmover.com>
 <Pine.LNX.4.58.0312051949210.2092@home.osdl.org> <20031206051433.GA25766@work.bitmover.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 5 Dec 2003, Larry McVoy wrote:
>
> For example, you haven't puzzled out what happens if there are two
> GPL-like licenses which cover work which is combined.  Which one wins?
> What if they have conflicting terms?  The GPL *does not* automatically
> win, any more than the other license automatically wins.  Either could
> win.

What?

Nobody can "win". If the owners of the code can't agree on a mutually
acceptable license, you simply cannot legally combine them. End of story.

Whoever tries to combine the works - if it is against the license of
_either_ of the individual works - is doing something he simply doesn't
have the right to do.

And even if he does it, that illegal act in no way affects the license of
_either_ piece, since only ownership gives the right to change a license.
Nobody else and nothing else _ever_ does.

This has nothing to do with software. Think of book editors: they can't
combine two short stories into an edition unless _both_ authors of the
stories agree to the combination.

And the GPL only agrees to combine with the GPL. It's that simple. There
are no other ways to combine it.

There just isn't anything unclear here. I don't see why you'd be confused.

> I also don't buy your separation argument in the context of licensed
> intellectual property.

What separation argument wrt licensed intellectual property? I never made
such an argument.

I made the argument that if A has ownership of the code (not "licensed
intellectual property" - OWNERSHIP - and I thought I made it very clear
that they are totally different things), then they can take that part of
the code that they own and license it any which way they want, and make
any derived works they want (obviously, as long the other party of such a
derivative work agrees to the aggregation. As mentioned, the GPL happily
agrees to that, but only if the license on the result is also the GPL).

But that requires outright OWNERSHIP. It really requires that you are the
copyrigth holder. If you are a mere licensee, you simply can't do it
(unless the license explicitly gives you the right to do it, of course, or
you enter into some other contractual agreement to do so as a
subcontractor for the real copyright holder or similar. Blah blah blah).

But I never introduced the notion of being a licensee. I have at all times
only talked about outright ownership. Sorry if I have been unclear (I
didn't think I had been, but hey, few people find _themselves_ unclear ;)

Maybe you were confused by the IBM thing, and thinking that when I
referred to IBM I referred to a licensee. But the fact is, IBM is _not_ a
licensor of the JFS code etc. They own it outright. Even SCO has
acknowledged that fact long ago.

So I want to clarify: I have at all times talked about outright copyright
ownership. No sublicensing involved anywhere.

 - deep breath -

Now, this is all only true as far as copyright law goes. There are other
sections of the law that can have _other_ limitations. Eg you can limit
yourself contractually or through other means, outside of what copyright
allows you to do.

So to clarify with an example: let's say my _contract_ with OSDL says that
anything I write as an OSDL employee has to be licensed under an
open-source license - but that I can retain copyright to it, ie OSDL
doesn't aquire copyright ownership rights unless I so choose.

What does this mean? _Copyright_ law allows me to take any piece of code I
wrote (say, I could take a few lines from the kernel that I can show that
I own personally), I can take that code and I can license it under any
other license - _despite_ the fact that it is also licensed under the GPL
when it is part of the kernel.

So according to copyright law I can sell that code under any license I
damn well please.

However, my _contract_ with OSDL says that the code I write as an employee
has to be open-sourced, so while I'm not limited by copyright law, I'm
obviously limited by _other_ laws. I can still re-license my code (I'm
still the owner), but now I can only re-license it in specific ways
(because I'm bound by a contract).

		Linus
