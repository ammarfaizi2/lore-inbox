Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264686AbUEXUce@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264686AbUEXUce (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 16:32:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264685AbUEXUce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 16:32:34 -0400
Received: from fw.osdl.org ([65.172.181.6]:57273 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264688AbUEXUcB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 16:32:01 -0400
Date: Mon, 24 May 2004 13:31:49 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andi Kleen <ak@muc.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFD] Explicitly documenting patch submission
In-Reply-To: <m3fz9pd2dw.fsf@averell.firstfloor.org>
Message-ID: <Pine.LNX.4.58.0405241326400.32189@ppc970.osdl.org>
References: <1YUY7-6fF-11@gated-at.bofh.it> <m3fz9pd2dw.fsf@averell.firstfloor.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 24 May 2004, Andi Kleen wrote:
>
> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > Hola!
> >
> > This is a request for discussion..
> 
> What's not completely clear to me is how the Signed-off-by
> header is related to this:
> 
> > 	Developer's Certificate of Origin 1.0
> [...]
> 
> I assume you're not expecting that people actually print out and sign
> this and send it somewhere?

No. 

> You're just asking that they read it and confirm to the maintainer
> that they did, right?

Right. We'd add it to the Documentation directory, and add pointers to it 
to anything that mentions the "Signed-off-by:" thing (eg things like 
SubmittingPatches). All just to make sure that people are aware of what it 
means to say "Signed-off-by:"

> That sounds quite involved to me. I bet in some companies this 
> Certificate would first be sent to the legal department for approval,
> delaying the patch for a long time

Having worked at a company like that, I can say that that is true pretty 
much regardless of what the patch submission is (it's about a million 
times _worse_ if you have something like the FSF copyright assignment 
thing, but it's certainly true even for random open source things that 
don't have the physical paperwork and copyright assignment).

> e.g. normally the maintainer would just answer "ok, looks good,
> applied". Now they would need to ask "ok, did you write this. if not
> through which hands did it pass"? and wait for a reply and then only
> add the patch when you know whom to put into all these Signed-off-by
> lines.

No. The point is that a maintainer does NOT need to do this, exactly 
because we'd try to educate people to have the "Signed-off-by:" line pass 
with the patch from the very beginning.

> This is not unrealistic, For example for patches that are "official
> projects" by someone it often happens that not the actual submitter
> sends the patch, but his manager (often not even cc'ing the original
> developer). In some cases companies even go through huge efforts to
> keep the original developers secret (I won't give names here, but it
> happens).

Absolutely. And the whole sign-off procedure is _designed_ for this. 

The person who signs off on a patch does not need to be the author: in 
fact at a company that has "release people", it's not _supposed_ to be the 
author, it's supposed to be the company release person (although the 
original author may well have signed off on it internally - but that's not 
somethign that an external maintainer would know about or even care 
about).

			Linus
