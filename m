Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933843AbWKWQEj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933843AbWKWQEj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 11:04:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933857AbWKWQEi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 11:04:38 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:5393 "EHLO spitz.ucw.cz")
	by vger.kernel.org with ESMTP id S933848AbWKWQEN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 11:04:13 -0500
Date: Thu, 23 Nov 2006 13:28:20 +0000
From: Pavel Machek <pavel@suse.cz>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] PM: suspend/resume debugging should depend on SOFTWARE_SUSPEND
Message-ID: <20061123132820.GC5561@ucw.cz>
References: <200611190320_MC3-1-D21B-111C@compuserve.com> <Pine.LNX.4.64.0611190930370.3692@woody.osdl.org> <200611191844.14354.rjw@sisk.pl> <Pine.LNX.4.64.0611191008310.3692@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611191008310.3692@woody.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > And suspend-to-ram doesn't work on quilte a lot of boxes right now.  Also, you
> > can use the software suspend on boxes that don't support the suspend-to-ram
> > at all.
> 
> One large reason STR often doesn't work is that people don't even test it, 
> because people point to the suspend-to-disk instead.  suspend-to-disk is 
> the problem, not the solution.

Actually, I do not think we do that any more. But if s2ram is broken,
trying s2disk is indeed useful, because many driver problems are
common and s2disk is slightly easier to debug.

							Pavel
-- 
Thanks for all the (sleeping) penguins.
