Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264590AbTFANNG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 09:13:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264592AbTFANNF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 09:13:05 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:15044 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S264590AbTFANNE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 09:13:04 -0400
Date: Sun, 1 Jun 2003 06:26:26 -0700
From: Larry McVoy <lm@bitmover.com>
To: Steven Cole <elenstev@mesatop.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Question about style when converting from K&R to ANSI C.
Message-ID: <20030601132626.GA3012@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Steven Cole <elenstev@mesatop.com>, linux-kernel@vger.kernel.org
References: <1054446976.19557.23.camel@spc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1054446976.19557.23.camel@spc>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 31, 2003 at 11:56:16PM -0600, Steven Cole wrote:
> Proposed conversion:
> 
> int foo(void)
> {
>    	/* body here */
> }	

Sometimes it is nice to be able to see function names with a 

	grep '^[a-zA-Z].*(' *.c

which is why I've always preferred

int
foo(void)
{
	/* body here */
}	

Is there some reason that I'm missing that the kernel folks like it the other
way?  
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
