Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265198AbTBOVnH>; Sat, 15 Feb 2003 16:43:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265201AbTBOVnG>; Sat, 15 Feb 2003 16:43:06 -0500
Received: from bitmover.com ([192.132.92.2]:13268 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S265198AbTBOVnF>;
	Sat, 15 Feb 2003 16:43:05 -0500
Date: Sat, 15 Feb 2003 13:52:59 -0800
From: Larry McVoy <lm@bitmover.com>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Larry McVoy <lm@bitmover.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: openbkweb-0.0
Message-ID: <20030215215259.GA22512@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Davide Libenzi <davidel@xmailserver.org>,
	Larry McVoy <lm@bitmover.com>, lkml <linux-kernel@vger.kernel.org>
References: <20030214235724.GA24139@work.bitmover.com> <Pine.LNX.4.44.0302151207390.13273-100000@xanadu.home> <20030215181211.GA12315@work.bitmover.com> <Pine.LNX.4.50.0302151353180.1891-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0302151353180.1891-100000@blue1.dev.mcafeelabs.com>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 15, 2003 at 01:56:02PM -0800, Davide Libenzi wrote:
> Larry, I already said this and maybe you missed it ( or maybe not ).
> What about having a GPLed ( or whatever other license ), read-only BK
> available for the ones that simply need to fetch stuff from BK
> repositories ? You don't have to maintain another repository for
> compatibility, and also you enforce BK usage.

We're not going to expose the network protocol.  For two reasons: 
    - it works really well (we're proud of this)
    - it is really ugly (we're not proud of this :)

A read only client isn't read only, it has to be read/write to update the
out of date copy.

Believe me, if there was an easy way to give away a version that was not
a problem we would have long since done that.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
