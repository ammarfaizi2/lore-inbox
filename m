Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750991AbWDVTQP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbWDVTQP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 15:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750987AbWDVTQN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 15:16:13 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:29113 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1750982AbWDVTQI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 15:16:08 -0400
Subject: Re: [PATCH] 'make headers_install' kbuild target.
From: David Woodhouse <dwmw2@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, sam@ravnborg.org
In-Reply-To: <20060422141134.GC5010@stusta.de>
References: <1145672241.16166.156.camel@shinybook.infradead.org>
	 <20060422093328.GM19754@stusta.de>
	 <1145707384.16166.181.camel@shinybook.infradead.org>
	 <20060422123835.GA5010@stusta.de>
	 <1145710123.11909.241.camel@pmac.infradead.org>
	 <20060422132032.GB5010@stusta.de>
	 <1145712964.11909.258.camel@pmac.infradead.org>
	 <20060422141134.GC5010@stusta.de>
Content-Type: text/plain
Date: Sat, 22 Apr 2006 15:26:14 +0100
Message-Id: <1145715974.11909.272.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-04-22 at 16:11 +0200, Adrian Bunk wrote:
> Sorry, but I'm not a fan of doing much more work than required instead 
> of getting a consensus first and then implementing the solution.

It _isn't_ significantly more work. The _real_ work is in reading
through the header files and deciding which parts should be private and
which can be public, then splitting them up accordingly into separate
files (or using 'ifdef __KERNEL__' if appropriate). That's the kind of
thing that you seem particularly good at, which is why I've asked if you
could help us with it.

Moving the public files from one directory to another, if they've been
suitably marked or listed somewhere, is _trivial_. Even if you've used
#ifdef __KERNEL__ it's simple enough to do it automatically with tools
like unifdef. The _real_ work which requires human attention is the same
either way.

But if you're not willing to help, that's fine. I just thought you'd be
particularly suited to the task, that's all.

-- 
dwmw2

