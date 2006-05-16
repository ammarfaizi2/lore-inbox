Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751846AbWEPQPT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751846AbWEPQPT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 12:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751850AbWEPQPS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 12:15:18 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:31960 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751846AbWEPQPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 12:15:17 -0400
Date: Tue, 16 May 2006 12:14:58 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Jakob Oestergaard <jakob@unthought.net>
cc: Marc Perkel <marc@perkel.com>, linux-kernel@vger.kernel.org
Subject: Re: Wiretapping Linux?
In-Reply-To: <20060516144044.GJ15032@unthought.net>
Message-ID: <Pine.LNX.4.58.0605161153080.13832@gandalf.stny.rr.com>
References: <4469D296.8060908@perkel.com> <Pine.LNX.4.58.0605160939290.10890@gandalf.stny.rr.com>
 <20060516144044.GJ15032@unthought.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 16 May 2006, Jakob Oestergaard wrote:

>
> Read "Reflections on Trusting Trust" to see why compiling things from
> source gets you absolutely *zero* extra security in this regard.
>
> http://www.acm.org/classics/sep95/
>

Interesting article, and thanks for the link.  In your *zero* extra
security comment, I still disagree.

Nothing is secure, but having the soure at least stops those that are not
as capable as Ken Thompson and Dennis Ritchie.  OK, I'm sure lesser
programmers could also do it.  But it limits the script kiddies that can
do easy and obvious stuff if they had access to modify the source of
closed source software.

But the source does help when lots of users are using it and seeing it.
So when a bug happens, anyone can fix it.  In this act, the backdoor can
be discovered.  Where close source doesn't have that luxury, since the one
who put the backdoor in would probably be the same programmer to fix the
bug.

Now, to bring up Marc's point about the NSA.  They do have very clever
people.  But usually the open source projects are a community of people,
and you have to first get trusted in what you do before it gets submitted
into the code.  And if someone discovers that you planted a backdoor, that
would discredit you quite badly.

I also do lots of sniffing of my networks to see if suspicious packets are
floating around, as well as nmapping my computers to know that all ports
that are open are open to tools that I know about.  And there has been
times I didn't like what I saw from the program and looked at the source
to see what was up, and then discovered it was nothing.

Again, this is not perfect, and I can still be fooled, but I trust it
_more_ than I would if I didn't have access to the source.  So, I agree
that open source is still not secure. I still think it's more secure than
close source, just because it's harder to get things by people.

-- Steve

