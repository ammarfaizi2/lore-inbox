Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262675AbVCCWPd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262675AbVCCWPd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 17:15:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262665AbVCCWOW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 17:14:22 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:65173 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261280AbVCCWGb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 17:06:31 -0500
Date: Thu, 3 Mar 2005 23:06:12 +0100
From: Pavel Machek <pavel@suse.cz>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] kernel/power/smp.c: make a variable static
Message-ID: <20050303220612.GC16385@elf.ucw.cz>
References: <20050303214826.GP4608@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050303214826.GP4608@stusta.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!


> This patch makes a needlessly global variable static.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

ACK
							Pavel,
wondering if we have single Adrian or 1000 small gnomes going through
code night and day.


> --- linux-2.6.11-rc5-mm1-full/kernel/power/smp.c.old	2005-03-03 17:00:30.000000000 +0100
> +++ linux-2.6.11-rc5-mm1-full/kernel/power/smp.c	2005-03-03 17:00:38.000000000 +0100
> @@ -42,7 +42,7 @@
>  	__restore_processor_state(&ctxt);
>  }
>  
> -cpumask_t oldmask;
> +static cpumask_t oldmask;
>  
>  void disable_nonboot_cpus(void)
>  {
> 

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
