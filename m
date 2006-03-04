Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751373AbWCDVp4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373AbWCDVp4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 16:45:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752015AbWCDVp4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 16:45:56 -0500
Received: from smtp.osdl.org ([65.172.181.4]:4552 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751373AbWCDVp4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 16:45:56 -0500
Date: Sat, 4 Mar 2006 13:44:25 -0800
From: Andrew Morton <akpm@osdl.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] synclink: s/aviod/avoid/
Message-Id: <20060304134425.1bfb36bb.akpm@osdl.org>
In-Reply-To: <20060304211847.GA8332@mipter.zuzino.mipt.ru>
References: <20060304211847.GA8332@mipter.zuzino.mipt.ru>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
> 
>  drivers/char/synclink.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/drivers/char/synclink.c
> +++ b/drivers/char/synclink.c
> @@ -6025,7 +6025,7 @@ static void usc_set_async_mode( struct m
>  	 * <15..8>	?		RxFIFO IRQ Request Level
>  	 *
>  	 * Note: For async mode the receive FIFO level must be set
> -	 * to 0 to aviod the situation where the FIFO contains fewer bytes
> +	 * to 0 to avoid the situation where the FIFO contains fewer bytes
>  	 * than the trigger level and no more data is expected.
>  	 *
>  	 * <7>		0		Exited Hunt IA (Interrupt Arm)

One-liner spello fixes fall below my "is this worth a changeset" threshold,
sorry.

