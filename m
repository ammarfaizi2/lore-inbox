Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266457AbUBLOvA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 09:51:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266472AbUBLOu7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 09:50:59 -0500
Received: from dp.samba.org ([66.70.73.150]:58265 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S266457AbUBLOuz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 09:50:55 -0500
Date: Fri, 13 Feb 2004 01:46:53 +1100
From: Anton Blanchard <anton@samba.org>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.6.3-rc2-mm1
Message-ID: <20040212144653.GH25922@krispykreme>
References: <20040212015710.3b0dee67.akpm@osdl.org> <20040212031322.742b29e7.akpm@osdl.org> <20040212115718.GF25922@krispykreme> <20040212040910.3de346d4.akpm@osdl.org> <Pine.LNX.4.58.0402120937460.32441@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402120937460.32441@montezuma.fsmlabs.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> I've not managed to trigger this one
> 
> CONFIG_DEBUG_KERNEL=y
> CONFIG_DEBUG_STACKOVERFLOW=y
> # CONFIG_DEBUG_SLAB is not set
> CONFIG_DEBUG_IOVIRT=y
> CONFIG_DEBUG_SPINLOCK=y
> CONFIG_DEBUG_PAGEALLOC=y
> CONFIG_DEBUG_HIGHMEM=y
> CONFIG_DEBUG_INFO=y
> CONFIG_DEBUG_SPINLOCK_SLEEP=y

Im guessing Andrews bug is my fault:

http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.3-rc2/2.6.3-rc2-mm1/broken-out/ppc64-spinlock-sleep-debugging.patch

If you have preempt on you wont see it.

Anton
