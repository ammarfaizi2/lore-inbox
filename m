Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759147AbWLAGVV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759147AbWLAGVV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 01:21:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759141AbWLAGVU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 01:21:20 -0500
Received: from rex.snapgear.com ([203.143.235.140]:42416 "EHLO
	cyberguard.com.au") by vger.kernel.org with ESMTP id S1759115AbWLAGVT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 01:21:19 -0500
Message-ID: <456FC9DC.3080400@snapgear.com>
Date: Fri, 01 Dec 2006 16:21:16 +1000
From: Greg Ungerer <gerg@snapgear.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Cc: uclinux-dev@uclinux.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] m68knommu: scatterlist add missing bracket
References: <200611301013.17991.m.kozlowski@tuxland.pl>
In-Reply-To: <200611301013.17991.m.kozlowski@tuxland.pl>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mariusz,

Mariusz Kozlowski wrote:
> 	This patch adds missing bracket.
> 
> Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

Thanks. I'll make sure that gets pushed up.

Regards
Greg



>  include/asm-m68knommu/scatterlist.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-2.6.19-rc6-mm2-a/include/asm-m68knommu/scatterlist.h	2006-11-16 05:03:40.000000000 +0100
> +++ linux-2.6.19-rc6-mm2-b/include/asm-m68knommu/scatterlist.h	2006-11-30 00:57:24.000000000 +0100
> @@ -10,7 +10,7 @@ struct scatterlist {
>  	unsigned int	length;
>  };
>  
> -#define sg_address(sg) (page_address((sg)->page) + (sg)->offset
> +#define sg_address(sg) (page_address((sg)->page) + (sg)->offset)
>  #define sg_dma_address(sg)      ((sg)->dma_address)
>  #define sg_dma_len(sg)          ((sg)->length)
>  
> 
> 

-- 
------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Dude       EMAIL:     gerg@snapgear.com
SnapGear -- a Secure Computing Company      PHONE:       +61 7 3435 2888
825 Stanley St,                             FAX:         +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia         WEB: http://www.SnapGear.com
