Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292385AbSCFAvo>; Tue, 5 Mar 2002 19:51:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292576AbSCFAve>; Tue, 5 Mar 2002 19:51:34 -0500
Received: from bitmover.com ([192.132.92.2]:48606 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S292385AbSCFAvb>;
	Tue, 5 Mar 2002 19:51:31 -0500
Date: Tue, 5 Mar 2002 16:51:23 -0800
From: Larry McVoy <lm@bitmover.com>
To: Troy Benjegerdes <hozer@drgw.net>
Cc: The Open Source Club at The Ohio State University 
	<opensource-admin@cis.ohio-state.edu>,
        linux-kernel@vger.kernel.org, opensource@cis.ohio-state.edu
Subject: Re: Petition Against Official Endorsement of BitKeeper by Linux Maintainers
Message-ID: <20020305165123.V12235@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Troy Benjegerdes <hozer@drgw.net>,
	The Open Source Club at The Ohio State University <opensource-admin@cis.ohio-state.edu>,
	linux-kernel@vger.kernel.org, opensource@cis.ohio-state.edu
In-Reply-To: <20020305165233.A28212@fireball.zosima.org> <20020305163809.D1682@altus.drgw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020305163809.D1682@altus.drgw.net>; from hozer@drgw.net on Tue, Mar 05, 2002 at 04:38:09PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2002 at 04:38:09PM -0600, Troy Benjegerdes wrote:
> First, CVS is COMPLETELY inadequate for the kind of distributed, 
> non-centralized development that goes on for the kernel.
> 
> Bitkeeper solves some rather difficult problems that *NOTHING ELSE SOLVES* 
> right now. This is why I've continued to use it for the last 2 years, even 
> though I occasionally get annoyed that it's not free software.
> 
> Your efforts on this petition would be FAR better spent (and appreciated) 
> by attempting to mirror several BK kernel trees with Arch or Subversion. 
> You will soon find out the limitations of both, and maybe even improve 
> both projects to the point that they will be useable instead of bitkeeper.
> 
> Instead of whining about developers using BK, go out and give us an
> alternative. Maybe then we will listen.

This is great, I was about to type in what Troy said.  I had the same
reaction, if CVS/Subversion/Arch were good enough, BitKeeper wouldn't
exist.  The BitKeeper team is about 75% kernel hackers, not SCM people.
If CVS had been good enough, we would all be doing Linux clusters of
some sort, something we hope to get back some day in the distant future.

Troy is right, instead of writing petitions, spend your time by providing
people with options.  Do what he said, mirror the tree into CVS/etc
and you will very quickly learn why CVS/etc have serious problems.
By learning about those problems, you'll either develop some insight
which will aid you in making CVS/etc better, and you'll develop a healthy
respect for what BitKeeper can do.

As for the replacements mentioned, Subversion in particular, the SVN team
admitted before they started that SVN would certainly not be able to do
what BK can do anytime soon, in fact, they admitted it was unlikely to
ever do so.  The reason for that is that they started with a centralized
design and when you try and distribute that, you learn about the zillions
of places where you needed to make a different choice.  It's virtually
impossible to take a centralized SCM system and make it truly distributed
(a TCP connection back to the one CVS server is *not* distributed).

While you are thinking about replacements, it might help to know the
magnitude of what you are discussing.  BitKeeper is a non-trivial project,
it has:
	* close to 200 commands, with about 800 different options.
	* 25,000 lines of regressions, running the full suite wraps
	  16 bit process ids almost twice.
	* more source code written by the BitMover team than all of
	  Version 7 Unix, kernel and userland combined.
	* a dedicated team of full time professional programmers.

More than a year ago, we had some research done to see what it would cost
to reproduce BitKeeper from scratch.  At that point, it was estimated
to be about $12,000,000 and at least 3.5 years from the time a good
team started.

Anyone and everyone is welcome to try and build a better SCM system, just
don't be naive about what it is you are trying to do.  It's a constant
source of frustration and amusement that people think this space is easy.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
