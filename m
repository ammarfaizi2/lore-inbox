Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263596AbTLJTPt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 14:15:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263598AbTLJTPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 14:15:49 -0500
Received: from fw.osdl.org ([65.172.181.6]:22974 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263596AbTLJTPr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 14:15:47 -0500
Date: Wed, 10 Dec 2003 11:15:24 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Larry McVoy <lm@bitmover.com>
cc: Andre Hedrick <andre@linux-ide.org>, Arjan van de Ven <arjanv@redhat.com>,
       Valdis.Kletnieks@vt.edu, Kendall Bennett <KendallB@scitechsoft.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux GPL and binary module exception clause?
In-Reply-To: <20031210183833.GJ6896@work.bitmover.com>
Message-ID: <Pine.LNX.4.58.0312101108150.29676@home.osdl.org>
References: <Pine.LNX.4.10.10312100550500.3805-100000@master.linux-ide.org>
 <Pine.LNX.4.58.0312100714390.29676@home.osdl.org> <20031210153254.GC6896@work.bitmover.com>
 <Pine.LNX.4.58.0312100809150.29676@home.osdl.org> <20031210163425.GF6896@work.bitmover.com>
 <Pine.LNX.4.58.0312100852210.29676@home.osdl.org> <20031210175614.GH6896@work.bitmover.com>
 <Pine.LNX.4.58.0312100959180.29676@home.osdl.org> <20031210180822.GI6896@work.bitmover.com>
 <Pine.LNX.4.58.0312101016010.29676@home.osdl.org> <20031210183833.GJ6896@work.bitmover.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 10 Dec 2003, Larry McVoy wrote:
>
> I can understand your touchiness, it's not much fun living through tons of
> messages where people try and figure out how to circumvent your license.

That's not really the issue.

I'd like to make it clear that I'm actually much softer on this than many
other people - I've been making it clear that I think that binary-only
modules _are_ ok, but that the burden of proof of ok'ness is squarely on
the shoulders of the company that makes them.

So please do get that part clear: I'm pretty well-known for allowing
binary-only modules in things like AFS and nVidia, where some people think
they shouldn't be allowed.

But the real issue here (and in the subject line in this whole discussion)
is about an "exception clause".

There is none. And I'm just saying that there is NO WAY that a binary-only
module is "automatically in the clear". They _may_ be, but it's on the
basis of something totally different than just "it's a module".

This is why I want to make it so clear that "moduleness" (which is not a
word, but should be one) is not the thing that matters. There's still a
strong "linkage" to a particular kernel in a binary module, and the act of
running the linker is not what determines whether a work is a derived
work.

In short, you should not see my arguments as a way of saying "all modules
are derived works". I'm clearly not saying that, since I _do_ allow binary
only modules and I don't claim they infringe.

So I'm not arguing for a very wide notion of derived works: I'm arguing
AGAINST the narrow notion that a module would somehow automatically _not_
be derived.

This is why I've said at least fifty times that a kernel module is to be
considered "derived by default". The non-derivedness comes from things
that have nothing to do with whether it is a module.

		Linus
