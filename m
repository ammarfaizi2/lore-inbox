Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751160AbVLHNJM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbVLHNJM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 08:09:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbVLHNJM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 08:09:12 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:34730 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751160AbVLHNJL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 08:09:11 -0500
Date: Thu, 8 Dec 2005 14:08:55 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Ingo Molnar <mingo@elte.hu>
cc: tglx@linutronix.de, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, rostedt@goodmis.org, johnstul@us.ibm.com
Subject: Re: [patch 00/21] hrtimer - High-resolution timer subsystem
In-Reply-To: <20051208092629.GC21696@elte.hu>
Message-ID: <Pine.LNX.4.61.0512081106570.1609@scrub.home>
References: <20051206000126.589223000@tglx.tec.linutronix.de>
 <Pine.LNX.4.61.0512061628050.1610@scrub.home> <20051206190713.GA8363@elte.hu>
 <Pine.LNX.4.61.0512062030570.1610@scrub.home> <20051208092629.GC21696@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 8 Dec 2005, Ingo Molnar wrote:

> Here are a few snippets from you that show that most of the negative 
> messaging from you was directed against the text Thomas wrote (or 
> against Thomas), not against the code:

Do you really think quoting me out of context is helping? From my 
perspective you're trying to show me now as the bad guy and I'm not 
accepting that. I don't know what you're trying to do, if you're trying to 
mediate, then you're really suck at it, if you just want to piss me off, 
it's working great. :-(

Technically I still stand behind everything I said in that context, in the 
meantime I learned a few new things and I understand them better, so 
some things have become nonissues and I even changed my mind about some 
other things.
OTOH I'm the first to admit that I could have said things nicer, but mail 
is a rather bad channel to transport emotions and whatever I say can be 
taken badly. I really try my best to avoid this, but sometimes it's really 
hard, especially if I can't get past the initial resentment. I gladly 
apologize for any mistake I did and I'll do my best to learn from it, but 
I'm not going to make amends for it forever. At some point it would be 
really nice if you stopped to rub it in what a insensitive clod I am, I 
know that already. 
Ingo, if you want to help me, why don't you go with a good example ahead 
and I'll try to follow you. How about this?

> > > > [...] So Thomas, please get over yourself and start talking.
> > 
> > I must say it's completely beyond me how this could be "insulting".  
> 
> maybe it is insulting because the "get over yourself" implicitly 
> suggests that the fault is with Thomas?

This is a nice example, that _whatever_ I'm saying can be misunderstood. 
Why don't you even try to give me a little credit that above was not meant 
as insult? You make an assumption about what I said and you don't even 
give me a chance to correct myself.
Thomas obviously has some kind of problem with me and unless he starts to 
talk to me, I can't help him to get over whatever problem that is. I'm 
not going away, so we have to get along somehow and this means we have to 
_talk_.
Ingo, you only want to see the "get over yourself" part, whereas my 
emphasis was and is on "talking".

> just try it, really. Even if it's a bold faced lie ;)

I'm a bad liar and as long as I don't know what the problem is, I'll make 
the same mistake over and over. I have no intention of becoming a 
notorious liar.

> Thomas wrote you 11 replies in 2.5 months, and some of those were 
> extremely detailed. That's a far cry from not talking at all.

Some of it was indeed more verbose, but I never got very far with my 
followup questions. Thomas used very often a phrase like "we analyzed the 
problem and we came to the conclusion...". It's great that you and Thomas 
get so well along with each other, but I'm in the disadvantage that I lack 
the information context that you have. What is "extremely detailed" for 
you is lacking context to create a coherent picture for me, so it's 
sometimes really frustrating to pull some information out of you both.

> also, what did you expect? Basically you came out with a patch-queue
> based on ktimers, but you did not send any changes against the ktimers
> patch itself, which made it very hard to map the real finegrained
> changes you did to ktimers.

At the time I only had the huge ktimers patch from -mm to work with.
One primary target was to split out the core (without all the extra 
complexity and extra cleanups) into mergable pieces, which makes it a bit 
pointless to do it relative to this huge patch.
The other main target was the resolution handling, I tried very hard to 
explain the details of it and why I did them this way. A discussion about 
this would have required a _direct_ response, where you point out with 
what you disagree. Random comments in other mails are not helping at all.
The rest are some smaller patches, which are completely independent of 
hrtimer, but even for this I got no response except from Oleg.

> You provided a writeup of differences, but
> they did not fully cover the full scope of changes, relative to ktimers.

I've seen this claim now a few times, but why the hell don't you just ask 
about the things that you think were missing?

bye, Roman
