Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262107AbTCLWxu>; Wed, 12 Mar 2003 17:53:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262085AbTCLWw2>; Wed, 12 Mar 2003 17:52:28 -0500
Received: from [195.39.17.254] ([195.39.17.254]:19972 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S262094AbTCLWvU>;
	Wed, 12 Mar 2003 17:51:20 -0500
Date: Thu, 13 Mar 2003 01:41:45 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Larry McVoy <lm@work.bitmover.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Zack Brown <zbrown@tumblerings.org>, Larry McVoy <lm@bitmover.com>,
       linux-kernel@vger.kernel.org
Subject: Re: BitBucket: GPL-ed KitBeeper clone
Message-ID: <20030313004145.GG5958@zaurus.ucw.cz>
References: <8200000.1047228943@[10.10.2.4]> <Pine.LNX.4.44.0303090928570.11894-100000@home.transmeta.com> <20030309182009.GA7435@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030309182009.GA7435@work.bitmover.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Going back to the engineering problems, those problems are not going to
> get fixed by people working on them in their spare time, that's for sure,
> it's just not fun enough nor are they important enough.  Who wants to
> spend a year working on a problem which only 10 people see in the world
> each year?  And commercial 
Well, if it happens only to 10 people per
year, it is a non-problem.

> I'm starting to think that the best thing I could do is encourage Pavel &
> Co to work as hard as they can to solve these problems.  Telling them that
> it is too hard is just not believable, they are convinced I'm trying to
> make them go away.  The fastest way to make them go away is to get them
> to start solving the problems.  Let's see how well Pavel likes it when
> people bitch at him that BitBucket doesn't handle problem XYZ and he

If it only happens so rarely, people
are unlikely to complain too loudly.

Take a look at e2fsck. That's similar to
bk -- awfull lot of corner cases. And
guess what, if you mess up your disk
badly enough, it will just tell you to
fix it by hand (deallocate block free bitmap
in full group). And its okay.
(Plus I believe chkdsk has *way* bigger
problems than that.)
I'm sure you are not going to throw away
ext2 just because it has 1-person-per-3-years
problem. 99% solution is going to be
good enough for me, Andrea and
Martin. Linus can keep using bk.
				Pavel
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

