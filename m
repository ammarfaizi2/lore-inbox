Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272401AbTHSRgM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 13:36:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272375AbTHSRfo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 13:35:44 -0400
Received: from mail.kroah.org ([65.200.24.183]:36301 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S272603AbTHSR1R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 13:27:17 -0400
Date: Tue, 19 Aug 2003 10:23:55 -0700
From: Greg KH <greg@kroah.com>
To: CaT <cat@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/10] 2.6.0-t3: struct C99 initialiser conversion
Message-ID: <20030819172355.GA4864@kroah.com>
References: <20030819063727.GL643@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030819063727.GL643@zip.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 19, 2003 at 04:37:27PM +1000, CaT wrote:
> diff -aur linux.backup/drivers/usb/host/hc_sl811_rh.c linux/drivers/usb/host/hc_sl811_rh.c
> --- linux.backup/drivers/usb/host/hc_sl811_rh.c	Sat Aug 16 15:02:54 2003
> +++ linux/drivers/usb/host/hc_sl811_rh.c	Sat Aug 16 23:57:09 2003
> @@ -329,7 +329,7 @@
>  	switch (bmRType_bReq) {
>  		/* Request Destination:
>  		   without flags: Device, 
> -		   RH_INTERFACE: interface, 
> +		   RH_INTERFACE: interface,
>  		   RH_ENDPOINT: endpoint,
>  		   RH_CLASS means HUB here, 
>  		   RH_OTHER | RH_CLASS  almost ever means HUB_PORT here 

I think you need to work on your scripts if you thought this was a C99
"fix".  More like a "delete trailing space" patch...

thanks,

greg k-h
