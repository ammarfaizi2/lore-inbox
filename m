Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030475AbVKPUBQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030475AbVKPUBQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 15:01:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030472AbVKPUBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 15:01:16 -0500
Received: from smtp2.brturbo.com.br ([200.199.201.158]:61576 "EHLO
	smtp2.brturbo.com.br") by vger.kernel.org with ESMTP
	id S1030475AbVKPUBP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 15:01:15 -0500
Subject: Re: [PATCH] - Fixes sparse warning in bttv-driver.
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
To: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, kraxel@bytesex.org,
       Linux and Kernel Video <video4linux-list@redhat.com>
In-Reply-To: <20051114095440.5fb13e00.lcapitulino@mandriva.com.br>
References: <20051114095440.5fb13e00.lcapitulino@mandriva.com.br>
Content-Type: text/plain; charset=ISO-8859-1
Date: Wed, 16 Nov 2005 17:47:30 -0200
Message-Id: <1132170450.9041.110.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1-3mdk 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luiz Fernando,

	Please send V4L fixes to me instead of Kraxel or to V4L mailing list
(video4linux-list@redhat.com). I'm the current V4L maintainer.

Cheers,
Mauro.

Em Seg, 2005-11-14 às 09:54 -0200, Luiz Fernando Capitulino escreveu:
> Hi,
> 
> The patch below fixes the following sparse warning:
> 
> drivers/media/video/bttv-driver.c
> 
> Signed-off-by: Luiz Capitulino <lcapitulino@mandriva.com.br>
Acked-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
> 
>  drivers/media/video/bttv-driver.c |    2 +-
>  drivers/media/video/bttv-i2c.c    |    0 
	?
>  2 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/video/bttv-driver.c b/drivers/media/video/bttv-driver.c
> --- a/drivers/media/video/bttv-driver.c
> +++ b/drivers/media/video/bttv-driver.c
> @@ -1853,7 +1853,7 @@ static int bttv_common_ioctls(struct btt
>  	}
>  	case VIDIOC_LOG_STATUS:
>  	{
> -		bttv_call_i2c_clients(btv, VIDIOC_LOG_STATUS, 0);
> +		bttv_call_i2c_clients(btv, VIDIOC_LOG_STATUS, NULL);
>  		return 0;
>  	}
>  
> diff --git a/drivers/media/video/bttv-i2c.c b/drivers/media/video/bttv-i2c.c
	?

