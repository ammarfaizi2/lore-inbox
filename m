Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276966AbRJHQB4>; Mon, 8 Oct 2001 12:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272818AbRJHQBv>; Mon, 8 Oct 2001 12:01:51 -0400
Received: from [192.132.92.2] ([192.132.92.2]:14253 "EHLO
	bitmover.bitmover.com") by vger.kernel.org with ESMTP
	id <S276966AbRJHQBc>; Mon, 8 Oct 2001 12:01:32 -0400
Date: Mon, 8 Oct 2001 09:02:03 -0700
From: Larry McVoy <lm@bitmover.com>
To: linux-kernel@vger.kernel.org
Subject: [OT] testing internet performance, esp latency/drops?
Message-ID: <20011008090203.L26223@work.bitmover.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Merry kernel hackers, we recently installed a T1 line at bitmover.com and
expected improved performance.  In some places we got it, pings to places
in the silicon valley are a respectable 5-9 milliseconds.  FTP performance
is a predictable 180KB/sec, as expected.

However, web browsing sucks.  On about 80% of all links, there is a noticable
hesitation, between 1-15 seconds, as it looks up the name and as it fetches
the first page.  After that point, that site will appear to be OK.

It sounds to me like return packets are getting dropped a lot.  Which is 
possible, but I'd like to know for sure.

Before I wander off to write a test for this, I'm wondering if anyone 
knows of a test suite or a methodology which works.  I was thinking 
about just coding every reference in bookmarks/history into a driver
file which drove a connect-o-matic program that timed how fast it 
could connect to each of those sites.  Any comments on that idea?
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
