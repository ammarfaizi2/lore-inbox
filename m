Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964804AbVLBCgr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964804AbVLBCgr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 21:36:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964806AbVLBCgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 21:36:47 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:34860
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S964804AbVLBCgr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 21:36:47 -0500
Date: Fri, 2 Dec 2005 03:36:45 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Wu Fengguang <wfg@mail.ustc.edu.cn>, Andrew Morton <akpm@osdl.org>,
       marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org,
       christoph@lameter.com, riel@redhat.com, a.p.zijlstra@chello.nl,
       npiggin@suse.de, magnus.damm@gmail.com
Subject: Re: [PATCH 02/12] mm: supporting variables and functions for balanced zone aging
Message-ID: <20051202023645.GD28539@opteron.random>
References: <20051201101810.837245000@localhost.localdomain> <20051201101933.936973000@localhost.localdomain> <20051201023714.612f0bbf.akpm@osdl.org> <20051201222846.GA3646@dmt.cnet> <20051201150349.3538638e.akpm@osdl.org> <20051202011924.GA3516@mail.ustc.edu.cn> <20051201173015.675f4d80.akpm@osdl.org> <20051202020407.GA4445@mail.ustc.edu.cn> <438FB0FA.3050806@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <438FB0FA.3050806@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2005 at 01:27:06PM +1100, Nick Piggin wrote:
> min_free_kbytes? This number really isn't anything to do with balancing
> and more to do with the amount of reserve kept for things like GFP_ATOMIC
> and recursive allocations. Let's not lower it ;)

Agreed. Or at the very least that should be discussed in a separate
thread, it has no relation with shrink_cache changes or anything else
related to zone aging IMHO.
