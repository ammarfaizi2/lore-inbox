Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264320AbRFHXxJ>; Fri, 8 Jun 2001 19:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264405AbRFHXw7>; Fri, 8 Jun 2001 19:52:59 -0400
Received: from alcove.wittsend.com ([130.205.0.20]:40086 "EHLO
	alcove.wittsend.com") by vger.kernel.org with ESMTP
	id <S264320AbRFHXwv>; Fri, 8 Jun 2001 19:52:51 -0400
Date: Fri, 8 Jun 2001 19:50:50 -0400
From: "Michael H. Warfield" <mhw@wittsend.com>
To: Leif Sawyer <lsawyer@gci.com>
Cc: "L. K." <lk@Aniela.EU.ORG>, linux-kernel@vger.kernel.org
Subject: Re: temperature standard - global config option?
Message-ID: <20010608195050.A13136@alcove.wittsend.com>
Mail-Followup-To: Leif Sawyer <lsawyer@gci.com>, "L. K." <lk@Aniela.EU.ORG>,
	linux-kernel@vger.kernel.org
In-Reply-To: <BF9651D8732ED311A61D00105A9CA315053E0AFB@berkeley.gci.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.2i
In-Reply-To: <BF9651D8732ED311A61D00105A9CA315053E0AFB@berkeley.gci.com>; from lsawyer@gci.com on Fri, Jun 08, 2001 at 01:33:44PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 08, 2001 at 01:33:44PM -0800, Leif Sawyer wrote:
> > From: L. K. [mailto:lk@Aniela.EU.ORG]
> > I really do not belive that for a CPU or a motherboard +- 1 
> > degree would make any difference.

> You haven't pushed your system, or run it in a hostile
> environment then.  There are many places where systems are run
> right up to the edge of thermal breakdown, and it's a firm
> requirement to know exactly what that edge is.


> > If a CPU runs fine at, say, 37 degrees C, I do not belive it 
> > will have any problems running at 38 or 36 degrees. I support
> > the ideea of having very good sensors for temperature
> > monitoring, but CPU and motherboard temperature do not depend
> > on the rise of the temperature of 1 degree, but when the
> > temperature rises 10 or more degrees. I hope you understand
> > what I want to say.

> I have a CPU that runs great up to 43C, and shuts down hard at 44C
> so I obviously want to know how close I am to that.  I don't want
> rounding errors to get in the way, and I don't want changes
> between kernel revs to affect it either.

	If the rounding errors are less than the accuracy and the
reproducibility of your sensor, and you operate in that range and
depend on those values, then you have no clue where you are, no
matter what your granularity.  You sound like the classic example
of why we should NOT do this.  You are foolish enough to depend on
that precision and think that it's accuracy and think that it means
something in comparision to the identical measurement 15 minutes later.
It does not.

> If we've got the bitspace, keep the counters as granular as
> possible within the useable range that we're designing for.

> counter = .01 * degrees kelvin

	Then you are being foolish.

	Your sensors are neither accurate to that degree nor are they
reproducible to that degree.  What you are describing is jibberish.

	Mike
-- 
 Michael H. Warfield    |  (770) 985-6132   |  mhw@WittsEnd.com
  (The Mad Wizard)      |  (678) 463-0932   |  http://www.wittsend.com/mhw/
  NIC whois:  MHW9      |  An optimist believes we live in the best of all
 PGP Key: 0xDF1DD471    |  possible worlds.  A pessimist is sure of it!

