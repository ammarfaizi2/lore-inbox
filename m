Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262768AbUCWSFa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 13:05:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262764AbUCWSF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 13:05:29 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:8203 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262768AbUCWSFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 13:05:17 -0500
Date: Tue, 23 Mar 2004 18:05:15 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Christian Vogel <vogel@skunk.physik.uni-erlangen.de>
cc: linux-kernel@vger.kernel.org, <torvalds@osdl.org>
Subject: Re: [PATCH] tgafb: missing include (Linux 2.6.4)
In-Reply-To: <20040323142308.A22635@skunk.physik.uni-erlangen.de>
Message-ID: <Pine.LNX.4.44.0403231801200.2419-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We have tga patches coming. I haven't heard from Jay tho. I will ping him 
again. The below patch is a temporary fix only.



On Tue, 23 Mar 2004, Christian Vogel wrote:

> Hi, in 2.6.4 drivers/video/tgafb.c is missing a include, complaining about
> color_table[] and others not being defined.
> 
> --- drivers/video/tgafb.c       2004/03/22 16:09:55     1.1
> +++ drivers/video/tgafb.c       2004/03/22 16:15:38
> @@ -25,6 +25,7 @@
>  #include <linux/pci.h>
>  #include <asm/io.h>
>  #include <video/tgafb.h>
> +#include <linux/selection.h>
>  
>  /*
>   * Local functions.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

