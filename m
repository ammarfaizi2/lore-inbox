Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264651AbTFAPtL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 11:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264652AbTFAPtL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 11:49:11 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:14791 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S264651AbTFAPtK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 11:49:10 -0400
Date: Sun, 1 Jun 2003 09:02:28 -0700
From: Larry McVoy <lm@bitmover.com>
To: Steven Cole <elenstev@mesatop.com>
Cc: Larry McVoy <lm@bitmover.com>, Willy Tarreau <willy@w.ods.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Question about style when converting from K&R to ANSI C.
Message-ID: <20030601160228.GB3012@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Steven Cole <elenstev@mesatop.com>, Larry McVoy <lm@bitmover.com>,
	Willy Tarreau <willy@w.ods.org>, linux-kernel@vger.kernel.org
References: <1054446976.19557.23.camel@spc> <20030601132626.GA3012@work.bitmover.com> <20030601134942.GA10750@alpha.home.local> <20030601140602.GA3641@work.bitmover.com> <1054479734.19552.51.camel@spc> <20030601150951.GC3641@work.bitmover.com> <1054482640.19552.69.camel@spc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1054482640.19552.69.camel@spc>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have used more traditional style where the new Linus style was not
> warranted.  Here is the patch for fs/jfs/jfs_xtree.c:
> 
> --- bk-current/fs/jfs/jfs_xtree.c	2003-05-31 20:30:47.000000000 -0600
> +++ linux/fs/jfs/jfs_xtree.c	2003-05-31 21:02:14.000000000 -0600
> @@ -4225,8 +4225,7 @@
>   *      at the current entry at the current subtree root page
>   *
>   */
> -int xtGather(t)
> -btree_t *t;
> +int xtGather(btree_t *t)
>  {
>  	int rc = 0;
>  	xtpage_t *p;
> 
> I haven't yet sent that to the maintainer (worked until late last night
> and still getting -ENOTENOUGHCOFFEE from brain).  
> 
> Anyway, I agree that more traditional styles should be used unless
> otherwise indicated, but having the return type on the same line as the
> function name is something I've warmed up to.  

OK, whatever.  But are you planning on trying to reformat the kernel and
get that pushed into the mainline?  That's a fool's errand for lots of 
reasons.  Nobody is going to get excited about having to look through 
tons of patches which are all white space changes.  And it screws up
the revision history.  Annotated listings and being able to go from that
to the patch are a nice thing.  If you get all this stuff applied you 
are hiding the real authorship of each of these function declarations.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
