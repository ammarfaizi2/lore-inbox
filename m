Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261685AbUERBx3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261685AbUERBx3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 21:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262175AbUERBx3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 21:53:29 -0400
Received: from gate.crashing.org ([63.228.1.57]:53420 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261685AbUERBx2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 21:53:28 -0400
Subject: Re: 1352 NUL bytes at the end of a page? (was Re: Assertion `s &&
	s->tree' failed: The saga continues.)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Steven Cole <elenstev@mesatop.com>, Andrew Morton <akpm@osdl.org>,
       adi@bitmover.com, scole@lanl.gov, support@bitmover.com,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0405151914280.10718@ppc970.osdl.org>
References: <200405132232.01484.elenstev@mesatop.com>
	 <5.1.0.14.2.20040515130250.00b84ff8@171.71.163.14>
	 <20040514204153.0d747933.akpm@osdl.org>
	 <200405151923.41353.elenstev@mesatop.com>
	 <Pine.LNX.4.58.0405151914280.10718@ppc970.osdl.org>
Content-Type: text/plain
Message-Id: <1084844857.15175.17.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 18 May 2004 11:47:38 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-05-16 at 12:18, Linus Torvalds wrote:
> On Sat, 15 May 2004, Steven Cole wrote:
> > 
> > In the spirit of 'rounding up the usual suspects', I'll unset CONFIG_PREEMT
> > and try again.
> 
> Thanks. If that doesn't do it, can you start binary-searching on kernel 
> versions? I run with preempt myself (well, not on my current G5 desktop, 
> but otherwise), so it _should_ be stable, but you may have a driver or 
> something else that doesn't like preempt.

Heh ;) Well... PREEMPT for ppc64 is planned :)

> Or it could be any number of other config options. Do you have anything 
> else interesting enabled?
> 
> 		Linus
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

