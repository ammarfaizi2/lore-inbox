Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262164AbTJNCzz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 22:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262174AbTJNCzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 22:55:55 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:20379 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S262164AbTJNCzy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 22:55:54 -0400
Date: Mon, 13 Oct 2003 19:55:51 -0700
From: Larry McVoy <lm@bitmover.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Silly BK statistics
Message-ID: <20031014025551.GA13675@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.3,
	required 7, AWL)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You guys work way too hard.  The BK openlogging tree, which has all
changesets ever made by anyone in the Linux kernel, was getting big.
Really big.  The nodes in the graph have internal "serial numbers"
which are currently 16 bits, i.e., there can't be more than 64K nodes
in the graph.

I sent mail to some of my engineers this morning saying "hey, I suspect
the Linux openlogging tree is about overflow, we need to go to 32 bit
ser_t's."  I had no idea how close we were, I just knew it was a problem
we needed to solve.

I just got mail from one of the team which reads: "With 199 serials shy
of overflowing , the 32 bit version is now installed".

What that means is that in about a year, you've managed to create 65,337
changesets.  That's 179 per day, 7.4/hour, 24x7.  You guys are busy.

To put that in perspective, the most active project on sourceforge today,
Gaim, has 805 commits to its changelog.  Over 3.5 years.  That means you
are changing your source base 284x more often than they are.  And that's 
just the BK users, that doesn't count the people not using BK, which are
a substantial fraction.

No matter how you slice it, it is pretty amazing rate of change.
If change is good, you guys rock, I've never seen anything like it.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
