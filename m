Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263973AbTDJBJ0 (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 21:09:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263975AbTDJBJ0 (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 21:09:26 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:15056 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S263973AbTDJBJ0 (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 21:09:26 -0400
Date: Wed, 9 Apr 2003 21:21:05 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200304100121.h3A1L5E29440@devserv.devel.redhat.com>
To: davidm@hpl.hp.com
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] add module_arch_cleanup() and improve module debugging output
In-Reply-To: <mailman.1049925502.12924.linux-kernel2news@redhat.com>
References: <mailman.1049925502.12924.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> --- a/arch/sparc/kernel/module.c	Wed Apr  9 14:49:48 2003
> +++ b/arch/sparc/kernel/module.c	Wed Apr  9 14:49:48 2003
> @@ -145,3 +145,7 @@
>  {
>  	return 0;
>  }
> +
> +void module_arch_cleanup(struct module *mod)
> +{
> +}

Why not to do #define module_arch_cleanup(mod)  /* */  ?

-- Pete
