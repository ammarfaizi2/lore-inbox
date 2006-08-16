Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932192AbWHPT1X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192AbWHPT1X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 15:27:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932191AbWHPT1X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 15:27:23 -0400
Received: from ozlabs.tip.net.au ([203.10.76.45]:49896 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932188AbWHPT1W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 15:27:22 -0400
To: Jan-Bernd Themann <ossthema@de.ibm.com>
cc: netdev <netdev@vger.kernel.org>, Thomas Klein <tklein@de.ibm.com>,
       Jan-Bernd Themann <themann@de.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Thomas Klein <osstklei@de.ibm.com>, linux-ppc <linuxppc-dev@ozlabs.org>,
       Christoph Raisch <raisch@de.ibm.com>, Marcus Eder <meder@de.ibm.com>
From: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH 7/7] ehea: Makefile & Kconfig 
In-reply-to: <44E0A580.9020507@de.ibm.com> 
References: <44E0A580.9020507@de.ibm.com>
Comments: In-reply-to Jan-Bernd Themann <ossthema@de.ibm.com>
   message dated "Mon, 14 Aug 2006 18:32:00 +0200."
Reply-to: Michael Neuling <mikey@neuling.org>
X-Mailer: MH-E 7.85; nmh 1.1; GNU Emacs 21.4.1
Date: Wed, 16 Aug 2006 14:27:16 -0500
Message-Id: <20060816192721.09C2967A3A@ozlabs.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is still being white space munged so it doesn't apply.  

The context is being shifted over 1 column.  All your other patches add
new files so there is no context and hence they apply.

Mikey

In message <44E0A580.9020507@de.ibm.com> you wrote:
> Signed-off-by: Jan-Bernd Themann <themann@de.ibm.com>
> 
> 
>   drivers/net/Kconfig  |    6 ++++++
>   drivers/net/Makefile |    1 +
>   2 files changed, 7 insertions(+)
> 
> 
> 
> diff -Nurp -X dontdiff linux-2.6.18-rc4/drivers/net/Kconfig patched_kernel/dr
ivers/net/Kconfig
> --- linux-2.6.18-rc4/drivers/net/Kconfig	2006-08-06 11:20:11.000000000 -
0700
> +++ patched_kernel/drivers/net/Kconfig	2006-08-08 03:00:49.526421944 -
0700
> @@ -2277,6 +2277,12 @@ config CHELSIO_T1
>             To compile this driver as a module, choose M here: the module
>             will be called cxgb.
> 
> +config EHEA
> +        tristate "eHEA Ethernet support"
> +        depends on IBMEBUS
> +        ---help---
> +          This driver supports the IBM pSeries ethernet adapter
> +
>   config IXGB
>   	tristate "Intel(R) PRO/10GbE support"
>   	depends on PCI
> diff -Nurp -X dontdiff linux-2.6.18-rc4/drivers/net/Makefile patched_kernel/d
rivers/net/Makefile
> --- linux-2.6.18-rc4/drivers/net/Makefile	2006-08-06 11:20:11.000000000 -
0700
> +++ patched_kernel/drivers/net/Makefile	2006-08-08 03:00:30.061451584 -
0700
> @@ -10,6 +10,7 @@ obj-$(CONFIG_E1000) += e1000/
>   obj-$(CONFIG_IBM_EMAC) += ibm_emac/
>   obj-$(CONFIG_IXGB) += ixgb/
>   obj-$(CONFIG_CHELSIO_T1) += chelsio/
> +obj-$(CONFIG_EHEA) += ehea/
>   obj-$(CONFIG_BONDING) += bonding/
>   obj-$(CONFIG_GIANFAR) += gianfar_driver.o
> 
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 
