Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266095AbSLSULy>; Thu, 19 Dec 2002 15:11:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266101AbSLSULy>; Thu, 19 Dec 2002 15:11:54 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:15520 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S266095AbSLSULx>;
	Thu, 19 Dec 2002 15:11:53 -0500
Date: Thu, 19 Dec 2002 20:18:11 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: John Bradford <john@grabjohn.com>
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk, lm@bitmover.com,
       lm@work.bitmover.com, torvalds@transmeta.com, vonbrand@inf.utfsm.cl,
       akpm@digeo.com
Subject: Re: Dedicated kernel bug database
Message-ID: <20021219201811.GA7715@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	John Bradford <john@grabjohn.com>, linux-kernel@vger.kernel.org,
	alan@lxorguk.ukuu.org.uk, lm@bitmover.com, lm@work.bitmover.com,
	torvalds@transmeta.com, vonbrand@inf.utfsm.cl, akpm@digeo.com
References: <20021219184958.GA6837@suse.de> <200212191952.gBJJqTb3002477@darkstar.example.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212191952.gBJJqTb3002477@darkstar.example.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2002 at 07:52:29PM +0000, John Bradford wrote:
 > > I also don't trust things like this where if something goes wrong,
 > > we could lose the bug report.
 > How?  I don't see as that is more likely than with Bugzilla.

user submits bug report
robot rejects it
user reads rejection, gets confused, gives up.
 
 > Anyway, loads of LKML posts get ignored, and nobody seems to worry about it :-).

Point to one important posting thats been ignored in recent times.
More likely they weren't ignored, it was just deemed irrelevant,
unimportant, or lacked information detailing how important the problem
was.

Besides, this is one area where bugzilla is helping.
If I ignored/missed an agp related bug report on linux kernel,
and the same user also filed it in bugzilla, I'll get pestered
about it automatically later.

 > I don't see any way of making Bugzilla do all the things I described
 > originally, specifically the advanced tracking of versions tested.

I still think you're solving a non-problem. Of the 180 or so bugs so
far, there has been _1_ vendor kernel report. 1 2.4 report. and
1 (maybe 2)  undecoded oopses (which were subsequently decoded less
than 24hrs later.

 > That could help to find duplicates, which is a big problem when you
 > have 1000+ bugs.

In an ideal world, we'd never have that many open bugs 8-)
Realistically, I check bugzilla a few times a day, I notice
when something new has been added. Near the end of each week
I[*] go through every remaining open bug looking to see if there's
something additional that can be added / pinging old reporters /
closing dead bugs. Dupes usually stand out doing this.
How exactly do you plan to automate dupe detection ?
You can't even do things like comparing oops dumps, as they
may have been triggered in different ways,.

		Dave

[*] and hopefully, I'm not the only one who does this.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
