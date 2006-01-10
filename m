Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932311AbWAJS53@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932311AbWAJS53 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 13:57:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932237AbWAJS53
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 13:57:29 -0500
Received: from smtp4.brturbo.com.br ([200.199.201.180]:6362 "EHLO
	smtp4.brturbo.com.br") by vger.kernel.org with ESMTP
	id S932309AbWAJS51 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 13:57:27 -0500
Subject: Re: [2.6 patch] VIDEO_SAA7134_ALSA shouldn't select SND_PCM_OSS
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
To: Adrian Bunk <bunk@stusta.de>
Cc: Ricardo Cerqueira <v4l@cerqueira.org>, video4linux-list@redhat.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060110040605.GA3911@stusta.de>
References: <20060110040605.GA3911@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1
Date: Tue, 10 Jan 2006 16:56:59 -0200
Message-Id: <1136919419.6782.117.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-1mdk 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Ter, 2006-01-10 às 05:06 +0100, Adrian Bunk escreveu:
> There's no reason for an ALSA driver to select an OSS legacy userspace 
> interface.
> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> --- linux-2.6.15-mm2/drivers/media/video/saa7134/Kconfig.old	2006-01-10 02:59:30.000000000 +0100
> +++ linux-2.6.15-mm2/drivers/media/video/saa7134/Kconfig	2006-01-10 03:02:57.000000000 +0100
> @@ -15,7 +15,7 @@
>  config VIDEO_SAA7134_ALSA
>  	tristate "Philips SAA7134 DMA audio support"
>  	depends on VIDEO_SAA7134 && SND
> -	select SND_PCM_OSS
> +	select SND_PCM
>  	---help---
>  	  This is a video4linux driver for direct (DMA) audio in
>  	  Philips SAA713x based TV cards using ALSA
Acked-by: Mauro Carvalho Chehab <mchehab@infradead.org>

	I'll apply at v4l-dvb git tree.
> 
> 
Cheers, 
Mauro.

