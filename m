Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262681AbTI1S6W (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 14:58:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262683AbTI1S6W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 14:58:22 -0400
Received: from smtp1.clear.net.nz ([203.97.33.27]:37352 "EHLO
	smtp1.clear.net.nz") by vger.kernel.org with ESMTP id S262681AbTI1S6V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 14:58:21 -0400
Date: Mon, 29 Sep 2003 06:48:58 +1200
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: pm: Revert swsusp to 2.6.0-test3
In-reply-to: <Pine.LNX.4.44.0309281038270.6307-100000@home.osdl.org>
To: Linus Torvalds <torvalds@osdl.org>, Patrick Mochel <mochel@osdl.org>,
       Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1064774937.18769.9.camel@laptop-linux>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.2
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <Pine.LNX.4.44.0309281038270.6307-100000@home.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Could you also give me some clear direction on where you want me to put
my 2.4 port. Should it go in kernel/power, or somewhere else? (I'm
assuming you don't want 3 versions of swsusp?!). I'd like to put it in
the right place when I start populating swsusp25.bkbits.net, so you're
not pulling changesets later that only move the code around (I know bk
reduces the cost, but...).

Regards,

Nigel

On Mon, 2003-09-29 at 05:40, Linus Torvalds wrote:
> On 28 Sep 2003 pavel@ucw.cz wrote:
> > 
> > This should not be warring patch. Pat
> > already has variant in his tree,
> > feel free to pull from him - but it
> > would be nice to have working swsusp
> > in -test6. --p
> 
> Ok. In that case, can we remove the '#if 0' blocks entirely, or at least 
> add a big comment on why they are there but disabled?
> 
> I'd also like to have some kind of readme or similar on the different 
> suspend/resume issues, and why we have two different approaches. Hmm?
> 
> 		Linus
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

You see, at just the right time, when we were still powerless,
Christ died for the ungodly.
	-- Romans 5:6, NIV.

