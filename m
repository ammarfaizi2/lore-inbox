Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261160AbUCaB0o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 20:26:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261161AbUCaB0o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 20:26:44 -0500
Received: from mail.kroah.org ([65.200.24.183]:35819 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261160AbUCaB0m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 20:26:42 -0500
Date: Tue, 30 Mar 2004 17:18:48 -0800
From: Greg KH <greg@kroah.com>
To: Dave Jones <davej@redhat.com>, luca.risolia@studio.unibo.it,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] w9968cf driver misplaced ;
Message-ID: <20040331011848.GB12238@kroah.com>
References: <20040330143210.GA25834@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040330143210.GA25834@redhat.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2004 at 03:32:10PM +0100, Dave Jones wrote:
> --- linux-2.6.4/drivers/usb/media/w9968cf.c~	2004-03-30 15:28:43.000000000 +0100
> +++ linux-2.6.4/drivers/usb/media/w9968cf.c	2004-03-30 15:29:08.000000000 +0100
> @@ -3369,7 +3369,7 @@
>  		if (copy_from_user(&tuner, arg, sizeof(tuner)))
>  			return -EFAULT;
>  
> -		if (tuner.tuner != 0);
> +		if (tuner.tuner != 0)
>  			return -EINVAL;
>  
>  		strcpy(tuner.name, "no_tuner");

Applied, thanks.

greg k-h
