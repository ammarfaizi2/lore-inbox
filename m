Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263667AbTJCEfu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 00:35:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263668AbTJCEfu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 00:35:50 -0400
Received: from [203.145.184.221] ([203.145.184.221]:60554 "EHLO naturesoft.net")
	by vger.kernel.org with ESMTP id S263667AbTJCEfh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 00:35:37 -0400
From: Shine Mohamed <shinemohamed_j@naturesoft.net>
Organization: Naturesoft
To: Rusty Russell <rusty@rustcorp.com.au>, "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: [PATCH] Initializedd the module parameters in drivers/net/wireless/arlan-main.c
Date: Fri, 3 Oct 2003 10:06:22 +0530
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <20031002053307.640D92C14D@lists.samba.org>
In-Reply-To: <20031002053307.640D92C14D@lists.samba.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310031006.22313.shinemohamed_j@naturesoft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 October 2003 10:48, Rusty Russell wrote:
> In message <20031001205228.3bee8c69.rddunlap@osdl.org> you write:
> > On Wed, 01 Oct 2003 19:01:04 +1000 Rusty Russell <rusty@rustcorp.com.au> 
wrote:
> > | This is clearly wrong: it's declared below.
> >
> > Hello.  Anybody there?
> >
> > This is what you get with 2.6.0-test6 plain vanilla:
> > drivers/net/wireless/arlan-main.c:1923: `probe' undeclared (first use in
> > this function) drivers/net/wireless/arlan-main.c:1923: (Each undeclared
> > identifier is reported only once drivers/net/wireless/arlan-main.c:1923:
> > for each function it appears in.)
>
> See line 1885:
>
> 	#ifdef  MODULE
>
> 	static int probe = probeUNKNOWN;

This declaration was added only in 2.6.0-test6-bk1
not in the vanilla 2.6.0-test6


>
> 	static int __init arlan_find_devices(void)
>
> Hope that helps,
> Rusty.
> --
>   Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Regards,
Shine Mohamed
