Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266298AbTATReX>; Mon, 20 Jan 2003 12:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266308AbTATReX>; Mon, 20 Jan 2003 12:34:23 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:56528 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S266298AbTATReX>;
	Mon, 20 Jan 2003 12:34:23 -0500
Date: Mon, 20 Jan 2003 09:43:26 -0800
To: Adrian Bunk <bunk@fs.tum.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5 patch] remove unused variable from drivers/net/irda/ali-ircc.c
Message-ID: <20030120174326.GB7436@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20030118231906.GT10647@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030118231906.GT10647@fs.tum.de>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 19, 2003 at 12:19:07AM +0100, Adrian Bunk wrote:
> Hi Jean,
> 
> the patch below removes an unused variable that generated a compile time 
> warning. I've tested the compilation with 2.5.59.
> 
> cu
> Adrian

	Yep. I sent this patch to Jeff two weeks ago.
	Keep up the good work ;-)

	Jean

> --- linux-2.5.59-full/drivers/net/irda/ali-ircc.c.old	2003-01-19 00:09:16.000000000 +0100
> +++ linux-2.5.59-full/drivers/net/irda/ali-ircc.c	2003-01-19 00:12:37.000000000 +0100
> @@ -248,7 +248,6 @@
>  	struct ali_ircc_cb *self;
>  	struct pm_dev *pmdev;
>  	int dongle_id;
> -	int ret;
>  	int err;
>  			
>  	IRDA_DEBUG(2, "%s(), ---------------- Start ----------------\n", __FUNCTION__);	
