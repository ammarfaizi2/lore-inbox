Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311661AbSCNQ0T>; Thu, 14 Mar 2002 11:26:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311660AbSCNQ0J>; Thu, 14 Mar 2002 11:26:09 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:14014 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S311662AbSCNQZ6>; Thu, 14 Mar 2002 11:25:58 -0500
Date: Thu, 14 Mar 2002 09:25:23 -0700
Message-Id: <200203141625.g2EGPNh31311@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Dan Kegel <dkegel@ixiacom.com>, Ulrich Drepper <drepper@redhat.com>,
        darkeye@tyrell.hu, libc-gnats@gnu.org, gnats-admin@cygnus.com,
        sam@zoy.org, Xavier Leroy <Xavier.Leroy@inria.fr>,
        linux-kernel@vger.kernel.org, babt@us.ibm.com
Subject: Re: libc/1427: gprof does not profile threads <synopsis of the problem   (one li\ne)>
In-Reply-To: <E16lXkz-0000S3-00@starship>
In-Reply-To: <1016062486.16743.1091.camel@myware.mynet>
	<3C8FEC76.F1411739@ixiacom.com>
	<E16lXkz-0000S3-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips writes:
> On March 14, 2002 01:19 am, Dan Kegel wrote:
> > Ulrich Drepper wrote:
> > > On Wed, 2002-03-13 at 15:17, Dan Kegel wrote:
> > > 
> > > > So let's break the logjam and fix glibc's linuxthreads' pthread_create
> > > > to [support profiling multithreaded programs]
> > > 
> > > I will add nothing like this.  The implementation is broken enough and
> > > any addition just makes it worse.  If you patch your own code you'll get
> > > what you want at your own risk.
> > 
> > OK.  What's the right way to fix this, then?
> 
> I see, he said to patch your own code and probably feels the issue
> is done with.  Color me less than impressed.

Ulrich tends to take a hardline, "must be 100% correct" approach to
things. He doesn't seem to like 99% solutions that will work most of
the time but not always. This does cause some friction with people who
want something that works "most of the time" (aka "good enough"). But
before we cast stones, let's not forget that in kernel-land we see
similar attitudes. How many patches has Linus rejected because it's
"not the right way", even if many users really want it?

I guess there's always a difference between coding up and submitting
an "unclean" workaround/fixup for someone else's code, or having it
applied to your own :-)

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
