Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261428AbTFOAIM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 20:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261444AbTFOAIL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 20:08:11 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:46536 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S261428AbTFOAIL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 20:08:11 -0400
Date: Sat, 14 Jun 2003 17:21:53 -0700
From: Larry McVoy <lm@bitmover.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.71
Message-ID: <20030615002153.GA20896@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.3,
	required 7, AWL)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus said:
> I think I'll call this kernel the "sticky turtle", in honor of that 
> historic "greased weasel" kernel, and as a comment on how sadly dependent 
> I've become on the daily BK snapshots. It's been too long since 2.5.70.

I think more releases are good but for the snapshot people...

There are multiple options:

	bk pull bk://linux.bkbits.net/linux-2.5
	cvs -d:pserver:anonymous@kernel.bkbits.net:/home/cvs co linux-2.5

and Ben Collins is working on a bkSVN gateway (it's actually a
BK->CVS->SVN but whatever) so that will be an option soon as well.  Huh,
while I'm thinking about it since we're hosting the CVS tree there is no
good reason not to host the SVN tree as well, I have to believe that SVN
uses less bandwidth than CVS (please, say it's so).  Ben, send me or Davem
an ssh2 key and we'll set you up with an account on kernel.bkbits.net.
This isn't some advertising ploy so feel free to make some DNS entry which
points there, like svn.kernel.org, and then there is no BK in the picture.
HPA can help you with that.  In fact, hpa, weren't we going to make a 
cvs.kernel.org?  If so, how about pointing that at kernel.bkbits.net for
the time being and then if someone steps forward to host that you can
just change the DNS entry?
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
