Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261192AbTIABdq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 21:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261367AbTIABdq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 21:33:46 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:722 "EHLO smtp.bitmover.com")
	by vger.kernel.org with ESMTP id S261192AbTIABdp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 21:33:45 -0400
Date: Sun, 31 Aug 2003 18:33:35 -0700
From: Larry McVoy <lm@bitmover.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Jamie Lokier <jamie@shareable.org>, Larry McVoy <lm@bitmover.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Pascal Schmidt <der.eremit@email.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bandwidth for bkbits.net (good news)
Message-ID: <20030901013335.GF18458@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Andrea Arcangeli <andrea@suse.de>,
	Jamie Lokier <jamie@shareable.org>, Larry McVoy <lm@bitmover.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Pascal Schmidt <der.eremit@email.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030831164802.GA12752@work.bitmover.com> <20030831170633.GA24409@dualathlon.random> <20030831211855.GB12752@work.bitmover.com> <20030831224938.GC24409@dualathlon.random> <20030831225639.GB16620@work.bitmover.com> <20030831231305.GE24409@dualathlon.random> <20030901001819.GC29239@mail.jlokier.co.uk> <20030901002815.GB11503@dualathlon.random> <20030901005041.GC31531@mail.jlokier.co.uk> <20030901011055.GE11503@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030901011055.GE11503@dualathlon.random>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 01, 2003 at 03:10:55AM +0200, Andrea Arcangeli wrote:
> now apparently bkbits.net has nothing to do with it, and it's all about
> the http server. 

BK _is_ an http server.  The same daemon you talk to for clones is the
HTTP server.  That's one and the same machine.

> however keep in mind you will somehow throttle the number of syns too,
> unless every single syn arrives to the webserver from a different user
> (unlikely).

That's exactly the situation that any busy server has.  Which is
why I kept saying "tell me how you made this work for a busy server".
"Busy server" by definition in this context at least means a server that
is getting lots of connection requests from lots of different users.

Why that isn't obvious to you I don't understand.  This is bkbits.net.
Yeah, it's not slashdot or anything but there are something like 400
branches of the Linux kernel on it and that's ignoring all other projects.
It's the web server which provides insight into the Linux kernel source
base, of course it is busy.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
