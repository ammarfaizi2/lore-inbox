Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313087AbSDTStF>; Sat, 20 Apr 2002 14:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313089AbSDTStE>; Sat, 20 Apr 2002 14:49:04 -0400
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:11 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S313087AbSDTStA>; Sat, 20 Apr 2002 14:49:00 -0400
Date: Sat, 20 Apr 2002 19:48:51 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove Bitkeeper documentation from Linux tree
Message-ID: <20020420194851.A8051@flint.arm.linux.org.uk>
In-Reply-To: <E16ya3u-0000RG-00@starship> <m1elha45q0.fsf@frodo.biederman.org> <E16ycuh-0000Wg-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2002 at 08:15:14PM +0200, Daniel Phillips wrote:
> All of what you said, 100% agreed, and insightful, in particular:
> 
> On Saturday 20 April 2002 19:53, Eric W. Biederman wrote:
> > I can see the potential for this to break down.  However we should
> > not be crying wolf until this actually does break down.
> 
> Do we want it to break down first?  I don't want that.

Actually, you yourself have probably sewn the first seeds of the community
breaking down.  Lets take a moment to put some thought in at this point
and review what's happened today.

1. The Current Situation

   - Linus uses BK
   - Linus makes his BK tree available.
   - Linus makes GNU patches available.
   - Linus accepts requests to pull from BK trees.
   - Linus accepts GNU patches to apply to his BK tree.

2. The effect of today

   - You've highlighted a problem
   - David Woodhouse and Rik van Riel have written a tool to grab Linus'
     BK tree and turn it into a patch on a per-hourly basis

Now look back at Linus' actions above.  There is now redundancy.  Linus
doesn't have to put out GNU patches anymore because someone else is
doing that for him...  which means Linus works more efficiently.

So it's highly likely that in the future, we'll have:

   - Linus uses BK
   - Linus makes his BK tree available
   - Linus accepts requests to pull from BK trees.
   - Linus accepts GNU patches to apply to his BK tree.
   - "Select few" pull his BK tree and create GNU patches for others
     to use.

Oops.  We've just split the community further, which is *completely* the
opposite of what you wanted to achieve.  I wonder what the next stage
will be...

Like I said to you on IRC before you posted the message - you want
to fix the problem at the root (ie, Linus) rather than your apparant
problem with the "two communities."  And how do you do that?  You
discuss it with the person concerned.  (And you can see the results
of that discussion earlier in this thread.)

This way, those that want to use "a distributed source control system
of some type" can do so, and those that want to use the GNU patch/diff
method can also continue to, but with The Latest Tree available.
Which has got to be an advantage for *everyone*.

I'm sorry, I have no cares for people who have been constantly whinging
at the users of BK who don't go out of their way to find out where the
real problem is and attempt to fix that, rather than harp on about how
other people shouldn't be using a non-free tool.

Oh, and before anyone says that I'm another one who uses BK, yes I do
use BK, but only as a method of getting ARM specific changes into Linus.
Any generic kernel changes I have still go to linux-kernel, Linus and
any relevant other people as a GNU patch.  The first time these patches
see BK is when they hit Linus' BK tree.  They don't come from BK either.

I, therefore, can claim to work in both domains in parallel.

But no, in your eyes, I'm just another stupid BK person who's contributing
to the downfall of Linux, and is in the "in" club.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html
