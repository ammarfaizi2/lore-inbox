Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751408AbWESRhc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751408AbWESRhc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 13:37:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751410AbWESRhc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 13:37:32 -0400
Received: from tallyho.bytemark.co.uk ([80.68.81.166]:2692 "EHLO
	tallyho.bytemark.co.uk") by vger.kernel.org with ESMTP
	id S1751408AbWESRhb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 13:37:31 -0400
Date: Fri, 19 May 2006 18:37:27 +0100
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: linux-kernel@vger.kernel.org
Cc: John Richard Moser <nigelenki@comcast.net>
Subject: Re: Stealing ur megahurts (no, really)
Message-ID: <20060519173727.GA7947@gallifrey>
References: <446D61EE.4010900@comcast.net> <20060519112218.GE19673@gallifrey> <446DFF25.4020301@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <446DFF25.4020301@comcast.net>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.4.32 (i686)
X-Uptime: 18:30:59 up 10 days,  6:43,  1 user,  load average: 0.30, 0.20, 0.10
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* John Richard Moser (nigelenki@comcast.net) wrote:
  > That I wrote
> > <...>
> > 
> > Hi John,
> >   While cpu downclocking helps a bit, it would be hopelessly inaccurate
> > for figuring out if your app would run fast enough on the given
> > ancient machine.  A lot else has happened to the world since the days
> > of the 200MHz CPU:
> >     * Faster memory
> >     * Larger caches
> >     * Faster PCI busses
> >     * Instruction set additions (various more levels of SSE etc)
> >     * Faster discs
> >     * Changes to the CPU architecture/implementation
> > 
> 
> Skews and fuzz.  Imperfections, but at least we get a general idea.  ;)

Really? I bet there is a factor of 2 at least in that lot when you
put them together? (Depending on what you are running)
Remember the reason you are scrabbling around for this ancient machine
is to answer a question along the lines of 'is my program useable on a
.....' ?
Also you want to make sure you haven't made an assumption about an actual
feature (you left a cmov in somewhere? You assumed AGP? LBA block addressing
etc).

Dave
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM,SPARC,PPC & HPPA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
