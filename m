Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262559AbTCISJf>; Sun, 9 Mar 2003 13:09:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262560AbTCISJf>; Sun, 9 Mar 2003 13:09:35 -0500
Received: from bitmover.com ([192.132.92.2]:61081 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S262559AbTCISJd>;
	Sun, 9 Mar 2003 13:09:33 -0500
Date: Sun, 9 Mar 2003 10:20:09 -0800
From: Larry McVoy <lm@bitmover.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Zack Brown <zbrown@tumblerings.org>, Larry McVoy <lm@bitmover.com>,
       linux-kernel@vger.kernel.org
Subject: Re: BitBucket: GPL-ed KitBeeper clone
Message-ID: <20030309182009.GA7435@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Roman Zippel <zippel@linux-m68k.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Zack Brown <zbrown@tumblerings.org>, Larry McVoy <lm@bitmover.com>,
	linux-kernel@vger.kernel.org
References: <8200000.1047228943@[10.10.2.4]> <Pine.LNX.4.44.0303090928570.11894-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303090928570.11894-100000@home.transmeta.com>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> And yes, maybe the really hard cases are rare. But does that mean that you 
> aren't going to do it?

This is sort of the point I've been trying to make for years.  It is 
unlikely that an open source project is going to solve these problems.
It's possible, but unlikely because the problems are rare and the code to
solve them is incredibly difficult.  It isn't obvious at all, it wasn't
obvious to me the first time around, it's only after you've done it that
you can see how something that appeared really simple wasted 6 months.

In the open source model, the portion of the work which is relatively
easy gets done, but the remaining part only gets done if there is a
huge amount of pressure to do so.  If you take a problem which occurs
only rarely, is difficult to solve, and has only a small set of users,
that's a classic example of something that just isn't going to get fixed
in the open source environment.  

It's a lot different when you have a very small set of users and the
solutions are very expensive.  I'm not saying that people don't solve hard
problems in open source projects, they do, the kernel is a good example.
The kernel also has millions of users, gets all sorts of friendly press
every day, and is fun.  In the SCM space, there are hundreds of products
for a potential market that is about 4000 times smaller than the potential
market for the kernel.  

SVN is a good example.  They side stepped almost all of the problems
that BK solves and it was absolutely the right call.  It would have cost
them millions to solve them and their product is free, it would take 
decades to recoup the investment at the low rates they can charge for
support or bundling or hosting.

Going back to the engineering problems, those problems are not going to
get fixed by people working on them in their spare time, that's for sure,
it's just not fun enough nor are they important enough.  Who wants to
spend a year working on a problem which only 10 people see in the world
each year?  And commercial customers aren't going to pay for this either
if the model is the traditional open source support model.  If you hit a
problem and it costs us $200K to fix it and you only hit it a few times
a year, if that, then you are not going to be OK with us billing you
that $200K, there isn't a chance that will work.

I'm starting to think that the best thing I could do is encourage Pavel &
Co to work as hard as they can to solve these problems.  Telling them that
it is too hard is just not believable, they are convinced I'm trying to
make them go away.  The fastest way to make them go away is to get them
to start solving the problems.  Let's see how well Pavel likes it when
people bitch at him that BitBucket doesn't handle problem XYZ and he
realizes that he needs to take another year of 80 hour weeks to fix it.
Go for it, dude, here's hoping that we can make it as pleasant for you
as you have made it for us.  Looking forward to it.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
