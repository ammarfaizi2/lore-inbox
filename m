Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161371AbWGJHOt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161371AbWGJHOt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 03:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161368AbWGJHOt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 03:14:49 -0400
Received: from terminus.zytor.com ([192.83.249.54]:7113 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1161371AbWGJHOs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 03:14:48 -0400
Message-ID: <44B1FE55.4070507@zytor.com>
Date: Mon, 10 Jul 2006 00:14:29 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
CC: lkml <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Clean up old names in tty code to current names
References: <9e4733910607092111i4c41c610u8b9df5b917cca02c@mail.gmail.com>
In-Reply-To: <9e4733910607092111i4c41c610u8b9df5b917cca02c@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl wrote:
> Fix various places in the tty code to make it match the current naming 
> system.
> 
> ------------------------------------------------------------------------
> 
> diff --git a/drivers/char/pty.c b/drivers/char/pty.c
> index 34dd4c3..af43f37 100644
> --- a/drivers/char/pty.c
> +++ b/drivers/char/pty.c
> @@ -279,7 +279,7 @@ static void __init legacy_pty_init(void)
>  
>  	pty_slave_driver->owner = THIS_MODULE;
>  	pty_slave_driver->driver_name = "pty_slave";
> -	pty_slave_driver->name = "ttyp";
> +	pty_slave_driver->name = "pts";
>  	pty_slave_driver->major = PTY_SLAVE_MAJOR;
>  	pty_slave_driver->minor_start = 0;
>  	pty_slave_driver->type = TTY_DRIVER_TYPE_PTY;

*PLONK*

*LEGACY* pty...

	-hpa
