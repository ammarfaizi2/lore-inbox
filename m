Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933914AbWK3KHe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933914AbWK3KHe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 05:07:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933874AbWK3KHe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 05:07:34 -0500
Received: from xyzzy.farnsworth.org ([65.39.95.219]:17413 "HELO farnsworth.org")
	by vger.kernel.org with SMTP id S933914AbWK3KHd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 05:07:33 -0500
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Thu, 30 Nov 2006 03:07:31 -0700
To: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Cc: dale@farnsworth.org, mlachwani@mvista.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mv643xx add missing brackets
Message-ID: <20061130100731.GA6301@xyzzy.farnsworth.org>
References: <200611301035.37786.m.kozlowski@tuxland.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611301035.37786.m.kozlowski@tuxland.pl>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2006 at 10:35:37AM +0100, Mariusz Kozlowski wrote:
> Hello,
> 
> 	This patch adds missing brackets.
> 
> Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
> 
>  include/linux/mv643xx.h |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> --- linux-2.6.19-rc6-mm2-a/include/linux/mv643xx.h	2006-11-16 05:03:40.000000000 +0100
> +++ linux-2.6.19-rc6-mm2-b/include/linux/mv643xx.h	2006-11-30 01:10:53.000000000 +0100
> @@ -724,7 +724,7 @@
>  #define MV643XX_ETH_RX_FIFO_URGENT_THRESHOLD_REG(port)             (0x2470 + (port<<10))
>  #define MV643XX_ETH_TX_FIFO_URGENT_THRESHOLD_REG(port)             (0x2474 + (port<<10))
>  #define MV643XX_ETH_RX_MINIMAL_FRAME_SIZE_REG(port)                (0x247c + (port<<10))
> -#define MV643XX_ETH_RX_DISCARDED_FRAMES_COUNTER(port)              (0x2484 + (port<<10)
> +#define MV643XX_ETH_RX_DISCARDED_FRAMES_COUNTER(port)              (0x2484 + (port<<10))

Good.  Thanks.

>  #define MV643XX_ETH_PORT_DEBUG_0_REG(port)                         (0x248c + (port<<10))
>  #define MV643XX_ETH_PORT_DEBUG_1_REG(port)                         (0x2490 + (port<<10))
>  #define MV643XX_ETH_PORT_INTERNAL_ADDR_ERROR_REG(port)             (0x2494 + (port<<10))
> @@ -1135,7 +1135,7 @@ struct mv64xxx_i2c_pdata {
>  #define MV643XX_ETH_DEFAULT_RX_UDP_QUEUE_1	(1<<19)
>  #define MV643XX_ETH_DEFAULT_RX_UDP_QUEUE_2	(1<<20)
>  #define MV643XX_ETH_DEFAULT_RX_UDP_QUEUE_3	((1<<20) | (1<<19))
> -#define MV643XX_ETH_DEFAULT_RX_UDP_QUEUE_4	((1<<21)
> +#define MV643XX_ETH_DEFAULT_RX_UDP_QUEUE_4	((1<<21))

Mariusz, please remove the extra parenthesis instead of adding
an extra one, like:
	#define MV643XX_ETH_DEFAULT_RX_UDP_QUEUE_4	(1<<21)
and resubmit.

Thanks,
-Dale
