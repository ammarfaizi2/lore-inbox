Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271186AbTHMWQg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 18:16:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271214AbTHMWQg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 18:16:36 -0400
Received: from mail.kroah.org ([65.200.24.183]:34019 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S271186AbTHMWQf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 18:16:35 -0400
Date: Wed, 13 Aug 2003 15:16:21 -0700
From: Greg KH <greg@kroah.com>
To: davej@redhat.com
Cc: gregkh@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add Minolta Dimage F300 to unusual_devs
Message-ID: <20030813221621.GC7372@kroah.com>
References: <E19mFqq-00067w-00@tetrachloride>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E19mFqq-00067w-00@tetrachloride>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 11, 2003 at 05:48:56PM +0100, davej@redhat.com wrote:
> diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/usb/storage/unusual_devs.h linux-2.5/drivers/usb/storage/unusual_devs.h
> --- bk-linus/drivers/usb/storage/unusual_devs.h	2003-08-04 01:00:30.000000000 +0100
> +++ linux-2.5/drivers/usb/storage/unusual_devs.h	2003-08-06 18:59:43.000000000 +0100
> @@ -388,6 +388,12 @@ UNUSUAL_DEV(  0x066b, 0x0105, 0x0100, 0x
>  		US_FL_SINGLE_LUN ),
>  #endif
>  
> +/* Submitted by Benny Sjostrand <benny@hostmobility.com> */
> +UNUSUAL_DEV( 0x0686, 0x4011, 0x0001, 0x0001,
> +		"Minolta",
> +		"Dimage F300",
> +		US_SC_SCSI, US_PR_BULK, NULL, 0 ),
> +
>  UNUSUAL_DEV(  0x0693, 0x0002, 0x0100, 0x0100, 
>  		"Hagiwara",
>  		"FlashGate SmartMedia",

Applied to both 2.4 and 2.6 trees.

thanks,

greg k-h
