Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261299AbVGBWDL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261299AbVGBWDL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Jul 2005 18:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261302AbVGBWB3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Jul 2005 18:01:29 -0400
Received: from hummeroutlaws.com ([12.161.0.3]:23559 "EHLO atpro.com")
	by vger.kernel.org with ESMTP id S261299AbVGBV5b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Jul 2005 17:57:31 -0400
From: "Jim Crilly" <jim@why.dont.jablowme.net>
Date: Sat, 2 Jul 2005 17:56:46 -0400
To: Ed Cogburn <edcogburn@hotpop.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: reiser4 vs politics: linux misses out again
Message-ID: <20050702215645.GB4907@voodoo>
Mail-Followup-To: Ed Cogburn <edcogburn@hotpop.com>,
	linux-kernel@vger.kernel.org
References: <1120134372.42c3e4e49e610@webmail.bur.st> <20050630153326.GB24468@voodoo> <20050630160244.GV11013@nysv.org> <20050630180959.GC24468@voodoo> <da61a8$il6$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <da61a8$il6$1@sea.gmane.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/05 09:05:41AM -0400, Ed Cogburn wrote:
> Jim Crilly wrote:
> 
> > On 06/30/05 07:02:44PM +0300, Markus   Törnqvist wrote:
> >> It'd be much better to talk this thing through..
> >> There have been pretty good arguments for the extended VFS, that it
> >> would be doable. It may just be less of a unix after that, or less
> >> of Linux as we know it now.
> >> 
> > 
> > I'm not advocating a fork, I just think it's stupid that so many people
> > have been saying "Stop arguing, just accept reiser4 as-is because it's
> > fast and cool!!!!"
> 
> 
> Assuming "fast and cool" here equates to some level of improvement to the
> existing kernel, and/or new features/capabilities not currently available,
> then are you saying "fast and cool" isn't good enough anymore, you now have
> to be politically correct and socially popular and a master brown-noser as
> well to get code into the kernel even just on an *experimental* basis?
> 

Fast and cool by themselves shouldn't be good enough, infact fast could
definately be optional because if the implementation is good and the code
is clean it will get optimized down the road. And IMO reiser4 is an
exception to the "but just mark it experimental" argument because it's so
large and implements so many things that should be in other places. If it
was something small like a device driver that was in 1-5 files and didn't
touch anything else, I'm sure no one would argue against it's inclusion.

> In reality, the implied attitude behind your statement actually *guarantees*
> a fork of Linux at some point down the road if you keep stonewalling the
> inclusion of something that clearly has enormous potential, because for
> many people "fast and cool" IS THE DESIRED OBJECTIVE, and by saying no to
> that, YOU are the one setting the stage for a fork.  R4, or any other
> promising and relatively stable technology, can't reach its full potential
> until it begins to see wider testing and usage, which can only happen when
> it gets included into the mainstream stable kernel.  So when the fork
> finally happens because people got tired of waiting, don't blame the
> forkers and don't blame Hans, it will have been your own attitude that made
> it a fait accompli.
> 
> You obviously don't realize it, but a lot of us don't give a damn whether
> you like Hans or not, or whether you think his design is "clean" or
> "correct" or not, we just want Linux to be the "fastest and coolest" it can
> be.  Find a way to solve the technical problems, and just give R4 its shot. 
> Let it succeed or fail based on its own merits, and not because its author
> may have poor social skills, or simply rubs you the wrong way.
> 

Obviously you don't care about the code or it's maintainer's attitude, you
don't have to deal with either of them. And if you had read all of the
reiser4 threads you would have seen that people are trying to work out the
technical details, it's not a fast process when 2 things this large and
complicated are involved.

> I hope your attitude turns out to be in the minority, and cooler heads
> prevail in this argument, because otherwise, Unix historians will likely
> look back to this moment and say this was when Linux began to stumble...
> 

I'm glad the kernel maintaners are being convservative about what gets
merged, if they allowed everything in that was sent to lkml the historians
would be looking back and saying this was when Linux started to become
unmaintainable.

Jim.
