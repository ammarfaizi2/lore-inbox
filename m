Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310257AbSCGKJo>; Thu, 7 Mar 2002 05:09:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310258AbSCGKJe>; Thu, 7 Mar 2002 05:09:34 -0500
Received: from ASYNC4-CS1.NET.CS.CMU.EDU ([128.2.188.132]:7428 "EHLO
	mentor.odyssey.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S310257AbSCGKJX>; Thu, 7 Mar 2002 05:09:23 -0500
Date: Thu, 7 Mar 2002 05:09:15 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Why not an arch mirror for the kernel?
Message-ID: <20020307100915.GA1158@mentor.odyssey.cs.cmu.edu>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <200203071425.GAA06679@morrowfield.home> <20020306190419.E31751@work.bitmover.com> <20020306225652.Q1682@altus.drgw.net> <20020306213238.D3240@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020306213238.D3240@work.bitmover.com>
User-Agent: Mutt/1.3.27i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06, 2002 at 09:32:38PM -0800, Larry McVoy wrote:
> > > > I am working on some tools that will help to implement automatic,
> > > > incremental, bidirectional gateways between arch, Subversion, and Bk.
> > > 
> > > Gateways, yes, bidirectional, no.  Arch doesn't begin to maintain
> > > the metadata which BK maintains, so it can't begin to solve the
> > > same problems.  If you have a bidirectional gateway, you reduce BK
> > > to the level of arch or subversion, in which case, why use BK at all?
> > > If CVS/Arch/Subversion/whatever works for you, I'd say just use it and
> > > leave BK out of it.

Additional metadata can be stored as comments. i.e. given the right
tools anything that goes from a BK patchset into $SCM can be turned back
into a BK patchset later on. Same holds for the other direction as long
as the comments are preserved.

> And why Arch and not subversion?  Subversion has more people working on
> it, Collab has put a pile of money into it, it has the Apache guy working

As far as I could see Tom was talking about bi-directional gateways
between arch, _subversion_, and BK.
 
> on it, and Arch has one guy with no money and a pile of shell scripts.

That's a pretty harsh statement, especially since critical parts of the
system have already been reimplemented in C or perl. In a way your
comment is almost similar to...

#   Writing a new OS only for the 386 in 1991 gets you your second 'F'
#   for this term. But if you do real well on the final exam, you can
#   still pass the course.

> Come on.  There is nothing free in this life, if one guy and some hacking
> could solve this problem, it would have been solved long ago.

Perhaps the time wasn't ripe, ideas and views on SCM systems have
shifted over the years, and yes BK has probably set some new standards
here, but it is always harder to break new ground.

> it's not.  Diluting BK down to the level of average SCM is completely
> pointless and a waste of time.

Having an open platform for exchanging patchsets between SCM systems
also allows people to try out different systems. Perhaps they want to
working in parallel with their existing system for a while before
finally moving everything over to the better system.

Jan

