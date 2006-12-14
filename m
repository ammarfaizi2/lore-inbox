Return-Path: <linux-kernel-owner+w=401wt.eu-S1751169AbWLNEQk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbWLNEQk (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 23:16:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750971AbWLNEQk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 23:16:40 -0500
Received: from smtp.osdl.org ([65.172.181.25]:46977 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751075AbWLNEQj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 23:16:39 -0500
Date: Wed, 13 Dec 2006 20:15:59 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Greg KH <gregkh@suse.de>
cc: Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@osdl.org>,
       Martin Bligh <mbligh@mbligh.org>,
       "Michael K. Edwards" <medwards.linux@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: GPL only modules [was Re: [GIT PATCH] more Driver core patches
 for 2.6.19]
In-Reply-To: <20061214005532.GA12790@suse.de>
Message-ID: <Pine.LNX.4.64.0612131954530.5718@woody.osdl.org>
References: <20061214003246.GA12162@suse.de> <22299.1166057009@lwn.net>
 <20061214005532.GA12790@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 13 Dec 2006, Greg KH wrote:
> 
> Numerous kernel developers feel that loading non-GPL drivers into the
> kernel violates the license of the kernel and their copyright.  Because
> of this, a one year notice for everyone to address any non-GPL
> compatible modules has been set.

Btw, I really think this is shortsighted.

It will only result in _exactly_ the crap we were just trying to avoid, 
namely stupid "shell game" drivers that don't actually help anything at 
all, and move code into user space instead.

What was the point again?

Was the point to alienate people by showing how we're less about the 
technology than about licenses?

Was the point to show that we think we can extend our reach past derived 
work boundaries by just saying so? 

The silly thing is, the people who tend to push most for this are the 
exact SAME people who say that the RIAA etc should not be able to tell 
people what to do with the music copyrights that they own, and that the 
DMCA is bad because it puts technical limits over the rights expressly 
granted by copyright law.

Doesn't anybody else see that as being hypocritical?

So it's ok when we do it, but bad when other people do it? Somehow I'm not 
surprised, but I still think it's sad how you guys are showing a marked 
two-facedness about this.

The fact is, the reason I don't think we should force the issue is very 
simple: copyright law is simply _better_off_ when you honor the admittedly 
gray issue of "derived work". It's gray. It's not black-and-white. But 
being gray is _good_. Putting artificial black-and-white technical 
counter-measures is actually bad. It's bad when the RIAA does it, it's bad 
when anybody else does it.

If a module arguably isn't a derived work, we simply shouldn't try to say 
that its authors have to conform to our worldview.

We should make decisions on TECHNICAL MERIT. And this one is clearly being 
pushed on anything but.

I happen to believe that there shouldn't be technical measures that keep 
me from watching my DVD or listening to my music on whatever device I damn 
well please. Fair use, man. But it should go the other way too: we should 
not try to assert _our_ copyright rules on other peoples code that wasn't 
derived from ours, or assert _our_ technical measures that keep people 
from combining things their way.

If people take our code, they'd better behave according to our rules. But 
we shouldn't have to behave according to the RIAA rules just because we 
_listen_ to their music. Similarly, nobody should be forced to behave 
according to our rules just because they _use_ our system. 

There's a big difference between "copy" and "use". It's exatcly the same 
issue whether it's music or code. You can't re-distribute other peoples 
music (becuase it's _their_ copyright), but they shouldn't put limits on 
how you personally _use_ it (because it's _your_ life).

Same goes for code. Copyright is about _distribution_, not about use. We 
shouldn't limit how people use the code.

Oh, well. I realize nobody is likely going to listen to me, and everybody 
has their opinion set in stone. 

That said, I'm going to suggest that you people talk to your COMPANY 
LAWYERS on this, and I'm personally not going to merge that particular 
code unless you can convince the people you work for to merge it first.

In other words, you guys know my stance. I'll not fight the combined 
opinion of other kernel developers, but I sure as hell won't be the first 
to merge this, and I sure as hell won't have _my_ tree be the one that 
causes this to happen.

So go get it merged in the Ubuntu, (Open)SuSE and RHEL and Fedora trees 
first. This is not something where we use my tree as a way to get it to 
other trees. This is something where the push had better come from the 
other direction.

Because I think it's stupid. So use somebody else than me to push your 
political agendas, please.

		Linus
