Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311668AbSCNQy1>; Thu, 14 Mar 2002 11:54:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311671AbSCNQyL>; Thu, 14 Mar 2002 11:54:11 -0500
Received: from dsl-213-023-038-002.arcor-ip.net ([213.23.38.2]:6820 "EHLO
	starship") by vger.kernel.org with ESMTP id <S311668AbSCNQxK>;
	Thu, 14 Mar 2002 11:53:10 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Richard Gooch <rgooch@ras.ucalgary.ca>,
        Daniel Phillips <phillips@bonn-fries.net>
Subject: Re: libc/1427: gprof does not profile threads <synopsis of the problem   (one li\ne)>
Date: Thu, 14 Mar 2002 17:47:45 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Dan Kegel <dkegel@ixiacom.com>, Ulrich Drepper <drepper@redhat.com>,
        darkeye@tyrell.hu, libc-gnats@gnu.org, gnats-admin@cygnus.com,
        sam@zoy.org, Xavier Leroy <Xavier.Leroy@inria.fr>,
        linux-kernel@vger.kernel.org, babt@us.ibm.com
In-Reply-To: <1016062486.16743.1091.camel@myware.mynet> <E16lXkz-0000S3-00@starship> <200203141625.g2EGPNh31311@vindaloo.ras.ucalgary.ca>
In-Reply-To: <200203141625.g2EGPNh31311@vindaloo.ras.ucalgary.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16lYOH-0000SG-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On March 14, 2002 05:25 pm, Richard Gooch wrote:
> Daniel Phillips writes:
> > On March 14, 2002 01:19 am, Dan Kegel wrote:
> > > Ulrich Drepper wrote:
> > > > On Wed, 2002-03-13 at 15:17, Dan Kegel wrote:
> > > > 
> > > > > So let's break the logjam and fix glibc's linuxthreads'
> > > > > pthread_create to [support profiling multithreaded programs]
> > > > 
> > > > I will add nothing like this.  The implementation is broken enough and
> > > > any addition just makes it worse.  If you patch your own code you'll 
> > > > get what you want at your own risk.
> > > 
> > > OK.  What's the right way to fix this, then?
> > 
> > I see, he said to patch your own code and probably feels the issue
> > is done with.  Color me less than impressed.
> 
> Ulrich tends to take a hardline, "must be 100% correct" approach to
> things. He doesn't seem to like 99% solutions that will work most of
> the time but not always. This does cause some friction with people who
> want something that works "most of the time" (aka "good enough"). But
> before we cast stones, let's not forget that in kernel-land we see
> similar attitudes. How many patches has Linus rejected because it's
> "not the right way", even if many users really want it?

Oh, I have no trouble with the 'must be 100%' rule, but the failing to define 
what '100%' actually means is... um... not the way Linus would handle it.

Failing to engage in discourse is just not the 'open' way.

> I guess there's always a difference between coding up and submitting
> an "unclean" workaround/fixup for someone else's code, or having it
> applied to your own :-)

-- 
Daniel
