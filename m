Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750972AbVLGMfw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750972AbVLGMfw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 07:35:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750973AbVLGMfw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 07:35:52 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:9889 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750966AbVLGMfv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 07:35:51 -0500
Date: Wed, 7 Dec 2005 13:34:59 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: James Bruce <bruce@andrew.cmu.edu>
cc: David Lang <david.lang@digitalinsight.com>,
       Kyle Moffett <mrmacman_g4@mac.com>,
       Steven Rostedt <rostedt@goodmis.org>, johnstul@us.ibm.com,
       george@mvista.com, mingo@elte.hu, akpm@osdl.org,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       ray-gmail@madrabbit.org, Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [patch 00/43] ktimer reworked
In-Reply-To: <4396ACF5.3050204@andrew.cmu.edu>
Message-ID: <Pine.LNX.4.61.0512071319320.1609@scrub.home>
References: dlang@dlang.diginsite.com <Pine.LNX.4.62.0512011734020.10276@qynat.qvtvafvgr.pbz>
 <Pine.LNX.4.61.0512021124360.1609@scrub.home> <4396ACF5.3050204@andrew.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 7 Dec 2005, James Bruce wrote:

> > Guys, before you continue spreading nonsense, please read carefully Ingos
> > description of the timer wheel at http://lwn.net/Articles/156329/ .
> > Let me also refine the statement I made in this mail: the _focus_ on
> > delivery is complete nonsense.
> 
> Must you start every email with inflammatory rhetoric?  If you want to know
> why you find it difficult to get people to see things your way, the key is in
> the above paragraph.  In everyday life you don't insult a person on the street
> and then ask them for directions.

You analogy is wrong: Thomas and Ingo spread flyer for "free food", above 
is my frustration about all the people wanting free food.

> And that's the whole *point* about how we got here.  Let the low resolution,
> low lifetime timeouts stay on the timer wheel, and make a new approach that
> specializes in handling longer lifetime, higher resolution timers.  That's
> ktimers in a nutshell.  You seem to be arguing for it rather than against it.

I do, just without the focus on the lifetime, which is really unimportant 
for most kernel developers.

> You've brought up the fact that networking shouldn't use lots of timers
> several times in the overall discussion.  If you know how to do this, I'm sure
> you can start sending patches to netdev and show them all how stupid they've
> been all along.  However, more likely you'll just find out that just maybe the
> networking people really *have* thought about the problem, and the solution
> they came up with is actually a pretty good one.
> 
> At any rate, while you fix up all those "timer-abusing" subsystems throughout
> the kernel, can we just try to improve the timer system in the meantime?

James, after giving me a rhetoric lesson you maybe should be a bit more
careful with your own rhetoric. What kind of answer do you expect after 
insulting me?

The short version is that I didn't bring up the network timer problem, I 
only made a suggestions how it could be solved, but nobody followed me up 
on it, so I guess the problem wasn't really that big. Please check the 
archives for details.

bye, Roman
