Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262915AbTIAOHZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 10:07:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262919AbTIAOHZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 10:07:25 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:53735 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S262915AbTIAOHX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 10:07:23 -0400
Date: Mon, 1 Sep 2003 07:07:06 -0700
From: Larry McVoy <lm@bitmover.com>
To: Albert Cahalan <albert@users.sourceforge.net>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, ak@suse.de, lm@bitmover.com
Subject: Re: bitkeeper comments
Message-ID: <20030901140706.GG18458@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Albert Cahalan <albert@users.sourceforge.net>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>, ak@suse.de, lm@bitmover.com
References: <1062389729.314.31.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1062389729.314.31.camel@cube>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 01, 2003 at 12:15:30AM -0400, Albert Cahalan wrote:
> This just got into BitKeeper, about 10 hours ago:
> 
> > [PATCH] x86-64 update
> >
> > Make everything compile and boot again.
> >
> > The earlier third party ioport.c changes unfortunately
> > didn't even compile, fix that too.
> >
> > - Update defconfig
> > - Some minor cleanup
> > - Introduce physid_t for APIC masks (fixes UP kernels)
> > - Finish ioport.c merge and fix compilation
> 
> Several days ago, I mailed Andi Kleen a build log which
> showed that ioport.c builds perfectly well on x86-64.
> The whole 2.6.0-test4 kernel does in fact, as downloaded
> from kernel.org. Andi Kleen agreed...
> 
> ...and now this comment gets submitted to Linus, ending
> up in BitKeeper. I'd like this changed. I realize that
> it may be a rather difficult thing to change at this point,
> but it is clearly wrong.

If you want the comments changed I can do that on bkbits.net and anyone
who grabs the update from there will get the new comments.  If you want
the patch gone out of BK anyone can do that with a cset -x.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
