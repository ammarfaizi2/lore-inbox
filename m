Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261867AbVAYIKK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261867AbVAYIKK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 03:10:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261868AbVAYIKJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 03:10:09 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:11435 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261867AbVAYIJu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 03:09:50 -0500
Date: Tue, 25 Jan 2005 09:06:36 +0100
From: Jens Axboe <axboe@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       jeffpc@optonline.net
Subject: Re: [2.6 patch] *-iosched.c: Use proper documentation path
Message-ID: <20050125080636.GB2751@suse.de>
References: <20050125074906.GE3515@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050125074906.GE3515@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25 2005, Adrian Bunk wrote:
> This patch by Josef "Jeff" Sipek <jeffpc@optonline.net> fixes two 
> documentationn paths.
> 
> Signed-off-by: Josef "Jeff" Sipek <jeffpc@optonline.net>
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Looks fine, thanks.

> 
> diff -Nru a/drivers/block/as-iosched.c b/drivers/block/as-iosched.c
> --- a/drivers/block/as-iosched.c	2004-12-02 19:45:45 -05:00
> +++ b/drivers/block/as-iosched.c	2004-12-02 19:45:45 -05:00
> @@ -25,7 +25,7 @@
>  #define REQ_ASYNC	0
>  
>  /*
> - * See Documentation/as-iosched.txt
> + * See Documentation/block/as-iosched.txt
>   */
>  
>  /*
> diff -Nru a/drivers/block/deadline-iosched.c b/drivers/block/deadline-iosched.c
> --- a/drivers/block/deadline-iosched.c	2004-12-02 19:45:45 -05:00
> +++ b/drivers/block/deadline-iosched.c	2004-12-02 19:45:45 -05:00
> @@ -19,7 +19,7 @@
>  #include <linux/rbtree.h>
>  
>  /*
> - * See Documentation/deadline-iosched.txt
> + * See Documentation/block/deadline-iosched.txt
>   */
>  static int read_expire = HZ / 2;  /* max time before a read is submitted. */
>  static int write_expire = 5 * HZ; /* ditto for writes, these limits are SOFT! */
> 
> 
> 
> 
> 
> 

-- 
Jens Axboe

