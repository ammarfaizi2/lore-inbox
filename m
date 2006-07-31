Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932541AbWGaDeq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932541AbWGaDeq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 23:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932579AbWGaDeq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 23:34:46 -0400
Received: from xenotime.net ([66.160.160.81]:39382 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932541AbWGaDep (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 23:34:45 -0400
Date: Sun, 30 Jul 2006 20:37:28 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Matt LaPlante <kernel1@cyberdogtech.com>
Cc: linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: Re: [PATCH 18-rc3] Fix typos in /Documentation : 'Q'-'R'
Message-Id: <20060730203728.f3fbdd95.rdunlap@xenotime.net>
In-Reply-To: <20060730181224.c1b69798.kernel1@cyberdogtech.com>
References: <20060730181224.c1b69798.kernel1@cyberdogtech.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Jul 2006 18:12:24 -0400 Matt LaPlante wrote:

> This patch fixes typos in various Documentation txts. The patch addresses some words starting with the letters 'Q'-'R'.  

> diff -ru a/Documentation/block/biodoc.txt b/Documentation/block/biodoc.txt
> --- a/Documentation/block/biodoc.txt	2006-06-17 21:49:35.000000000 -0400
> +++ b/Documentation/block/biodoc.txt	2006-07-30 18:11:04.000000000 -0400
> @@ -783,7 +783,7 @@
>  
>  	blk_queue_invalidate_tags(request_queue_t *q)
>  
> -	Clear the internal block tag queue and readd all the pending requests
> +	Clear the internal block tag queue and read all the pending requests

I think that is probably re-add.

>  	to the request queue. The driver will receive them again on the
>  	next request_fn run, just like it did the first time it encountered
>  	them.

> diff -ru a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
> --- a/Documentation/powerpc/booting-without-of.txt	2006-07-30 15:57:21.000000000 -0400
> +++ b/Documentation/powerpc/booting-without-of.txt	2006-07-30 18:11:05.000000000 -0400
> @@ -1069,7 +1069,7 @@
>      around. It contains no internal offsets or pointers for this
>      purpose.
>  
> -  - An example of code for iterating nodes & retreiving properties
> +  - An example of code for iterating nodes & retrieving properties
>      directly from the flattened tree format can be found in the kernel
>      file arch/ppc64/kernel/prom.c, look at scan_flat_dt() function,
>      it's usage in early_init_devtree(), and the corresponding various
       its

Thanks more.
---
~Randy
