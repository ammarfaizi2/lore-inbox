Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268089AbTBRWvt>; Tue, 18 Feb 2003 17:51:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268090AbTBRWvs>; Tue, 18 Feb 2003 17:51:48 -0500
Received: from tapu.f00f.org ([202.49.232.129]:26767 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S268089AbTBRWvs>;
	Tue, 18 Feb 2003 17:51:48 -0500
Date: Tue, 18 Feb 2003 15:01:50 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: Linux v2.5.62 --- spontaneous reboots
Message-ID: <20030218230150.GA15657@f00f.org>
References: <Pine.LNX.4.44.0302181408200.1107-100000@penguin.transmeta.com> <Pine.LNX.4.44.0302181426020.1498-100000@penguin.transmeta.com> <20030218215956.GA15178@f00f.org> <Pine.LNX.4.44.0302181408200.1107-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302181426020.1498-100000@penguin.transmeta.com> <Pine.LNX.4.44.0302181408200.1107-100000@penguin.transmeta.com>
User-Agent: Mutt/1.3.28i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2003 at 02:13:00PM -0800, Linus Torvalds wrote:

> > I'm back to 2.5.51 and I'll beat it hard and see what happens.  I
> > guess until I (or someone else who sees this) can get some
> > concrete data points you'll have to ignore this.
>
> Ok. Especially if it seems that -mjb4 also potentially does it (just
> harder to trigger), I don't see many other alternatives than just
> going back in time to see when it started.

It seems 2.5.51 *does* also show this... but it took nearly an hour
this time.

> But if it was getting hard to trigger with 2.5.52 too, things might
> be getting hairier and hairier... If it becomes hard enough to
> trigger as to be practically nondeterministic, a better approach
> might be to just go back to -mjb4, and even if it is still there in
> -mjb4 try to see which part of the patch seems to be making it more
> stable.

I may have to do that...  it seems older kernel do have this problem,
it's just harder to hit for some reason.

I'd suspect it was an Athlon or chipset problem if it weren't for the
fact 2.4.x is stable for 8+ hours doing doing the same exact thing[1].

> That might give us more clues, and it's a much smaller problem set
> than going arbitrarily far back in the 2.5.x series.

Sure thing.


  --cw
