Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750732AbWE2MMj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbWE2MMj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 08:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750734AbWE2MMj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 08:12:39 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:53460 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750732AbWE2MMi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 08:12:38 -0400
Subject: Re: How to check if kernel sources are installed on a system?
From: Steven Rostedt <rostedt@goodmis.org>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Cc: Lee Revell <rlrevell@joe-job.com>, Arjan van de Ven <arjan@infradead.org>,
       Heiko Carstens <heiko.carstens@de.ibm.com>,
       devmazumdar <dev@opensound.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20060528223803.GT13513@lug-owl.de>
References: <1148653797.3579.18.camel@laptopd505.fenrus.org>
	 <20060528130320.GA10385@osiris.ibm.com>
	 <1148835799.3074.41.camel@laptopd505.fenrus.org>
	 <1148838738.21094.65.camel@mindpipe>
	 <1148839964.3074.52.camel@laptopd505.fenrus.org>
	 <1148846131.27461.14.camel@mindpipe> <20060528204558.GR13513@lug-owl.de>
	 <1148851660.27461.23.camel@mindpipe> <20060528215504.GS13513@lug-owl.de>
	 <1148853773.28334.9.camel@mindpipe>  <20060528223803.GT13513@lug-owl.de>
Content-Type: text/plain
Date: Mon, 29 May 2006 08:11:47 -0400
Message-Id: <1148904707.11270.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-05-29 at 00:38 +0200, Jan-Benedict Glaw wrote:
> On Sun, 2006-05-28 18:02:53 -0400, Lee Revell <rlrevell@joe-job.com> wrote:
> > On Sun, 2006-05-28 at 23:55 +0200, Jan-Benedict Glaw wrote:
> > Chicken and egg problem.  Users have hardware and they want to run Linux
> > on it.  It's not always feasible for them to verify Linux compatibility
> > before they buy.  And some vendors like BenQ even ship a Linux CD with
> > their laptops even though the sound doesn't work on any BenQ system -
> > they obviously did not even try it.  So we have a large population of
> > users who would love to run Linux but can't until we support their
> > hardware.
> 
> In my world, "we" also contains the user. If a user doesn't want to
> eg. re-test with upstream kernels or consider to put other efforts
> (like paying developers or learning to code), then re doesn't *really*
> want it supported.

I guess your argument is the old "Linux is user friendly, it's just
picky about its users". Today, I don't buy it.  Linux is becoming much
more user friendly, more so with non developers.  I'm starting to see
that if I want to keep being paid for kernel development, more and more
non-developer users are needed to exist.

Yes, there are several non-developers that are great and bend over
backwards to help us solve problems (Mark Knetch, a guitar player,
constantly does this to help us on -rt).  But they are few and far
between.  Some are just too intimidated by what goes on in their
computer, and might give up and say: "this Linux stuff is just too hard,
and is not worth it" before they realize it would be.

Basically, anything that makes it easier for users to help us solve bugs
in hardware is important.  If I know there's a bug on something that I
don't own, I would want it fixed with the help of the first user that
discovers it, than saying "oh well, he gave up, I'll just wait for the
next one".  That would drive me crazy.

>  
> > >  If there's a user that *really* wants that hardware supported,
> > > then they will put effort into getting it to work, either by helping
> > > debugging, hacking or by paying some expert to reverse-engineer an
> > > existing driver.
> > 
> > There are many users who *really* want their hardware supported but
> > don't have the funds or the know-how to do any of these.  Like all of
> > these users:
> > 
> > https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1134
> 
> I accept the no-money argument, but not the no-knowledge one. Anybody
> can learn, can't they?

I know people who call themselves programmers that still don't "get it".
So, really, the answer is "No", people can't always learn, and a lot
don't want to.  Programming and debugging is a talent.  No matter how
hard I try to sing, I still wont be good enough to survive living in a
subway.

-- Steve


