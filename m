Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265255AbTLLPLH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 10:11:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265256AbTLLPLH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 10:11:07 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:58348 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S265255AbTLLPLE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 10:11:04 -0500
Date: Fri, 12 Dec 2003 07:10:59 -0800
From: Larry McVoy <lm@bitmover.com>
To: Rui Saraiva <rmps@joel.ist.utl.pt>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sparse/TSCT BitKeeper repository
Message-ID: <20031212151059.GA11561@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Rui Saraiva <rmps@joel.ist.utl.pt>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0312120414360.8280@joel.ist.utl.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0312120414360.8280@joel.ist.utl.pt>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kernel.bkbits.net is back online but the repos haven't been restored yet.
I'm leaving that to Dave and Linus.  I'll nudge them.

On Fri, Dec 12, 2003 at 04:49:46AM +0000, Rui Saraiva wrote:
> 
> Where is the sparse BK repository that used to be
> bk://kernel.bkbits.net/torvalds/sparse ?
> It seems there is an older version at bk://linux-dj.bkbits.net/sparse
> 
> Also in the subject, I got lots of "attribute 'alias': unknown attribute"
> warnings in the kernel source in lines with module_init(), module_exit()
> and others. A simple fix might be
> 
> 	if (match_string_ident(attribute, "alias"))
> 		return NULL;
> 
> near the end of handle_attribute() in parse.c
> 
> 
> Regards,
> 	Rui Saraiva
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
