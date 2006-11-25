Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967213AbWKYV2s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967213AbWKYV2s (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 16:28:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967214AbWKYV2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 16:28:48 -0500
Received: from smtp.osdl.org ([65.172.181.25]:10989 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S967213AbWKYV2r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 16:28:47 -0500
Date: Sat, 25 Nov 2006 13:26:51 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: David Miller <davem@davemloft.net>
cc: samuel@sortiz.org, a.p.zijlstra@chello.nl,
       irda-users@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       mingo@elte.hu, arvidjaar@mail.ru, akpm@osdl.org
Subject: Re: [PATCH] Revert "[IRDA]: Lockdep fix."
In-Reply-To: <20061125.130927.87744078.davem@davemloft.net>
Message-ID: <Pine.LNX.4.64.0611251324260.3483@woody.osdl.org>
References: <20061125152649.GA5698@sortiz.org> <20061125.130927.87744078.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 25 Nov 2006, David Miller wrote:
> 
> Why is everyone so impatient about this issue?  Just wait for Andrew
> to merge the fix and all will be well :-)

No, I think this was a total failure. We should have reverted it 
immediately rather than waiting for the fix. Especially as the damn thing 
wasn't even all that important.

I now (finally) have the patch from Andrew, but we should _not_ have had 
this thing broken for three days. It should have gotten reverted on the 
first report of trouble, instead of us telling people to just wait.

Broken compiles are simply not acceptable. Patches that cause them should 
be reverted _immediately_ unless a fix is available as quickly (which it 
wasn't due to turkey-day).

No excuses. People _should_ be impatient about idiotic failures like this.

		Linus
