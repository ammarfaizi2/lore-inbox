Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269292AbUJVXvK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269292AbUJVXvK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 19:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269324AbUJVXtV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 19:49:21 -0400
Received: from waste.org ([209.173.204.2]:59804 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S269313AbUJVXqy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 19:46:54 -0400
Date: Fri, 22 Oct 2004 18:46:31 -0500
From: Matt Mackall <mpm@selenic.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: The naming wars continue...
Message-ID: <20041022234631.GF28904@waste.org>
References: <Pine.LNX.4.58.0410221431180.2101@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0410221431180.2101@ppc970.osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2004 at 03:05:13PM -0700, Linus Torvalds wrote:
> And the fact is, I can't see the point. I'll just call it all "-rcX",
> because I (very obviously) have no clue where the cut-over-point from
> "pre" to "rc" is, or (even more painfully obviously) where it will become
> the final next release.

This should be easy: the cut-over should be when you're tempted to
rename it 2.6.next. If you have no intention (or hope) of renaming
2.6.x-rc1 to 2.6.x, it is not a "release candidate" by definition.

What's the point? It serves as a signal that a) we're not accepting
more big changes b) we think it's ready for primetime and needs
serious QA c) when 2.6.next gets released, the _exact code_ has gone
through a test cycle and we can have some confidence that there won't
be any nasty 0-day bugs when we go to install 2.6.next on a production
machine.

> (*) In other words, I had a beer and watched TV. Mmm... Donuts.

Please devote some more beer and TV to this problem after you release
2.6.10.

-- 
Mathematics is the supreme nostalgia of our time.
