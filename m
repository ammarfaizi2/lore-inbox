Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262478AbUCHMYW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 07:24:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262480AbUCHMYW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 07:24:22 -0500
Received: from zadnik.org ([194.12.244.90]:62602 "EHLO lugburz.zadnik.org")
	by vger.kernel.org with ESMTP id S262478AbUCHMYN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 07:24:13 -0500
Date: Mon, 8 Mar 2004 14:23:43 +0200 (EET)
From: Grigor Gatchev <grigor@serdica.org>
X-X-Sender: grigor@lugburz.zadnik.org
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: Christer Weinigel <christer@weinigel.se>, <linux-kernel@vger.kernel.org>
Subject: Re: A Layered Kernel: Proposal
In-Reply-To: <404BE46F.1000000@matchmail.com>
Message-ID: <Pine.LNX.4.44.0403081311020.21912-100000@lugburz.zadnik.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 7 Mar 2004, Mike Fedyk wrote:

> Grigor Gatchev wrote:
> > Here it is. Get your axe ready! :-)
> >
> > ---
> >
> > Driver Model Types: A Short Description.
> >
> > (Note:  This is NOT a complete description of a layer,
> > according to the kernel layered model I dared to offer.  It
> > concerns only the hardware drivers in a kernel.)
> >
>
> Looks like you're going to need to get a little deeper to keep it from
> being OT on this list.
>
> What is the driver designs of say, solaris, OS/2, Win32 (NT & 9x trees)
> and how are they good and how are they bad?
>
> What specific (think API changes, nothing generalized here *at all*)
> changes could benefit linux, and why and how?  Nobody will listen to
> hand waving, so you need a tight case for each change.
>
> HTH,
>
> Mike

Dear Mike,

An year ago, I was teaching a course on UNIX security. After the
first hour, a student - military man with experience of commanding PC-DOS
users - interrupted me: "What is all that mumbo-jumbo about? Users,
groups, permissions - all this is empty words, noise! Don't you at least
classify your terminal, and issue orders on who uses it? Man, either talk
some real stuff, or I am not wasting anymore my time on you!"

Of course, I was happy to let him "stop wasting his time on me".

Reading some of the posts here, I get this deja vu. I know the driver
designs of some OS, and don't know others. I may waste a month or two of
work, and post a huge description of all big OS driver models that I
know, or waste an year of work, and give you a description of all big OS
driver models. Will this give you anything more than what was already
posted? Wouldn't you read my hundreds of pages, then try to summarise all,
and eventually come to the same?

Or you will try to pick this from one model, that from another, and end up
assembling a creature with eagle wings, dinosaur teeth, anthelope legs and
shark fins, and wondering why it can neither fly nor run nor swim really
well, why it has bad performance? This can't be, I must have misunderstood
you.

Also, does "think API changes, nothing generalised *at all*" mean anything
different from "think code, no design *at all*"? If this is some practical
joke, it is not funny. (I can't believe that a kernel programmer will not
know why design is needed, where is its place in the production of a
software, and how it should and how it should not be done.)

OK. Let's try explain it once more:

While coding, think coding. While designing, think designing. Design comes
before coding; otherwise you design while coding, and produce a mess.
Enough of such an experience, and you start believing that design without
coding is empty words, noise. Hand waving.

What I gave is more than enough to start designing a good driver model.
After the design is OKed, details of implementation, eg. API changes, may
be developed. Developing them now, however, is the wrong time, for the
reasons explained just above. Let's not put the cart ahead of the horse.

Or I am wrong?


