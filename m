Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264985AbUELFmk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264985AbUELFmk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 01:42:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264979AbUELFmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 01:42:40 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:14245 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S264985AbUELFlz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 01:41:55 -0400
Date: Wed, 12 May 2004 07:41:54 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Numdimmies MUST DIE!
Message-ID: <20040512054154.GA26138@MAIL.13thfloor.at>
Mail-Followup-To: Rusty Russell <rusty@rustcorp.com.au>,
	lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
References: <1083551201.25582.149.camel@bach>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1083551201.25582.149.camel@bach>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 03, 2004 at 12:26:42PM +1000, Rusty Russell wrote:
> Status: Vitally Important
> 
> I'm sure this is violating the trademark of a pre-schooler's TV show
> somewhere in the world.
> 
> diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .18765-linux-2.6.6-rc3-bk4/drivers/net/dummy.c .18765-linux-2.6.6-rc3-bk4.updated/drivers/net/dummy.c
> --- .18765-linux-2.6.6-rc3-bk4/drivers/net/dummy.c	2004-04-29 17:29:43.000000000 +1000
> +++ .18765-linux-2.6.6-rc3-bk4.updated/drivers/net/dummy.c	2004-05-03 12:25:11.000000000 +1000
> @@ -104,7 +104,7 @@ static struct net_device **dummies;
>  
>  /* Number of dummy devices to be set up by this module. */
>  module_param(numdummies, int, 0);
> -MODULE_PARM_DESC(numdimmies, "Number of dummy psuedo devices");
> +MODULE_PARM_DESC(numdummies, "Number of dummy psuedo devices");

hmm, maybe they could evolve, and become pseudo
devices in this process too? (instead of psuedo)

best,
Herbert

>  static int __init dummy_init_one(int index)
>  {
> 
> -- 
> Anyone who quotes me in their signature is an idiot -- Rusty Russell
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
