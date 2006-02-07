Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964869AbWBGV12@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964869AbWBGV12 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 16:27:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964870AbWBGV12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 16:27:28 -0500
Received: from streetfiresound.liquidweb.com ([64.91.233.29]:51399 "EHLO
	host.streetfiresound.liquidweb.com") by vger.kernel.org with ESMTP
	id S964869AbWBGV11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 16:27:27 -0500
Subject: Re: [PATCH] spi: Add PXA2xx SSP SPI Driver
From: Stephen Street <stephen@streetfiresound.com>
Reply-To: stephen@streetfiresound.com
To: David Vrabel <dvrabel@arcom.com>
Cc: linux-kernel@vger.kernel.org, David Brownell <david-b@pacbell.net>
In-Reply-To: <43E8B738.8080602@arcom.com>
References: <43e80ec3.oEr+gtyMVtunRTyE%stephen@streetfiresound.com>
	 <43E88970.2020107@arcom.com>  <43E8B738.8080602@arcom.com>
Content-Type: text/plain
Organization: StreetFire Sound Labs
Date: Tue, 07 Feb 2006 13:27:20 -0800
Message-Id: <1139347640.4549.440.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-22) 
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - host.streetfiresound.liquidweb.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - streetfiresound.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-02-07 at 15:05 +0000, David Vrabel wrote:
> @@ -429,9 +433,6 @@
>  	if (!IS_DMA_ALIGNED(drv_data->rx) || !IS_DMA_ALIGNED(drv_data->tx))
>  		return 0;
>  
> -	if (drv_data->len < drv_data->cur_chip->dma_burst_size)
> -		return 0;
> -
Will do.  This was a last minute crappy idea.

-Stephen

