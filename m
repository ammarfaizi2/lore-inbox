Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264389AbUEXT5h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264389AbUEXT5h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 15:57:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264113AbUEXT5h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 15:57:37 -0400
Received: from zero.aec.at ([193.170.194.10]:35077 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S264430AbUEXT5e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 15:57:34 -0400
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFD] Explicitly documenting patch submission
References: <1YUY7-6fF-11@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Mon, 24 May 2004 21:57:31 +0200
In-Reply-To: <1YUY7-6fF-11@gated-at.bofh.it> (Linus Torvalds's message of
 "Sun, 23 May 2004 08:50:07 +0200")
Message-ID: <m3fz9pd2dw.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> Hola!
>
> This is a request for discussion..

What's not completely clear to me is how the Signed-off-by
header is related to this:

> 	Developer's Certificate of Origin 1.0
[...]

I assume you're not expecting that people actually print out and sign
this and send it somewhere?

You're just asking that they read it and confirm to the maintainer
that they did, right?

e.g. consider some first contributor sends a maintainer a patch to be
incorporated.  Do you expect people now to send them this
Certification of Origin back and ask "Do you agree to this?"  
and only add the patch after they sent back an email "Yes I agree to this"?

That sounds quite involved to me. I bet in some companies this 
Certificate would first be sent to the legal department for approval,
delaying the patch for a long time

Even without such an explicit agreement it could get quite
complicated to figure out what to put into the Signed-off-by
lines if they're not already there.

e.g. normally the maintainer would just answer "ok, looks good,
applied". Now they would need to ask "ok, did you write this. if not
through which hands did it pass"? and wait for a reply and then only
add the patch when you know whom to put into all these Signed-off-by
lines.

This is not unrealistic, For example for patches that are "official
projects" by someone it often happens that not the actual submitter
sends the patch, but his manager (often not even cc'ing the original
developer). In some cases companies even go through huge efforts to
keep the original developers secret (I won't give names here, but it
happens). That's of course not because they stole anything, but
because they have some silly NDAs in place regarding not giving out
names of partners they're talking to or they just don't want you to
learn too much about their internals.

I would have no problems with just putting a Signed-Off-By for me
and for the person who sent me the patch, but trying to find out
all the people through whose mailboxes the patch travelled earlier
is potentially quite a lot of work. I am not sure I really 
want to get into that business.

I also don't think it's realistic to expect that everybody who
submits patches will put in all the right Signed-Off-Bys on their own,
so requiring the full path would put the maintainers into the 
situation outlined above.

Just alone asking them to agree to the Certificate of Origin would 
be probably a lot of work.

I don't think any solution that requires significantly more work
on part of the maintainer will be a good idea.

-Andi

