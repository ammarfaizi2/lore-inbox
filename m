Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267850AbUIJTgv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267850AbUIJTgv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 15:36:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267840AbUIJTgv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 15:36:51 -0400
Received: from fw.osdl.org ([65.172.181.6]:23263 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267830AbUIJTer (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 15:34:47 -0400
Date: Fri, 10 Sep 2004 12:34:45 -0700
From: Chris Wright <chrisw@osdl.org>
To: Roland McGrath <roland@redhat.com>
Cc: Chris Wright <chrisw@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix sigqueue accounting for posix-timers broken by new RLIMIT_SIGPENDING tracking code
Message-ID: <20040910123445.L1924@build.pdx.osdl.net>
References: <20040910104228.K1924@build.pdx.osdl.net> <200409101924.i8AJOxRH029788@magilla.sf.frob.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200409101924.i8AJOxRH029788@magilla.sf.frob.com>; from roland@redhat.com on Fri, Sep 10, 2004 at 12:24:59PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Roland McGrath (roland@redhat.com) wrote:
> D'oh.  You are right.  I misread the code in the middle of the night.  I
> came across the new issue of hitting the sigpending limit while verifying a
> test case for timers leaking.  I failed to realize that it's the timer leak
> itself that translates into a sigpending count leak.
> 
> Indeed, ignore that patch, and wait for the posix-timers leak fix coming soon.

Cool, thanks for the follow up.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
