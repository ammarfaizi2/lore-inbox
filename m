Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317605AbSGJU1E>; Wed, 10 Jul 2002 16:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317606AbSGJU1E>; Wed, 10 Jul 2002 16:27:04 -0400
Received: from relay01.valueweb.net ([216.219.253.235]:39438 "EHLO
	relay01.valueweb.net") by vger.kernel.org with ESMTP
	id <S317605AbSGJU1C>; Wed, 10 Jul 2002 16:27:02 -0400
Message-ID: <3D2C9972.BB3DA772@opersys.com>
Date: Wed, 10 Jul 2002 16:30:42 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: Richard J Moore <richardj_moore@uk.ibm.com>
CC: John Levon <movement@marcelothewonderpenguin.com>,
       Andrew Morton <akpm@zip.com.au>, Andrea Arcangeli <andrea@suse.de>,
       bob <bob@watson.ibm.com>, linux-kernel@vger.kernel.org,
       "linux-mm@kvack.org" <linux-mm@kvack.org>, mjbligh@linux.ibm.com,
       John Levon <moz@compsoc.man.ac.uk>,
       Rik van Riel <riel@conectiva.com.br>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Enhanced profiling support (was Re: vm lock contention reduction)
References: <OFF41DACAC.FEED90BA-ON80256BF2.004DC147@portsmouth.uk.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Richard J Moore wrote:
> Some level of tracing (along with other complementary PD tools e.g. crash
> dump) needs to be readiliy available to deal with those types of problem we
> see with mature systems employed in the production environment. Typically
> such problems are not readily recreatable nor even prictable. I've often
> had to solve problems which impact a business environment severely, where
> one server out of 2000 gets hit each day, but its a different one each day.
> Its under those circumstances that trace along without other automated data
> capturing problem determination tools become invaluable. And its a fact of
> life that only those types of difficult problem remain once we've beaten a
> system to death in developments and test. Being able to use a common set of
> tools whatever the componets under investigation greatly eases problem
> determination. This is especially so where you have the ability to use
> dprobes with LTT to provide ad hoc tracepoints that were not originally
> included by the developers.

I definitely agree.

One case which perfectly illustrates how extreme these situations can be is
the Mars Pathfinder. The folks at the Jet Propulsion Lab used a tracing tool
very similar to LTT to locate the priority inversion problem the Pathfinder
had while it was on Mars.

The full account gives an interesting read (sorry for the link being on
MS's website but its author works for MS research ...):
http://research.microsoft.com/research/os/mbj/Mars_Pathfinder/Authoritative_Account.html

Karim

===================================================
                 Karim Yaghmour
               karim@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
