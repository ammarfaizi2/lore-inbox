Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261162AbVCTTRc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbVCTTRc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 14:17:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261172AbVCTTRc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 14:17:32 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:14777 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S261162AbVCTTR3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 14:17:29 -0500
Date: Sun, 20 Mar 2005 20:17:28 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: linux-fbdev-devel@lists.sourceforge.net,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][trivial] matroxfb_maven remove pointless semicolons after label
Message-ID: <20050320191728.GF32717@vana.vc.cvut.cz>
References: <Pine.LNX.4.62.0503201737250.2501@dragon.hyggekrogen.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0503201737250.2501@dragon.hyggekrogen.localhost>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 20, 2005 at 05:41:01PM +0100, Jesper Juhl wrote:
> 
> Having a semicolon at the end as in  labelname:;  is pointless, remove.

As long as I'm maintainer of this code, I prefer to leave them here.
							Petr Vandrovec

> 
> Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
> 
> diff -up linux-2.6.11-mm4-orig/drivers/video/matrox/matroxfb_maven.c linux-2.6.11-mm4/drivers/video/matrox/matroxfb_maven.c
> --- linux-2.6.11-mm4-orig/drivers/video/matrox/matroxfb_maven.c	2005-03-02 08:37:30.000000000 +0100
> +++ linux-2.6.11-mm4/drivers/video/matrox/matroxfb_maven.c	2005-03-20 17:35:48.000000000 +0100
> @@ -1263,11 +1263,11 @@ static int maven_detect_client(struct i2
>  	if (err)
>  		goto ERROR4;
>  	return 0;
> -ERROR4:;
> +ERROR4:
>  	i2c_detach_client(new_client);
> -ERROR3:;
> +ERROR3:
>  	kfree(new_client);
> -ERROR0:;
> +ERROR0:
>  	return err;
>  }
>  
> 
> 
> 
