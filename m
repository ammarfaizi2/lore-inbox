Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967209AbWKYVJP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967209AbWKYVJP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 16:09:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967210AbWKYVJP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 16:09:15 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:52660
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S967209AbWKYVJO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 16:09:14 -0500
Date: Sat, 25 Nov 2006 13:09:27 -0800 (PST)
Message-Id: <20061125.130927.87744078.davem@davemloft.net>
To: samuel@sortiz.org
Cc: torvalds@osdl.org, a.p.zijlstra@chello.nl,
       irda-users@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       mingo@elte.hu, arvidjaar@mail.ru, akpm@osdl.org
Subject: Re: [PATCH] Revert "[IRDA]: Lockdep fix."
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061125152649.GA5698@sortiz.org>
References: <20061125152649.GA5698@sortiz.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Samuel Ortiz <samuel@sortiz.org>
Date: Sat, 25 Nov 2006 17:26:49 +0200

> Hi Linus,
> 
> commit 700f9672c9a61c12334651a94d17ec04620e1976 breaks IrDA as irlmp.c
> can no longer build. 
> This is due to the spin_lock_irqsave_nested() patches being in the -mm 
> tree and not yet in yours.
> I'll resend the patch once both trees are synchronized.
> 
> This reverts commit 700f9672c9a61c12334651a94d17ec04620e1976.
> Signed-off-by: Samuel Ortiz <samuel@sortiz.org>

Andrew is going to merge the necessary infrastructure to Linus, please
don't revert this change.

Why is everyone so impatient about this issue?  Just wait for Andrew
to merge the fix and all will be well :-)
