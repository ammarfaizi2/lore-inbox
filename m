Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267687AbSLGAlZ>; Fri, 6 Dec 2002 19:41:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267688AbSLGAlZ>; Fri, 6 Dec 2002 19:41:25 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:19212 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267687AbSLGAlZ>; Fri, 6 Dec 2002 19:41:25 -0500
Date: Sat, 7 Dec 2002 00:49:00 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Antonino Daplas <adaplas@pol.net>
cc: Tobias Rittweiler <inkognito.anonym@uni.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: Re: [STATUS] fbdev api.
In-Reply-To: <1039218931.989.24.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0212070048400.10225-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> diff -Naur linux-2.5.50-js/drivers/video/console/fbcon.c linux/drivers/video/console/fbcon.c
> --- linux-2.5.50-js/drivers/video/console/fbcon.c	2002-12-06 23:33:56.000000000 +0000
> +++ linux/drivers/video/console/fbcon.c	2002-12-06 23:33:18.000000000 +0000
> @@ -1986,6 +1986,8 @@
>  						 vc->vc_cols);
>  			vc->vc_video_erase_char = oldc;
>  		}
> +		else
> +			update_screen(vc->vc_num);
>  		return 0;
>  	} else {
>  		/* Tell console.c that it has to restore the screen itself */

Applied :-)



