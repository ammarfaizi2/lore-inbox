Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261544AbVCCGzj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261544AbVCCGzj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 01:55:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261464AbVCCGyL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 01:54:11 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:14866 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261513AbVCCGIY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 01:08:24 -0500
Date: Thu, 3 Mar 2005 07:07:48 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Greg KH <greg@kroah.com>, Jeff Garzik <jgarzik@pobox.com>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFD: Kernel release numbering
Message-ID: <20050303060748.GD30106@alpha.home.local>
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org> <20050302230634.A29815@flint.arm.linux.org.uk> <42265023.20804@pobox.com> <Pine.LNX.4.58.0503021553140.25732@ppc970.osdl.org> <20050303002047.GA10434@kroah.com> <Pine.LNX.4.58.0503021710430.25732@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0503021710430.25732@ppc970.osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2005 at 05:15:36PM -0800, Linus Torvalds wrote:
> On Wed, 2 Mar 2005, Greg KH wrote:
> > I do understand what you are trying to achieve here, people don't really
> > test the -rc releases as much as a "real" 2.6.11 release.  Getting a
> > week of testing and bugfix only type patches to then release a 2.6.12
> > makes a lot of sense.  For example, see all of the bug reports that came
> > out of the woodwork today on lkml from the 2.6.11 release...
> 
> A large part of it is psychological. On the other hand, it may be that
> Neil is right and it would just mean that people wouldn't even test the
> odd releases (..because they want to wait a couple of weeks for the even
> one), so it may not actually end up helping much.

It's not the same thing to test ONE release and test SEVERAL -rc. I take
my case as an example. I don't have enough time to keep up, so I try to
compile at least each release and test them on one of my systems, maybe
for curiosity. I would like to test the -rc, but the problem is that you
don't know how much you can expect this or that -rc to be close to usable.
You even expect it to fail or not build at all, so when you don't have much
time to spend on this, unfortunately, you don't test them.

On the contrary, Marcelo makes a strong difference between -pre and -rc.
And when I see a 2.4-rc, I expect it to be a potential candidate, so I
try to get some time to compile it just in case I would discover an awful
bug, and avoid the 2.6.8 -> 2.6.8.1 situation. Honnestly, I would have
reported the 2.6.8 NFS bug earlier if there had been a true -rc before
it (=one which does not change except for trivial bug fixes).

> The thing is, I _do_ believe the current setup is working reasonably well.  
> But I also do know that some people (a fairly small group, but anyway)  
> seem to want an extra level of stability - although those people seem to
> not talk so much about "it works" kind of stability, but literally a "we
> can't keep up" kind of stability (ie at least a noticeable percentage of
> that group is not complaining about crashes, they are complaining about
> speed of development).
> 
> And I suspect that _anything_ I do won't make those people happy.

The only solution against this is to freeze for real and start the devel
tree in parallel. People are not complaining anymore about 2.4 change
speed, because every time a folk sends something, we tell him to push
that into 2.6 and not 2.4. The same thing must work with 2.6 and 2.7.
In the end, there would a general feeling that "2.6 was not as stable
as 2.8", etc... That's not a problem, there are always ups and downs
in software.

Regards,
Willy

