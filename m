Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264311AbTLERes (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 12:34:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264315AbTLERes
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 12:34:48 -0500
Received: from fw.osdl.org ([65.172.181.6]:65500 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264311AbTLEReq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 12:34:46 -0500
Date: Fri, 5 Dec 2003 09:34:42 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Shawn Willden <shawn-lkml@willden.org>
cc: linux-kernel@vger.kernel.org, Ryan Anderson <ryan@michonline.com>
Subject: Re: Linux GPL and binary module exception clause?
In-Reply-To: <200312050938.10607.shawn-lkml@willden.org>
Message-ID: <Pine.LNX.4.58.0312050921500.9125@home.osdl.org>
References: <Pine.LNX.4.58.0312042245350.9125@home.osdl.org>
 <MDEHLPKNGKAHNMBLJOLKAEJHIHAA.davids@webmaster.com> <20031205140304.GF17870@michonline.com>
 <200312050938.10607.shawn-lkml@willden.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 5 Dec 2003, Shawn Willden wrote:
>
> So copies to disk and RAM that are "an essential step in the utilization of
> the computer program" are non-infringing.

Absolutely. But you don't have the right to distribute them.

Put another way: nVidia by _law_ has the right to do whatever essential
step they need to be able to run Linux on their machines. That's what the
exception to copyright law requires for any piece of software.

And in fact you should be damn happy for that exception, because that
exception is also what makes things like emulators legal - software houses
can't claim that you can't use an emulator to run their programs (well,
they may _try_, but I don't know if it ever gets to court).

But what they do NOT have the right to do is to create derivative works of
the kernel, and distribute them to others. That act of distribution is not
essential _for_them_ to utilize the kernel program (while the act of
_receiving_ the module and using it may be - so the recipient may well be
in the clear).

So in order for nVidia to be able to legally distribute a binary-only
kernel module, they have to be able to feel damn sure that they can
explain (in a court of law, if necessary) that the module isn't a derived
work. Enough to convince a judge. That's really all that matters. Our
blathering matters not at all.

Now, personally, I have my own judgment on what "derivative works" are,
and I use that judgement to decide if I'd complain or take the matter
further.

And so _I_ personally think some binary modules are ok, and you've heard
my arguments as to why. That means that _I_ won't sue over such uses,
since in my opinion there is no copyright infringement IN THOSE CASES due
to me not considering them derivative.

My opinions are fairly public, and the stuff I say in public actually does
have legal weight in that it limits what I can do (if I say in public that
I think something is ok, I have a much harder time then making the
argument that it _isn't_ ok in front of a judge - this is what the
"estoppel" thing is all about).

But the thing is, my public opinions don't bind anybody else. So if Alan
Cox, or _any_ other kernel copyright holder, disagrees with me (and trust
me, people do), they have the right to complain on their own. Their case
would be weakened by my stance (simply because a defendant could point to
my opinions and the judge might be swayed by that).

And quite frankly, my largest reason for not complaining loudly has often
been that I'm lazy, and in several cases of sme people using GPL'd work
improperly I have been ready to join a lawsuit that somebody else
initiates. So far people have tended to back down.

			Linus
