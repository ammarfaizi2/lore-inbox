Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265149AbUFHDbR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265149AbUFHDbR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 23:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265170AbUFHDbR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 23:31:17 -0400
Received: from bhhdoa.org.au ([216.17.101.199]:41480 "EHLO bhhdoa.org.au")
	by vger.kernel.org with ESMTP id S265149AbUFHDbP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 23:31:15 -0400
Message-ID: <1086656871.40c511673eca5@vds.kolivas.org>
Date: Tue,  8 Jun 2004 11:07:51 +1000
From: Con Kolivas <kernel@kolivas.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, Phy Prabab <phyprabab@yahoo.com>,
       linux-kernel@vger.kernel.org, zwane@linuxpower.ca, wli@holomorphy.com
Subject: Re: [PATCH] Staircase Scheduler v6.3 for 2.6.7-rc2
References: <200406080712.44759.kernel@kolivas.org> <20040607214034.27475.qmail@web51807.mail.yahoo.com> <20040607195011.34f8e84e.akpm@osdl.org> <40C52CFF.4080207@yahoo.com.au>
In-Reply-To: <40C52CFF.4080207@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Nick Piggin <nickpiggin@yahoo.com.au>:

> Andrew Morton wrote:
> 
> > At a guess I'd say either a) you're hitting some path in the kernel which
> > is going for a giant and bogus romp through memory, trashing CPU caches or
> > b) your workload really dislikes run-child-first-after-fork or c) the page
> > allocator is serving up pages which your access pattern dislikes or d)
> > something else.
> > 
> 
> e) it's the staircase scheduler patch?
> 

Phy Prabab wrote:
>Could anyone suggest a way to understand why the
>difference between the 2.6 kernels and the 2.4
>kernels

I guess Phy better tell us if it's unique to staircase; and if so there's
clearly a bug unique to it.

Con
