Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263225AbUD2EAw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263225AbUD2EAw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 00:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263188AbUD2D6y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 23:58:54 -0400
Received: from smtp5.wanadoo.fr ([193.252.22.26]:65403 "EHLO
	mwinf0501.wanadoo.fr") by vger.kernel.org with ESMTP
	id S263184AbUD2D6k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 23:58:40 -0400
Date: Thu, 29 Apr 2004 06:04:29 +0000
From: Philippe Elie <phil.el@wanadoo.fr>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390 (6/6): oprofile for s390.
Message-ID: <20040429060429.GE395@zaniah>
References: <20040428165119.GG2777@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040428165119.GG2777@mschwid3.boeblingen.de.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Apr 2004 at 18:51 +0000, Martin Schwidefsky wrote:

> [PATCH] s390: oprofile.
> 
> From: Martin Schwidefsky <schwidefsky@de.ibm.com>
> 
> Add oprofile support for s/390.

we ack'ed this on oprofile mail list except:

> --- linux-2.6/arch/s390/kernel/time.c	Wed Apr 28 17:51:14 2004


> +#if defined(CONFIG_OPROFILE) || defined(CONFIG_OPROFILE_MODULE)

this must depend on CONFIG_PROFILING ?

> + */
> +static inline void s390_do_profile(struct pt_regs * regs)
> +{

regards,
Phil
