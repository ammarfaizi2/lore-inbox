Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266471AbUBLOvH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 09:51:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266472AbUBLOvG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 09:51:06 -0500
Received: from dp.samba.org ([66.70.73.150]:58521 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S266471AbUBLOu4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 09:50:56 -0500
Date: Fri, 13 Feb 2004 01:47:29 +1100
From: Anton Blanchard <anton@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.3-rc2-mm1
Message-ID: <20040212144729.GI25922@krispykreme>
References: <20040212015710.3b0dee67.akpm@osdl.org> <20040212031322.742b29e7.akpm@osdl.org> <20040212115718.GF25922@krispykreme> <20040212040910.3de346d4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040212040910.3de346d4.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > A few questions spring to mind. Like who wrote that dodgy patch? 
> The dog wrote my homework?

> > And any ideas how said person (who will remain nameless) broke ia32?
> Not really.  I spent a couple of hours debugging the darn thing, then gave
> up and used binary search to find the offending patch.

Ouch, you'll never get those hours back and you have me to thank for it.

> <looks>
> include/asm-i386/hardirq.h:IRQ_EXIT_OFFSET needs treatment, I bet.  

Yep. I wonder why DEBUG_SPINLOCK_SLEEP didnt depend on PREEMPT.

Anton
