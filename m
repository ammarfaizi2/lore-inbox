Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292280AbSBOXgz>; Fri, 15 Feb 2002 18:36:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292281AbSBOXgp>; Fri, 15 Feb 2002 18:36:45 -0500
Received: from bitmover.com ([192.132.92.2]:1936 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S292280AbSBOXgj>;
	Fri, 15 Feb 2002 18:36:39 -0500
Date: Fri, 15 Feb 2002 15:36:36 -0800
From: Larry McVoy <lm@bitmover.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Disgusted with kbuild developers
Message-ID: <20020215153636.D32005@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020215195818.A3534@pc1-camc5-0-cust78.cam.cable.ntl.com> <20020215145421.A12540@thyrsus.com> <20020215124255.F28735@work.bitmover.com> <20020215153953.D12540@thyrsus.com> <20020215221532.K27880@suse.de> <20020215155817.A14083@thyrsus.com> <200202152209.g1FM9PZ00855@vindaloo.ras.ucalgary.ca> <20020215165029.C14418@thyrsus.com> <20020215143807.L28735@work.bitmover.com> <20020215232312.GB12204@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020215232312.GB12204@merlin.emma.line.org>; from matthias.andree@stud.uni-dortmund.de on Sat, Feb 16, 2002 at 12:23:12AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 16, 2002 at 12:23:12AM +0100, Matthias Andree wrote:
> Are you telling that kernel programmers don't rewrite code from scratch?
> Is that a correct interpretation of "improve the existing system"? Note
> that "it can't be done" can also imply "cannot reasonable be done".
> 
> If that's not what you mean, stop reading this mail, drop a line to
> clarify this and forget this piece of mail.

That's not what I mean.  But it's worthwhile to note that almost all
"rewrite from scratch" projects really translate into "I'm unwilling to
learn what the last guy did, and I'm smarter, so I'm going to do what
I want to do".  And that is not what kernel programmers do.  They would
love to be able to do that but it's very rare that doing so makes sense.

In reality, the guy who came before you wasn't an idiot.  Maybe s/he
didn't do the best job possible, but the fact that the code is there and
works implies some level of understanding.  Real programmers make their
work fit *seamlessly* with the work of the people who came before them.
It's egoless programming, you are striving to make things fit so well
that noone can see where person A stopped and person B started.

In Eric's case, it would have been far better if he had done some work
to make CML1 work better.  It simply isn't broken enough to justify
throwing it out.  And it's not at all clear to me, at least, that the
CML2 stuff is any less broken, it's just broken in different ways.
Unless Eric can make a system that is widely viewed as better overall
than CML1, making one that is better in some ways but worse or just as
bad in others, well, that's a big waste of time.

At Sun, we had a rule that a major change was automatically disallowed
unless it showed a factor of 2 improvement in some important way while
holding the other variables constant.  I don't think CML2 would pass
that test.  Aunt Tillie's opinion doesn't count.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
