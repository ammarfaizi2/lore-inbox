Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262280AbUJZO3j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262280AbUJZO3j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 10:29:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262281AbUJZO3j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 10:29:39 -0400
Received: from ipcop.bitmover.com ([192.132.92.15]:53632 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S262280AbUJZO3b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 10:29:31 -0400
Date: Tue, 26 Oct 2004 07:23:21 -0700
From: Larry McVoy <lm@bitmover.com>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Larry McVoy <lm@bitmover.com>, Jon Smirl <jonsmirl@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: BK kernel workflow
Message-ID: <20041026142321.GA4729@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Chuck Ebbert <76306.1226@compuserve.com>,
	Larry McVoy <lm@bitmover.com>, Jon Smirl <jonsmirl@gmail.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <200410260340_MC3-1-8D30-9CCE@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410260340_MC3-1-8D30-9CCE@compuserve.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2004 at 03:38:06AM -0400, Chuck Ebbert wrote:
> Larry McVoy wrote:
> 
> > we're working bug database integration, we're working
> > on review queues, we're working on project management, we're working on
> > large binary management, etc.
> 
>   How about support for backporting patches, e.g. backport csets
> 1.2000.4.120 and 1.2000.12.16 to kernel 2.6.9?  I could see no way to get
> bk to spit out these two changes as patches against 2.6.9.  Given all the info
> in there this should be trivial...

Trivial?  Sure, if the patches apply cleanly.  Not trivial if the changesets
have other changesets in the way.

But I have a 70 line shell script which does this, I'm not sure why you can't
write the same thing.

>   But first you should write some actual documentation and fix your programs
> so they emit error messages when something goes wrong:
> 
> [me@d4 linux-2.6]$ bk c2r -r@v2.6.9 mm/vmscan.c
> [me@d4 linux-2.6]$                                               <--- what???

That's because you didn't read the documentation which you appear to love 
so much.

work /tmp/linux-2.5 bk c2r -rv2.6.9 mm/vmscan.c
1.231

>   'bk help terms' says a tag can be used, but apparently not and there's
> no error message.

You passed a legal rev syntax to the command.  I can't help it if you don't
understand the tool.

>   Then there's this one:
> 
> [me@d4 linux-2.6]$ bk difftool -rv2.6.8 -rv2.6.9 mm/vmscan.c     <--- forgot the @
> child process exited abnormally                                  <--- hee hee!
> 
>   I like the way the GUI flashes up on the screen then abruptly disappears, leaving
> the user wondering what happened.

You know, I like the way you politely offer to help out by sending in
patches to the documentation for this tool which you get to use for free.
You are an inspiration to us and you are just the sort of user we love
to help.

> > The list goes on, if anyone wants to come work on it we are always looking
> > for good systems people and we pay well.
> 
>   But you're located in a large American metro area, a.k.a. "hell on earth."

No worries, Chuck, after careful consideration of your skills we don't see
a match at this time.  But we'll keep your resume on file and thanks for
your interest.
-- 
---
Larry McVoy                lm at bitmover.com           http://www.bitkeeper.com
