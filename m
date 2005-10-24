Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750918AbVJXLrP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750918AbVJXLrP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 07:47:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750921AbVJXLrP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 07:47:15 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:14758 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750916AbVJXLrO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 07:47:14 -0400
Date: Mon, 24 Oct 2005 12:45:18 +0200
From: Pavel Machek <pavel@ucw.cz>
To: dsaxena@plexity.net
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.net, akpm@osdl.org,
       tony@atomide.com
Subject: Re: [patch 2/5] Core HW RNG support
Message-ID: <20051024104518.GA18631@elf.ucw.cz>
References: <20051019081906.615365000@omelas> <20051019091715.801905000@omelas>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051019091715.801905000@omelas>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This patch adds support for the HW RNG core. The core code
> simply implements the user space interface and calls HW-specific
> function pointers to do the real data gathering. We do this
> instead of having each driver re-implement the user space functionality
> so we do not end up with a bunch of drivers replicating the exact 
> same 50 lines of code (see drivers/watchdog). 
> 
> Signed-off-by: Deepak Saxena <dsaxena@plexity.net>
> 

> Index: linux-2.6-rng/drivers/char/rng/Makefile
> ===================================================================
> --- /dev/null
> +++ linux-2.6-rng/drivers/char/rng/Makefile

Could we have it named drivers/char/random, or perhaps just
drivers/random?

							Pavel

-- 
Thanks, Sharp!
