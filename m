Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266354AbUBLL7V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 06:59:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266369AbUBLL7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 06:59:21 -0500
Received: from dp.samba.org ([66.70.73.150]:52176 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S266354AbUBLL7U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 06:59:20 -0500
Date: Thu, 12 Feb 2004 22:57:18 +1100
From: Anton Blanchard <anton@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.3-rc2-mm1
Message-ID: <20040212115718.GF25922@krispykreme>
References: <20040212015710.3b0dee67.akpm@osdl.org> <20040212031322.742b29e7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040212031322.742b29e7.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> This kernel and also 2.6.3-rc1-mm1 have a nasty bug which causes
> current->preempt_count to be decremented by one on each hard IRQ.  It
> manifests as a BUG() in the slab code early in boot.
> 
> Disabling CONFIG_DEBUG_SPINLOCK_SLEEP will fix this up.  Do not use this
> feature on ia32, for it is bust.

A few questions spring to mind. Like who wrote that dodgy patch? 
And any ideas how said person (who will remain nameless) broke ia32?

Anton
