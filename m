Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261610AbREQToK>; Thu, 17 May 2001 15:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261857AbREQToA>; Thu, 17 May 2001 15:44:00 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:63492 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S261610AbREQTnu>; Thu, 17 May 2001 15:43:50 -0400
Subject: Re: [PATCH] 2.4.5pre3 warning fixes
To: richbaum@acm.org (Rich Baum)
Date: Thu, 17 May 2001 20:40:11 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com,
        alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <7C4D2505D3F@coral.indstate.edu> from "Rich Baum" at May 17, 2001 02:33:40 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E150Td5-00060Z-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> --- linux/drivers/i2o/i2o_core.c	Thu May 17 11:38:28 2001
> +++ rb/drivers/i2o/i2o_core.c	Thu May 17 11:48:08 2001
> @@ -380,8 +380,9 @@
>  	d->owner=NULL;
>  	d->next=c->devices;
>  	d->prev=NULL;
> -	if (c->devices != NULL)
> +	if (c->devices != NULL){
>  		c->devices->prev=d;
> +	}

What does this have to do with gcc compiler warnings ?????

