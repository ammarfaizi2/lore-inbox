Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932275AbWESLWY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932275AbWESLWY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 07:22:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932279AbWESLWX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 07:22:23 -0400
Received: from bigben2.bytemark.co.uk ([80.68.81.132]:16566 "EHLO
	bigben2.bytemark.co.uk") by vger.kernel.org with ESMTP
	id S932275AbWESLWX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 07:22:23 -0400
Date: Fri, 19 May 2006 12:22:19 +0100
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: linux-kernel@vger.kernel.org
Cc: John Richard Moser <nigelenki@comcast.net>
Subject: Re: Stealing ur megahurts (no, really)
Message-ID: <20060519112218.GE19673@gallifrey>
References: <446D61EE.4010900@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <446D61EE.4010900@comcast.net>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.4.32 (i686)
X-Uptime: 12:13:59 up 10 days, 26 min,  1 user,  load average: 0.01, 0.12, 0.14
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* John Richard Moser (nigelenki@comcast.net) wrote:

> Scrambling for an old machine is ridiculous.  Down-clocking makes sense
> because you can adjust to varied levels; but it's difficult and usually
> infeasible.  Pulling memory and mix and matching is not much better.

<...>

> This brings the idea of a cpumhz= parameter to adjust CPU clock rate.
> Obviously we can't do this directly, as convenient as this would be; but
> the idea warrants some thought, and some thought I gave it.  What I came
> up with was simple:  Adjust time slice length and place a delay between
> time slices so they're evenly spaced.

<...>

Hi John,
  While cpu downclocking helps a bit, it would be hopelessly inaccurate
for figuring out if your app would run fast enough on the given
ancient machine.  A lot else has happened to the world since the days
of the 200MHz CPU:
    * Faster memory
    * Larger caches
    * Faster PCI busses
    * Instruction set additions (various more levels of SSE etc)
    * Faster discs
    * Changes to the CPU architecture/implementation

Still, it would be interesting to see the difference in performance
of a downclocked modern processor and its 10 year old clock equivalent.

Dave

-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM,SPARC,PPC & HPPA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
