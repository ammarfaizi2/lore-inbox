Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261481AbVG1ODL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261481AbVG1ODL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 10:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261472AbVG1ODC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 10:03:02 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:42244 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261255AbVG1OCb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 10:02:31 -0400
Date: Thu, 28 Jul 2005 16:02:30 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] New include file for marking old style api files
Message-ID: <20050728140230.GG3528@stusta.de>
References: <42E8E0C2.5010302@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42E8E0C2.5010302@gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2005 at 03:42:26PM +0200, Jiri Slaby wrote:
> Hi.
> Do you think, that this would be useful in the kernel tree?
> I have an idea to mark old drivers, which should I or somebody rewrite.
> For example drivers/isdn/hisax/gazel.c.
>...
> --- /dev/null
> +++ b/include/linux/oldapi.h
> @@ -0,0 +1,2 @@
> +#warning This driver uses old style API and needs to be rewritten or removed \
> +	from kernel

What's wrong with __deprecated ?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

