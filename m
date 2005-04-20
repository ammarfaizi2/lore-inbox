Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261388AbVDTErA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261388AbVDTErA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 00:47:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261392AbVDTErA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 00:47:00 -0400
Received: from mail.kroah.org ([69.55.234.183]:24480 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261388AbVDTEq7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 00:46:59 -0400
Date: Tue, 19 Apr 2005 21:46:31 -0700
From: Greg KH <greg@kroah.com>
To: yoshfuji@linux-ipv6.org
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: compilation failure on usb/image/microtek.c
Message-ID: <20050420044631.GA16583@kroah.com>
References: <20050420.131034.42261841.yoshfuji@linux-ipv6.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050420.131034.42261841.yoshfuji@linux-ipv6.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2005 at 01:10:34PM +0900, B <yoshfuji@linux-ipv6.org> wrote:
> From: Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
> 
> maybe typo?
> 
> Signed-off-by: Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
> 
> --- a/drivers/usb/image/microtek.c
> +++ b/drivers/usb/image/microtek.c
> @@ -335,7 +335,7 @@ static int mts_scsi_abort (Scsi_Cmnd *sr
>  
>  	mts_urb_abort(desc);
>  
> -	return FAILURE;
> +	return FAILED;
>  }

Thanks, this is in my todo queue, it's due to the fallout of the
scsi-misc merge :)

greg k-h
