Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261590AbVGDBO1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261590AbVGDBO1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 21:14:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261591AbVGDBO1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 21:14:27 -0400
Received: from atpro.com ([12.161.0.3]:5135 "EHLO atpro.com")
	by vger.kernel.org with ESMTP id S261590AbVGDBOO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 21:14:14 -0400
From: "Jim Crilly" <jim@why.dont.jablowme.net>
Date: Sun, 3 Jul 2005 21:13:31 -0400
To: Ed Cogburn <edcogburn@hotpop.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: reiser4 vs politics: linux misses out again
Message-ID: <20050704011330.GG4907@voodoo>
Mail-Followup-To: Ed Cogburn <edcogburn@hotpop.com>,
	linux-kernel@vger.kernel.org
References: <1120134372.42c3e4e49e610@webmail.bur.st> <20050630153326.GB24468@voodoo> <20050630160244.GV11013@nysv.org> <20050630180959.GC24468@voodoo> <da61a8$il6$1@sea.gmane.org> <20050702215645.GB4907@voodoo> <da9sfg$nt8$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da9sfg$nt8$1@sea.gmane.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/05 07:30:57PM -0400, Ed Cogburn wrote:
> Jim Crilly wrote:
> 
> > On 07/02/05 09:05:41AM -0400, Ed Cogburn wrote:
> >> Jim Crilly wrote:
> >> 
> >> Assuming "fast and cool" here equates to some level of improvement to the
> >> existing kernel, and/or new features/capabilities not currently
> >> available, then are you saying "fast and cool" isn't good enough anymore,
> >> you now have to be politically correct and socially popular and a master
> >> brown-noser as well to get code into the kernel even just on an
> >> *experimental* basis?
> > 
> > Fast and cool by themselves shouldn't be good enough, infact fast could
> > definately be optional
> 
> 
> And please point out where anyone has said ANYWHERE that R4 is going to be
> FORCED on people!  Stop accusing Hans of refusing to answer relevent points
> when you're doing the same damn thing.
> 

>From a user's standpoint, no of course not. But once it's included in the
mainline it's forced upon the kernel maintainers and if parts of it are
used to extend the VFS it's forced upon even more of the kernel
maintainers.

And when have I ever accused Hans of anything?

> 
> > Obviously you don't care about the code
> 
> 
> Bullshit.  If the code doesn't work or is unstable or unmaintained then
> everyone is concerned.  BUT THOSE ARE NOT THE ISSUES HERE.  Maybe Hans will
> be a little more sociable towards you when you guys start being a little
> more sociable towards him, or maybe he's just a jerk and will never change,
> I don't know, and frankly I don't care, but R4 deserves its shot anyway
> based just on its potential alone.  Its reached the point where it can only
> get better with more *exposure*, and as I said in my response to Christoph,
> -mm is not the place to get exposure from a wider audience, due to its
> instability, even Andrew has said his -mm tree isn't meant to be a "stable"
> kernel series.
> 

Yes, they are the issues. But I believe most of the big problems have been
fixed (i.e. things like R4 containing it's own hashing library instead of
using what's already in the kernel) in the original thread. And from what I
remember of the R3 saga back right after the 2.4.0 release, this looks
extremely familiar so I really doubt Hans will be changing any time soon.

And I agree that -mm is too unstable for R4 to get serious testing there,
the few times I gave it a try I always had more than one problem that
forced me back to -linus with a few custom patches.

> In the meantime, if a fork does happen, I'm going with the one that gives
> good ideas their chance at the mainstream no matter who the author is.  If
> you guys really want to kill the Linux success story, just keep right on
> putting your ego and personal feelings in front of what's good for the
> users and good for the success of Linux outside your elite club.  And
> before you tell yourself that the users don't matter, you'd better ask
> around among all the *other* developers here why *they* are working on
> Linux now, and not a BSD, or another fork of Linux.  Hint: many are
> employed by companies whose customer's are ... Linux *USERS*.  Linux's
> initial success was not pre-ordained or guaranteed, it was accomplished
> because a core group of people started WORKING TOGETHER with a common
> vision, if you now decide to forget what got you to this point, I GUARANTEE
> YOU that the success of your version of Linux will not continue.
> 

I think you're putting too much of an idealogical spin on the history of
Linux. And I seem to remember a lot of people claiming that R3 was the
filesystem of the future back around it's release as well and as far as I
can tell there's only a few major distributions that support R3 at all. 

If R4 isn't included it won't kill anything and if anything these
discussions have already gotten people thinking about new things that can
be done at the VFS level, so I wouldn't be surprised if we see VFS plugins
to handle things like on the fly compression whether R4 is included or not.

> I know there are technical issues, in a few places by a few people, like the
> thread Andrew started, they are still being discussed, but when we reach
> the point where people say "fast and cool" is not good or desirable
> anymore, without realizing how absurd that sounds, then the dispute has
> clearly gone beyond the technical, and into the realm of the ego
> stratosphere.  Believe it or not Jim, but I'm absolutely sure Hans really
> wants whats best for Linux in the long run just as you do.  R4 deserves its
> chance, so find a way to make it work, and that goes to Hans too.
> 

I still believe that "fast and cool" alone isn't enough. If someone were to
offer to sell you car that looked extremely cool and was outrageously fast
to the tune of like 2000hp would you buy it without thinking or would you 
want to make sure it had other important features like anti-lock breaks, 
airbags and someone who understands the engine enough to fix it when
something gets broke?

> Thank you all for bearing through this rant...
> 
> Flame retardant attire now in place, you may fire at your convenience
> gentlemen.  :)

Jim.
