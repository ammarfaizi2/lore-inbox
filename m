Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283714AbRL1AkH>; Thu, 27 Dec 2001 19:40:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283723AbRL1Aj5>; Thu, 27 Dec 2001 19:39:57 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:49359
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S283714AbRL1Ajo>; Thu, 27 Dec 2001 19:39:44 -0500
Date: Thu, 27 Dec 2001 19:24:34 -0500
Message-Id: <200112280024.fBS0OYH26337@snark.thyrsus.com>
From: "Eric S. Raymond" <esr@snark.thyrsus.com>
To: Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: State of the new config & build system
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus (and Marcelo): I understand that right at the moment you have
higher priorities than merging in the new build system.  Keith Owens
and I agree with those priorities, so please consider the following to
be information rather than pressure for action.

Keith's kbuild-2.5 and my CML2 both appear to be shaking down quite
nicely.

In the last eight weeks the level of beta testing we're getting from
lkml regulars has risen dramatically, as has the amount of work being
put in on the codebases by people other than Keith and myself (just
last night I checked in an entire new X-based front end contributed by
a hacker from Korea).  

Despite the increased attention, the criticality level of incoming bug
reports has held steady or decreased, to the point that we're
basically both just doing normal maintainance and polishing the chrome
now.  I haven't seen a really serious bug in CML2 since I resumed
active work on it in early November, and Keith's stuff is stable
enough that he's now adding features like kernel-image type selection
that were obviously way down his to-do list.

Just as importantly, the kernel development community now seems to be
actively preparing for the build-system cutover, as opposed to just
passively waiting for it.  Some are doing their cutover in *advance*
of the main tree; the kinds of kbuild bug reports I see on the list
indicate that Keith's kbuild is already in production use, and in the
last week I've gotten requests from SGI's XFS group and the ELKS
project for help with switching to CML2.

In sum, we're ready now -- but that's been true since at latest early
November.  What's new in the last couple weeks is that the developer
community appears to be coming up to speed on our technology
effectively enough to be ready as well.

We can help plan and execute the cutover any time you're ready.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

When all government ...in little as in great things... shall be drawn to
Washington as the center of all power; it will render powerless the checks
provided of one government on another, and will become as venal and oppressive
as the government from which we separated."	-- Thomas Jefferson, 1821
