Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264863AbUEPCSo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264863AbUEPCSo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 22:18:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264865AbUEPCSo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 22:18:44 -0400
Received: from fw.osdl.org ([65.172.181.6]:57828 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264863AbUEPCSn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 22:18:43 -0400
Date: Sat, 15 May 2004 19:18:37 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Steven Cole <elenstev@mesatop.com>
cc: Andrew Morton <akpm@osdl.org>, adi@bitmover.com, scole@lanl.gov,
       support@bitmover.com, linux-kernel@vger.kernel.org
Subject: Re: 1352 NUL bytes at the end of a page? (was Re: Assertion `s &&
 s->tree' failed: The saga continues.)
In-Reply-To: <200405151923.41353.elenstev@mesatop.com>
Message-ID: <Pine.LNX.4.58.0405151914280.10718@ppc970.osdl.org>
References: <200405132232.01484.elenstev@mesatop.com>
 <5.1.0.14.2.20040515130250.00b84ff8@171.71.163.14> <20040514204153.0d747933.akpm@osdl.org>
 <200405151923.41353.elenstev@mesatop.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 15 May 2004, Steven Cole wrote:
> 
> In the spirit of 'rounding up the usual suspects', I'll unset CONFIG_PREEMT
> and try again.

Thanks. If that doesn't do it, can you start binary-searching on kernel 
versions? I run with preempt myself (well, not on my current G5 desktop, 
but otherwise), so it _should_ be stable, but you may have a driver or 
something else that doesn't like preempt.

Or it could be any number of other config options. Do you have anything 
else interesting enabled?

		Linus
