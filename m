Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273244AbTHKSCe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 14:02:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273185AbTHKSCU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 14:02:20 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:63903 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S273052AbTHKSAW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 14:00:22 -0400
Date: Mon, 11 Aug 2003 10:59:41 -0700
From: Larry McVoy <lm@bitmover.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Larry McVoy <lm@bitmover.com>, davej@redhat.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, dri-devel@lists.sourceforge.net
Subject: Re: [PATCH] CodingStyle fixes for drm_agpsupport
Message-ID: <20030811175941.GB4879@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Jeff Garzik <jgarzik@pobox.com>, Larry McVoy <lm@bitmover.com>,
	davej@redhat.com, torvalds@osdl.org, linux-kernel@vger.kernel.org,
	dri-devel@lists.sourceforge.net
References: <E19mF4Y-0005Eg-00@tetrachloride> <20030811164012.GB858@work.bitmover.com> <3F37CB44.5000307@pobox.com> <20030811170425.GA4418@work.bitmover.com> <3F37CF4E.3010605@pobox.com> <20030811172333.GA4879@work.bitmover.com> <3F37D80D.5000703@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F37D80D.5000703@pobox.com>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 11, 2003 at 01:53:17PM -0400, Jeff Garzik wrote:
> Larry McVoy wrote:
> are function calls at a 10-nanosecond glance.  Also, having two styles 
> of 'if' formatting in your example just screams "inconsistent" to me :)

It is inconsistent, on purpose.  It's essentially like perl's

	return unless pointer;

which is a oneliner, almost like an assert().

Maybe this will help: I insist on braces on anything with indentation so
that I can scan them more quickly.  If I gave you a choice between

	if (!pointer) {
		return (whatever);
	}

	if (!pointer) return (whatever);

which one will you type more often?  I actually don't care which you use,
I prefer the shorter one because I don't measure my self worth in lines 
of code generated, I tend to favor lines of code deleted :)  But either
one is fine, I tend to use the first one if it has been a problem area
and I'm likely to come back and shove in some debugging.

Before you say "lose the braces" try reading more code and see how much faster
it is if all indented stuff has braces.  You whiz through it.

> Absolutely not.  I'm cooler, so my opinion counts more.

You are in North Carolina, I'm in San Francisco.  No competition, you are
sweating like a pig :)

> >Same for your eyes when you get to my age.  
> 
> I bet when you were in school, you had to chip your homework into slate, 
> and dinner was brontosaurus-kebob, right?

Dinner?  You got dinner?  Damn, you were spoiled.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
