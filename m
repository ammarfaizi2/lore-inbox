Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266943AbSLKBfT>; Tue, 10 Dec 2002 20:35:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266932AbSLKBfT>; Tue, 10 Dec 2002 20:35:19 -0500
Received: from bitmover.com ([192.132.92.2]:12497 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S266962AbSLKBfO>;
	Tue, 10 Dec 2002 20:35:14 -0500
Date: Tue, 10 Dec 2002 17:42:53 -0800
From: Larry McVoy <lm@bitmover.com>
To: Larry McVoy <lm@bitmover.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BK prob] - bogus cset
Message-ID: <20021210174253.A29772@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
References: <200212110140.gBB1e1o30094@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200212110140.gBB1e1o30094@work.bitmover.com>; from lm@bitmover.com on Tue, Dec 10, 2002 at 05:40:01PM -0800
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

By the way, the set of people who need to clean up are:

agoddard
aliz
andersg
anton
chrisl
cloos
frival
fsirl
peterc
purna
riel
rp
steve
vonbrand

according to the logs.

On Tue, Dec 10, 2002 at 05:40:01PM -0800, Larry McVoy wrote:
> I'm an idiot, in the process of optimizing the logging code (so you modem
> users send less data, a big deal in Europe), I put a test cset into the
> main tree at bk://linux.bkbits.net/linux-2.5 and a pile of people pulled
> it.  
> 
> Could you please do this:
> 
> bk findkey 'lm@work.bitmover.com|ChangeSet|20021211000341|36093' ChangeSet
> 
> If that returns nothing, you're fine.  If it tells you a revision, then
> if that is the most recent revision, just do a 
> 
> 	bk undo -fr`bk findkey 'lm@work.bitmover.com|ChangeSet|20021211000341|36093' ChangeSet`
> 
> and you're all set.  If that isn't the most recent revision, i.e., you merged
> against that, send me an email and I'll straighten out the tree.
> 
> Sorry about this, it won't happen again.
> 
> --lm
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
