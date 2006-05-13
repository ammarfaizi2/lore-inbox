Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964771AbWEMSv5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964771AbWEMSv5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 14:51:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932496AbWEMSv4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 14:51:56 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:519 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932494AbWEMSv4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 14:51:56 -0400
Date: Sat, 13 May 2006 20:51:57 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Brice Goglin <brice@myri.com>
Cc: netdev@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>,
       "Andrew J. Gallatin" <gallatin@myri.com>
Subject: Re: [PATCH 6/6] myri10ge - Kconfig and Makefile
Message-ID: <20060513185157.GC6931@stusta.de>
References: <446259A0.8050504@myri.com> <44625E9B.3090509@myri.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44625E9B.3090509@myri.com>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2006 at 11:43:55PM +0200, Brice Goglin wrote:
>...
> --- linux-mm/drivers/net/Makefile.old	2006-04-08 04:49:53.000000000 -0700
> +++ linux-mm/drivers/net/Makefile	2006-04-21 08:10:27.000000000 -0700
> @@ -192,6 +192,7 @@ obj-$(CONFIG_R8169) += r8169.o
>  obj-$(CONFIG_AMD8111_ETH) += amd8111e.o
>  obj-$(CONFIG_IBMVETH) += ibmveth.o
>  obj-$(CONFIG_S2IO) += s2io.o
> +obj-$(CONFIG_MYRI10GE) += myri10ge/
>  obj-$(CONFIG_SMC91X) += smc91x.o
>  obj-$(CONFIG_SMC911X) += smc911x.o
>  obj-$(CONFIG_DM9000) += dm9000.o
> --- /dev/null	2006-04-21 00:45:09.064430000 -0700
> +++ linux-mm/drivers/net/myri10ge/Makefile	2006-04-21 08:14:21.000000000 -0700
> @@ -0,0 +1,5 @@
> +#
> +# Makefile for the Myricom Myri-10G ethernet driver
> +#
> +
> +obj-$(CONFIG_MYRI10GE) += myri10ge.o

If the driver consists of one source file, why does it need an own 
subdir?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

