Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261804AbTCGVw2>; Fri, 7 Mar 2003 16:52:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261805AbTCGVw2>; Fri, 7 Mar 2003 16:52:28 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:28079
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261804AbTCGVw0>; Fri, 7 Mar 2003 16:52:26 -0500
Subject: Re: [PATCH][TRIVIAL] Re: Linux 2.5.64-ac3
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Maciej Soltysiak <solt@dns.toxicfilms.tv>
Cc: Alan Cox <alan@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.51.0303072131570.23212@dns.toxicfilms.tv>
References: <200303071756.h27HuiY01551@devserv.devel.redhat.com>
	 <Pine.LNX.4.51.0303072131570.23212@dns.toxicfilms.tv>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1047078526.23696.3.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 07 Mar 2003 23:08:47 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-03-07 at 20:33, Maciej Soltysiak wrote:
> Hi,
> 
> > Linux 2.5.64-ac3
> > o	Bring core IDE code into sync with the latest	(me)
> > 	2.4.21pre5-ac code base. The drivers are not
> > 	quite current with it yet.
> There's a typo that breaks compiling ide-default.c
> 
> Here's the patch:
> 
> --- linux-2.5.60/drivers/ide/ide-default.c~	2003-03-07 20:32:32.000000000 +0100
> +++ linux-2.5.60/drivers/ide/ide-default.c	2003-03-07 21:30:01.000000000 +0100
> @@ -51,7 +51,7 @@
>  	.name		=	"ide-default",
>  	.version	=	IDEDEFAULT_VERSION,
>  	.attach		=	idedefault_attach,
> -	.supports_dma	=	1.
> +	.supports_dma	=	1,
>  	.drives		=	LIST_HEAD_INIT(idedefault_driver.drives)
>  };

Thanks. Last minute conversion to C99 format to avoid flames 8)


