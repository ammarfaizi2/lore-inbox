Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264270AbUGFS4e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264270AbUGFS4e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 14:56:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264296AbUGFS4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 14:56:34 -0400
Received: from mlf.linux.rulez.org ([192.188.244.13]:6666 "EHLO
	mlf.linux.rulez.org") by vger.kernel.org with ESMTP id S264270AbUGFS4Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 14:56:25 -0400
Date: Tue, 6 Jul 2004 20:56:22 +0200 (MEST)
From: Szakacsits Szabolcs <szaka@sienet.hu>
To: Andries Brouwer <Andries.Brouwer@cwi.nl>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Andries Brouwer <aebr@win.tue.nl>,
       "Patrick J. LoPresti" <patl@users.sourceforge.net>, bug-parted@gnu.org,
       Steffen Winterfeldt <snwint@suse.de>, Thomas Fehr <fehr@suse.de>,
       linux-kernel@vger.kernel.org, Andrew Clausen <clausen@gnu.org>,
       buytenh@gnu.org, msw@redhat.com
Subject: Re: Restoring HDIO_GETGEO semantics for 2.6 (was: Re: [RFC] Restoring
 HDIO_GETGEO semantics)
In-Reply-To: <20040706015620.GA12659@apps.cwi.nl>
Message-ID: <Pine.LNX.4.21.0407061811090.4511-100000@mlf.linux.rulez.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 6 Jul 2004, Andries Brouwer wrote:

> We agree about most of the facts, and I am too lazy to quarrel anyway.

I only waited for straight, technical answers what you always avoided.
When you answer, you repeat off-topic or too general things. This is not
enough to make a competent, responsible decision to soften the damage 2.6
kernels cause.

> Such a waste of time. But we draw different conclusions.

Please point out where I draw a conclusion? When I wrote RFC (request for
comments)? Or "restoring" (implying attention for discussion). I've never
written "restore!" (imperative mood).

Or when you or anybody else failed to give any reasonable technical answer
why not to restore, I wrote (unfortunately in pretty broken English, but I
hope it was still understandable, so no change now either),

  "it seems logical from practical point of view, that the restoration of
   the old HDIO_GETGEO functionality (or something that's very close to
   its behaviour) _temporarily_ for 2.6 kernels makes sense."

In this context, the important words are "seems" and "make sense". It's
still a suggestion based on the collected information. At least that's
what I've meant.

Explanation: it's pretty impossible to make any conclusion when you don't
provide straight answers. 

> We discover that the present combination of 2.6 and parted is
> unfortunate. Because of bugs in parted. 

And because of the 2.4 -> 2.6 HDIO_GETGEO _semantic_ change.

> OK - so lets fix them.

That's what people are waiting for over 8 months, at least. Both needs
handling, not only one.

> You prefer a larger change to the kernel above a smaller change
> to parted, 

These are your words, again, not mine. Read here what I wrote and if you
still don't understand, no problem I'll try to write it down a different
way,

   http://groups.google.com/groups?selm=2eAC2-7Zf-7%40gated-at.bofh.it

At the same time I also apologize for the tree separate, big capital
words. I've meant them to emphasize visually, too, that there are
fundamentally _three_ different things to solve. If one shouts, then 
HE USUALLY CAPITALIZES MANY WORDS NEXT TO EACH OTHER. But I've never 
did, never will! Not even in this email for demonstration! ;)

So, please check the email out again because you answered the two
off-topic problems and gave an off-topic answer for the on-topic one. 
I also recommend going through the old emails by reading them much more
carefully and then thinking about them a bit. Please also don't forget 
to check out the mentioned URL's, links, reading user comments.

Of course, only if you care about the issue on the _kernel_ side.

> the change to the kernel makes the kernel buggier.

This was your most productive comment so far in the subject ;)

Why does it make the kernel buggier? Please detail. Deeply, technically.
Many of us would greatly appreciate. Seriously. But not the general, too
high level way, you explained over the last two years and to Jeff last
time. That's not enough in the current situation.

You mentioned a RAID that needs the 2.6 geometry. What's that? Would it
break by the change? Could it be fixed? Could something else break?

Why don't you even consider the temporary restoration when you keep saying
geometry doesn't exist, geometry doesn't matter? If it didn't matter then
it can be anything, so why not the one that doesn't break compatibility?
We would have much less data loss, just as with 2.4 kernels.

What would happen if it returns 0? How current [lib]parted handles
it? Other things? 

> You say that other utilities are affected. Maybe, yes. So let us look
> at them. In the time spent writing all these letters we probably could
> have fixed a few.

Sorry, off-topic. This thread is not about patching utilities. Please keep
the subject.

	Szaka

