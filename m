Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263913AbTDHAcx (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 20:32:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263909AbTDHAcL (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 20:32:11 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:6888 "EHLO smtp.bitmover.com")
	by vger.kernel.org with ESMTP id S263852AbTDHAb6 (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 20:31:58 -0400
Date: Mon, 7 Apr 2003 17:30:34 -0700
From: Larry McVoy <lm@bitmover.com>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Petr Baudis <pasky@ucw.cz>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: BitBucket: GPL-ed KitBeeper clone
Message-ID: <20030408003034.GA10170@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Chuck Ebbert <76306.1226@compuserve.com>,
	Petr Baudis <pasky@ucw.cz>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <200304072001_MC3-1-336C-9045@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304072001_MC3-1-336C-9045@compuserve.com>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 07, 2003 at 07:57:49PM -0400, Chuck Ebbert wrote:
> 
> >FYI, the SVN and Arch folks have set up a mailing list
> >for discussion about generic "smarter patch" format, see
> >http://www.red-bean.com/mailman/listinfo/changesets for
> >details/subscription.
> 
> 
> Have you looked at Stellation at all?  I know the
> code itself is Java but they have some neat ideas about
> being able to take 'slices' across the repository and
> treat the slice as a single file for things like revision
> tracking.  

Except that those are ideas as far as I can tell, not actual code.  In the
for what it is worth department, we've done this internally and found
it doesn't work as well as you might hope.  Sometimes there are clear
delinations and you really can move stuff around but most of the time
there is stuff built on top of the stuff you want to move and there is
no way for a program to tell the difference between enhancements vs fixes
to the original change.  Because of this, we've developed a policy, which
is very hard to make stick, which is "one idea, one changeset, no fixes".
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
