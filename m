Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751137AbWHIQeN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137AbWHIQeN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 12:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751017AbWHIQeN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 12:34:13 -0400
Received: from lixom.net ([66.141.50.11]:48261 "EHLO mail.lixom.net")
	by vger.kernel.org with ESMTP id S1750740AbWHIQeL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 12:34:11 -0400
Date: Wed, 9 Aug 2006 11:33:13 -0500
To: Jan-Bernd Themann <ossthema@de.ibm.com>
Cc: netdev <netdev@vger.kernel.org>, Thomas Klein <tklein@de.ibm.com>,
       linux-ppc <linuxppc-dev@ozlabs.org>,
       Christoph Raisch <raisch@de.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Marcus Eder <meder@de.ibm.com>
Subject: Re: [PATCH 6/6] ehea: Kernel build (Kconfig / Makefile)
Message-ID: <20060809163313.GC29823@pb15.lixom.net>
References: <44D99F92.60407@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44D99F92.60407@de.ibm.com>
User-Agent: Mutt/1.5.11
From: Olof Johansson <olof@lixom.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2006 at 10:40:50AM +0200, Jan-Bernd Themann wrote:
> Signed-off-by: Jan-Bernd Themann <themann@de.ibm.com>
> 
> 
>   drivers/net/Kconfig  |    6 ++++++
>   drivers/net/Makefile |    1 +
>   2 files changed, 7 insertions(+)
> 
> 
> 
> diff -Nurp -X dontdiff linux-2.6.18-rc4/drivers/net/Kconfig patched_kernel/drivers/net/Kconfig
> --- linux-2.6.18-rc4/drivers/net/Kconfig	2006-08-06 11:20:11.000000000 -0700
> +++ patched_kernel/drivers/net/Kconfig	2006-08-08 03:00:49.526421944 -0700
> @@ -2277,6 +2277,12 @@ config CHELSIO_T1
>             To compile this driver as a module, choose M here: the module
>             will be called cxgb.
> 
> +config EHEA
> +        tristate "eHEA Ethernet support"
> +        depends on IBMEBUS
> +        ---help---
> +          This driver supports the IBM pSeries ethernet adapter

Does this adapter really not have a better name for the option
description? That's a very vague description given that IBM pSeries
machines have had all sorts of ethernet adapters through the years.



-Olof
