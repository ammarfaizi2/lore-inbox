Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261341AbVBNCIU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261341AbVBNCIU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Feb 2005 21:08:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261344AbVBNCIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Feb 2005 21:08:20 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:53678 "EHLO
	mail.bitmover.com") by vger.kernel.org with ESMTP id S261341AbVBNCIJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Feb 2005 21:08:09 -0500
Date: Sun, 13 Feb 2005 18:08:02 -0800
To: linux-kernel@vger.kernel.org
Subject: [BK] upgrade will be needed
Message-ID: <20050214020802.GA3047@bitmover.com>
Mail-Followup-To: lm@bitmover.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
From: lm@bitmover.com (Larry McVoy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a heads up that the BK tree for the kernel is currently at 59,000
changesets give or take a few.  The BK that you are using uses unsigned
shorts for the internal names of each delta which means you folks are
about 100 days away from things no longer working.

The good news is that the openlogging tree for the kernel has 135,000
changesets so we've obviously long since fixed this problem.

The bad news is that you will need to upgrade your BK binary in order
to pass over the 64K changeset boundary.  The data is stored on disk in
ascii so it doesn't matter if you upgrade until you hit the problem but
sooner or later you will need to upgrade.

We'll get the fix into bk-3.2.4 which should be out by the end of the
month.  When we release that we'll send out notice and it would be good
if people gave it a try and let us know if they hit issues because in a
couple of months everyone is going to have to upgrade.

It's possible that we'll be changing the BK license to conform more with
our commercial license but we won't do that without running it by Linus &
Co to make sure that it's acceptable.  One change we'd like to make there
is to clarify the non-compete stuff.  We've had some people who have
indicated that they believed that if they used BK they were agreeing
that they would never work on another SCM system.  We can see how it
is possible that people would interpret the license that way but that
wasn't our intent.  What we would like to do is change the language to
say that if you use BK you are agreeing that you won't work on another
SCM for 1 year after you stop using BK.  But after that you would be
able to hack on anything that you wanted.  That was more of what we
had in mind in the first place but we didn't make it clear.  If you all
thought that using BK meant you had no right to hack on SCM ever again,
that's just not fair.  We need to protect our IP but you should have
the right to choose to go hack SCM if that's what you (our first choice
is that you came and worked here, we really like kernel hackers, but if
you don't want to that's cool too).
-- 
---
Larry McVoy                lm at bitmover.com           http://www.bitkeeper.com
