Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263169AbUKTUSi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263169AbUKTUSi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 15:18:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263171AbUKTUSi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 15:18:38 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:60101 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S263169AbUKTUSg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 15:18:36 -0500
Date: Sat, 20 Nov 2004 21:18:35 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Anton Blanchard <anton@samba.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Six archs are missing atomic_inc_return()
Message-ID: <20041120201835.GA1847@mail.13thfloor.at>
Mail-Followup-To: Chuck Ebbert <76306.1226@compuserve.com>,
	Anton Blanchard <anton@samba.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <200411181816_MC3-1-8EFB-D509@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411181816_MC3-1-8EFB-D509@compuserve.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2004 at 06:14:06PM -0500, Chuck Ebbert wrote:
> Anton wrote:
> 
> > $ grep -l atomic_inc_return include/asm-*/atomic.h
> 
> 
>   I was assuming all archs used a macro for this, so I used:
> 
> $ grep 'define atomic_inc_return' asm-*/atomic.h
> 
> 
>   But your grep could have found this:
> 
>         /* FIXME: this arch does not have atomic_inc_return */
> 
> and returned a false positive.
> 
> 
>   What I need is a C-aware grep:
> 
> $ cgrep [--definition | --comment | --usage] atomic_inc_return asm-*/atomic.h
> 
> to search definitions, comments, and code body respectively.

what about cscope or c-tags?

best,
Herbert

> --Chuck Ebbert  18-Nov-04  18:08:49
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
