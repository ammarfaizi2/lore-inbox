Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286415AbRLTWR5>; Thu, 20 Dec 2001 17:17:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286416AbRLTWRv>; Thu, 20 Dec 2001 17:17:51 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:20214 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S286415AbRLTWRe>; Thu, 20 Dec 2001 17:17:34 -0500
Message-ID: <3C226318.4D2EBC9E@mvista.com>
Date: Thu, 20 Dec 2001 14:15:52 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin A. Brooks" <martin@jtrix.com>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: asynchronus multiprocessing
In-Reply-To: <1008776432.431.15.camel@unhygienix>
		<1008777560.431.19.camel@unhygienix>  <3C20D9DC.B14709FD@mvista.com> <1008834258.431.21.camel@unhygienix>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin A. Brooks" wrote:
> 
> On Wed, 2001-12-19 at 18:18, george anzinger wrote:
> 
> > I have heard of some work.  As I understand it they are making an API
> > for cpu affinity.  It is real time, so they are also interested in the
> > schedule routines around cpu affinity as well.
> >
> > What did you have in mind?
> 
> Nothing too major, I just intend to buy myself a dual Athlon. I would
> rather recycle my perfectly good 1.3ghz chip and use it in conjuction
> with a 1.5ghz athlon rather than buying two new processors.
> 
Apart from the clock differences (which if actually presented to the two
cpus would cause the TSC to drift apart cause who knows what mayhem)
what is the real difference?  I think you would have to make sure you
configure for the subset of chip capabilities so you don't find the
system trying to use some capability that is only present on one cpu and
then switching the ap to the other.  As I recall, someone has already
explored this turf to some extent.  Check the archives.

But really, I was wondering what you thought needed to be done in
software?
-- 
George           george@mvista.com
High-res-timers: http://sourceforge.net/projects/high-res-timers/
Real time sched: http://sourceforge.net/projects/rtsched/
