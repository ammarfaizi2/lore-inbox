Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285229AbRL2Szj>; Sat, 29 Dec 2001 13:55:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285226AbRL2Sz3>; Sat, 29 Dec 2001 13:55:29 -0500
Received: from bitmover.com ([192.132.92.2]:37543 "EHLO bitmover.bitmover.com")
	by vger.kernel.org with ESMTP id <S285229AbRL2Sz0>;
	Sat, 29 Dec 2001 13:55:26 -0500
Date: Sat, 29 Dec 2001 10:55:25 -0800
From: Larry McVoy <lm@bitmover.com>
To: Timothy Covell <timothy.covell@ashavan.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC: Linux Bug Tracking & Feature Tracking DB
Message-ID: <20011229105525.C19306@work.bitmover.com>
Mail-Followup-To: Timothy Covell <timothy.covell@ashavan.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200112290657.fBT6vMSr008000@svr3.applink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <200112290657.fBT6vMSr008000@svr3.applink.net>; from timothy.covell@ashavan.org on Sat, Dec 29, 2001 at 12:53:39AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 29, 2001 at 12:53:39AM -0600, Timothy Covell wrote:
> 1. The maintainer of this DB would need to receive patches
> along with patch.lsm and feature.lsm like files from the code 
> maintainers.   That means  that Linus, Alan, Marcello, Dave 
> Jones, et al.,  might have to be involved.
> 
> 2. DB would be a high volume site (at least that's the idea!)
> 
> 3. Would would pay for and maintain it?  (I know, since I'm
> the one putting forth the idea, it's mine to run with.  However,
> a. I ain't rich.  b. following from a., I have no bandwidth 24kbps
> dialup.)

OK, we've got a prototype of something like this already, I don't claim
it is ready for prime time, but you can go look at it here:

	http://bugs.bkbits.net/bugs.html

You can run queries, etc.  

This is a fairly early version, so be gentle.  The data in it is the
current BitKeeper bug list (feel free to fix some :-)

There are other ways to access the data, both command line and email
are supported.  Long term, I'd like to make the bug db be an NNTP server
so you could do everything via a news reader, which would be bitchin'.

If this is a first order approximation of what you want, we'll host
it here if you like.  We have a T1 line with lots of spare bandwidth
at the moment.  The machine that you are poking at is the same machine
which hosts various BK repos, such as the Linux/PPC trees, Ted's linux24
tree, Ted's e2fsprogs, NTP trees, GregKH's trees, Chris Wright's trees
(he has a 25 tree based on Ted's 24 tree), Rik's VM tree, among others.
We haven't talked about this very much because we don't have all the
nifty sourceforge like indices and statistics, but long term this is
headed towards something somewhat like a distributed sourceforge.
We never liked the centralized model that sourceforge has, it becomes
a single point of failure.

One interesting, perhaps, point is that bugdb is a BitKeeper repository,
which means you can clone it and take *all* of the data with you,
unlike sourceforge.  So if you were to become dependent on this and
we ran out of bandwidth or something, you can clone the bug db and set
up your own bug server elsewhere.  In general, for both databases and
source, that's the approach we want, i.e., we're happy to host it here
to get you started but if you have needs that we can't meet, we'll make
it easy for you to host elsewhere.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
