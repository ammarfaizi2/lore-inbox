Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261624AbTFOA3q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 20:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261568AbTFOA3p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 20:29:45 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:1802 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S261624AbTFOA3n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 20:29:43 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: weber@sixbit.org (John Weber), linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.71
In-Reply-To: <3EEB9FF1.7090104@sixbit.org>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.5.17-20030301 ("Bubbles") (UNIX) (Linux/2.4.20-1-686-smp (i686))
Message-Id: <E19RLc2-0006Ud-00@gondolin.me.apana.org.au>
Date: Sun, 15 Jun 2003 10:43:14 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Weber <weber@sixbit.org> wrote:
> Rather trivial patch, but it looks like it's needed.
> 
> --- flow.old    2003-06-14 18:17:35.000000000 -0400
> +++ flow.c      2003-06-14 18:13:03.000000000 -0400
> @@ -5,6 +5,7 @@
>   */
> 
>  #include <linux/kernel.h>
> +#include <linux/cpu.h>
>  #include <linux/list.h>
>  #include <linux/jhash.h>
>  #include <linux/interrupt.h>

Never mind, I see it now.  Thanks for the fix.
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
