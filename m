Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268062AbTBRWHO>; Tue, 18 Feb 2003 17:07:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268064AbTBRWHN>; Tue, 18 Feb 2003 17:07:13 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:28435 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268062AbTBRWG7>; Tue, 18 Feb 2003 17:06:59 -0500
Date: Tue, 18 Feb 2003 14:13:00 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Chris Wedgwood <cw@f00f.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: Linux v2.5.62 --- spontaneous reboots
In-Reply-To: <20030218215956.GA15178@f00f.org>
Message-ID: <Pine.LNX.4.44.0302181408200.1107-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 18 Feb 2003, Chris Wedgwood wrote:
> 
> Of course, Murphy being the optimist he is; about two minutes after I
> make a claim that 2.5.52 does NOT spontaneously reboot --- it *DOES*.
> 
> I'm back to 2.5.51 and I'll beat it hard and see what happens.  I
> guess until I (or someone else who sees this) can get some concrete
> data points you'll have to ignore this.

Ok. Especially if it seems that -mjb4 also potentially does it (just
harder to trigger), I don't see many other alternatives than just going
back in time to see when it started.

But if it was getting hard to trigger with 2.5.52 too, things might be
getting hairier and hairier.. If it becomes hard enough to trigger as to
be practically nondeterministic, a better approach might be to just go
back to -mjb4, and even if it is still there in -mjb4 try to see which
part of the patch seems to be making it more stable. That might give us
more clues, and it's a much smaller problem set than going arbitrarily far
back in the 2.5.x series.

		Linus

