Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265581AbSKTClO>; Tue, 19 Nov 2002 21:41:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265578AbSKTClN>; Tue, 19 Nov 2002 21:41:13 -0500
Received: from 208-135-136-018.customer.apci.net ([208.135.136.18]:24844 "EHLO
	blessed.joshisanerd.com") by vger.kernel.org with ESMTP
	id <S265581AbSKTClM>; Tue, 19 Nov 2002 21:41:12 -0500
Date: Tue, 19 Nov 2002 20:48:06 -0600 (CST)
From: Josh Myer <jbm@joshisanerd.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: spinlocks, the GPL, and binary-only modules
In-Reply-To: <Pine.LNX.4.44L.0211192349460.4103-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.4.44.0211192036530.30881-100000@blessed.joshisanerd.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Nov 2002, Rik van Riel wrote:
> On Tue, 19 Nov 2002, Jeff Garzik wrote:
> > But who knows if #include'd code constitutes a derived work :(
>
> Only if the #included snippets of code are large enough to be
> protected by copyright, which might be true of the stuff in
> mm_inline.h and of some of the semaphore code, but probably
> isn't true of the spinlock code.
>

(US-Centric, since that's where I'm from, live, and code)

Since you're functionally using it, and it's not a protected use (Satire,
etc, though some would argue that the nvidia drivers are a mockery...), I
would tend to think Fair Use wouldn't apply in this case. Are there any IP
Lawyers in the house?

The only analogy i can think of is a remix of songs, and several people
have gotten into wonderfully large lawsuits over that.

> Even if the code #included is large enough to be protected by
> copyright I don't know if the code including it would be considered
> a derived work. Many questions remaining...
>

This basically all falls upon the shoulders of whoever wrote the spinlock
code on whatever platform you're compiling for...

At this point, I think it's safe to say that the days of the legally
unencumbered binary-only module (read: binary-only modules you aren't
liable to get sued for) are numbered. Personally, I'm a little
saddened at the loss of openness, but won't miss weird binary-only
problems.
--
/jbm, but you can call me Josh. Really, you can!
 "What's a metaphor?" "For sheep to graze in"
7958 1C1C 306A CDF8 4468  3EDE 1F93 F49D 5FA1 49C4




