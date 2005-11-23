Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750969AbVKWPPk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750969AbVKWPPk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 10:15:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750981AbVKWPPk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 10:15:40 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:36544 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750967AbVKWPPj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 10:15:39 -0500
Subject: Re: [PATCH 3/5] i386 perfmon2 code for review
From: Dave Hansen <haveblue@us.ibm.com>
To: eranian@hpl.hp.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20051123145543.GD17228@frankl.hpl.hp.com>
References: <20051118170055.GF30262@frankl.hpl.hp.com>
	 <20051123145308.GB17228@frankl.hpl.hp.com>
	 <20051123145543.GD17228@frankl.hpl.hp.com>
Content-Type: text/plain
Date: Wed, 23 Nov 2005 16:15:29 +0100
Message-Id: <1132758929.5757.26.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-23 at 06:55 -0800, Stephane Eranian wrote:
> 
> diff -urN linux-2.6.15-rc1-git6.orig/arch/i386/kernel/i8259.c
> linux-2.6.15-rc1-git6/arch/i386/kernel/i8259.c
> --- linux-2.6.15-rc1-git6.orig/arch/i386/kernel/i8259.c 2005-11-18
> 05:16:42.000000000 -0800
> +++ linux-2.6.15-rc1-git6/arch/i386/kernel/i8259.c      2005-11-18
> 05:47:51.000000000 -0800
> @@ -11,6 +11,7 @@
>  #include <linux/kernel_stat.h>
>  #include <linux/sysdev.h>
>  #include <linux/bitops.h>
> +#include <linux/perfmon.h>
>  
>  #include <asm/8253pit.h>
>  #include <asm/atomic.h>
> @@ -403,6 +404,7 @@
>         /* all the set up before the call gates are initialised */
>         pre_intr_init_hook();
>  
> +
>         /*
>          * Cover the whole vector space, no vector can escape

Please don't make random whitespace changes.

-- Dave

