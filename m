Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263680AbTLJQWS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 11:22:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263691AbTLJQWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 11:22:18 -0500
Received: from fw.osdl.org ([65.172.181.6]:40890 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263680AbTLJQWI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 11:22:08 -0500
Date: Wed, 10 Dec 2003 08:21:52 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Larry McVoy <lm@bitmover.com>
cc: Andre Hedrick <andre@linux-ide.org>, Arjan van de Ven <arjanv@redhat.com>,
       Valdis.Kletnieks@vt.edu, Kendall Bennett <KendallB@scitechsoft.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux GPL and binary module exception clause?
In-Reply-To: <20031210153254.GC6896@work.bitmover.com>
Message-ID: <Pine.LNX.4.58.0312100809150.29676@home.osdl.org>
References: <Pine.LNX.4.10.10312100550500.3805-100000@master.linux-ide.org>
 <Pine.LNX.4.58.0312100714390.29676@home.osdl.org> <20031210153254.GC6896@work.bitmover.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 10 Dec 2003, Larry McVoy wrote:
>
> > kernel was compiled with certain options etc - then it pretty clearly is
> > very tightly integrated.
>
> So what?  Plugins have a nasty tendency to have to be updated when the
> main program is updated.

Sorry, but again, I repeat: technicalities don't actually matter much to a
judge.

There's a fundamental difference between "plugins" and "kernel modules":
intent.

If you write a program that tries to have a stable API to outside modules,
and you make and document a plugin interface that is documented to accept
proprietary modules, then that is an ABI. And linking against such a thing
is fine.

But when you have the GPL, and you have documented for years and years
that it is NOT a stable API, and that it is NOT a boundary for the license
and that you do NOT get an automatic waiver when you compile against this
boundary, then things are different.

And they are different even if from a _technical_ standpoint you do
exactly the same: you dynamically link against a binary.

Ask a lawyer. Really.

I know people on this list are engineers and programmers, and you think
that technology is all that matters, and that if you link in one situation
and do exactly the same motions ("walk around the computer three times
widdershins, and give the -dynamic option to 'ld'") then you are doing the
same thing.

But that's not how "the real world" works. In the real world, intent and
permission matter a whole lot. When you make love to your wife in the
privacy of your own home, the "real world" is perfectly ok with that. When
you do the same thing to somebody you didn't get permission from, it's a
major crime and you can be put into prison for decades - even though
technically the movements are pretty much the same.

See? Intent matters. How you do something _technically_ does not.

In fact, I will bet you that if the judge thinks that you tried to use
technicalities ("your honour, I didn't actually run the 'ln' program,
instead of wrote a shell script for the _user_ to run the 'ln' program for
me"), that judge will just see that as admission of the fact that you
_knew_ you were doing something bad. Which means that now it wasn't just
unintentional copyright infringement, now it is clearly wilful.

So those technicalities you might use to try to make things better
actually can make them WORSE.

The best you can do is to just ask for permission. Maybe you'll get it.

			Linus
