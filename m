Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263791AbTLJRKx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 12:10:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263793AbTLJRKw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 12:10:52 -0500
Received: from fw.osdl.org ([65.172.181.6]:19930 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263791AbTLJRKj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 12:10:39 -0500
Date: Wed, 10 Dec 2003 09:10:18 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Larry McVoy <lm@bitmover.com>
cc: Andre Hedrick <andre@linux-ide.org>, Arjan van de Ven <arjanv@redhat.com>,
       Valdis.Kletnieks@vt.edu, Kendall Bennett <KendallB@scitechsoft.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux GPL and binary module exception clause?
In-Reply-To: <20031210163425.GF6896@work.bitmover.com>
Message-ID: <Pine.LNX.4.58.0312100852210.29676@home.osdl.org>
References: <Pine.LNX.4.10.10312100550500.3805-100000@master.linux-ide.org>
 <Pine.LNX.4.58.0312100714390.29676@home.osdl.org> <20031210153254.GC6896@work.bitmover.com>
 <Pine.LNX.4.58.0312100809150.29676@home.osdl.org> <20031210163425.GF6896@work.bitmover.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 10 Dec 2003, Larry McVoy wrote:
>
> Which is?  How is it that you can spend a page of text saying a judge doesn't
> care about technicalities and then base the rest of your argument on the
> distinction between a "plugin" and a "kernel module"?

I'll stop arguing, since you obviously do not get it.

I explained the technicalities to _you_, and you are a technical person.

But if you want to explain something to a judge, you get a real lawyer,
and you make sure that the lawyer tries to explain the issue in _non_
technical terms. Because, quite frankly, the judge is not going to buy a
technical discussion he or she doesn't understand.

Just as an example, how do you explain to a judge how much code the Linux
kernel contains? Do you say "it's 6 million lines of C code and header
files and documentation, for a total of about 175MB of data"?

Yeah, maybe you'd _mention_ that, but to actually _illustrate_ the point
you'd say that if you printed it out, it would be a solid stack of papers
100 feet high.  And you'd compare it to the height of the court building
you're in, or something. Maybe you'd print out _one_ file, bind it as a
book, and wave it around as one out of 15,000 files.

But when _you_ ask me about how big the kernel is, I'd say "5 million
lines". See the difference? It would be silly for me to tell you how many
feet of paper the kernel would print out to, because we don't have those
kinds of associations.

Similarly, if you want to explain the notion of a kernel module, you'd
compare it to maybe an extra chapter in a book. You'd make an analogy to
something that never _ever_ mentions "linking".

Just imagine: distributing a compiled binary-only kernel module that can
be loaded into the kernel is not like distributing a new book: it's more
like distributing a extra chapter to a book that somebody else wrote, that
uses all the same characters and the plot, but more importantly it
literally can only be read _together_ with the original work. It doesn't
stand alone.

In short, your honour, this extra chapter without any meaning on its own
is a derived work of the book.

In contrast, maybe you can re-write your code and distribute it as a
short-story, which can be run on its own, and maybe the author has been
influenced by another book, but the short-story could be bound AS IS, and
a recipient would find it useful even without that other book. In that
case, the short story is not a derived work - it's only inspired.

Notice? This is actually _exactly_ what I've been arguing all along,
except I've been arguing with a technical audience, so I've been using
technical examples and terminology. But my argument is that just the fact
that somebody compiled the code for Linux into a binary module that is
useless without a particular version of the kernel DOES MAKE IT A DERIVED
WORK.

But also note how it's only the BINARY MODULE that is a derived work. Your
source code is _not_ necessarily a derived work, and if you compile it for
another operating system, I'd clearly not complain.

This is the "stand-alone short story" vs "extra chapter without meaning
outside the book" argument. See? One is a work in its own right, the other
isn't.

			Linus
