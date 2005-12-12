Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750966AbVLLAwy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750966AbVLLAwy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 19:52:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750969AbVLLAwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 19:52:54 -0500
Received: from waste.org ([64.81.244.121]:60357 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1750960AbVLLAwy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 19:52:54 -0500
Date: Sun, 11 Dec 2005 16:46:47 -0800
From: Matt Mackall <mpm@selenic.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch -mm] DEBUG_SLAB depends on SLAB
Message-ID: <20051212004647.GZ8637@waste.org>
References: <20051211141716.GA8500@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051211141716.GA8500@elte.hu>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 11, 2005 at 03:17:16PM +0100, Ingo Molnar wrote:
> another SLOB related patch: make DEBUG_SLAB depend on SLAB.
> 
> Signed-off-by: Ingo Molnar <mingo@elte.hu>

Acked-by: Matt Mackall <mpm@selenic.com>

> 
> Index: linux/lib/Kconfig.debug
> ===================================================================
> --- linux.orig/lib/Kconfig.debug
> +++ linux/lib/Kconfig.debug
> @@ -100,7 +100,7 @@ config SCHEDSTATS
>  
>  config DEBUG_SLAB
>  	bool "Debug memory allocations"
> -	depends on DEBUG_KERNEL
> +	depends on DEBUG_KERNEL && SLAB
>  	help
>  	  Say Y here to have the kernel do limited verification on memory
>  	  allocation as well as poisoning memory on free to catch use of freed

-- 
Mathematics is the supreme nostalgia of our time.
