Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264667AbTFAQje (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 12:39:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264668AbTFAQje
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 12:39:34 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:63431 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S264667AbTFAQjd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 12:39:33 -0400
Date: Sun, 1 Jun 2003 09:52:52 -0700
From: Larry McVoy <lm@bitmover.com>
To: Steven Cole <elenstev@mesatop.com>
Cc: Larry McVoy <lm@bitmover.com>, Jonathan Lundell <linux@lundell-bros.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Question about style when converting from K&R to ANSI C.
Message-ID: <20030601165252.GD3012@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Steven Cole <elenstev@mesatop.com>, Larry McVoy <lm@bitmover.com>,
	Jonathan Lundell <linux@lundell-bros.com>,
	linux-kernel@vger.kernel.org
References: <1054446976.19557.23.camel@spc> <20030601132626.GA3012@work.bitmover.com> <20030601134942.GA10750@alpha.home.local> <20030601140602.GA3641@work.bitmover.com> <p05210609baffd3a79cfb@[207.213.214.37]> <20030601161133.GC3012@work.bitmover.com> <1054485978.19557.93.camel@spc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1054485978.19557.93.camel@spc>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Thanks for the input.  You've convinced me.  When going through
> arch/ppc/xmon/xmon.c, I will leave things like the following unchanged:
> 
> /* Command interpreting routine */
> static int
> cmds(struct pt_regs *excp)
> {

Great.

> My changes will be similar to the following:
> 
> @@ -1837,9 +1818,7 @@
>         return *lineptr++;
>  }
> 
> -void
> -take_input(str)
> -char *str;
> +void take_input(char *str)
>  {
>         lineptr = str;
>  }

OK, I'm confused.  You said you were convinced but then shouldn't that be

void
take_input(char *str)
{
       lineptr = str;
}

??
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
