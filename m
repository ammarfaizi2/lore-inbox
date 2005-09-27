Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964911AbVI0Mnz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964911AbVI0Mnz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 08:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964913AbVI0Mnz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 08:43:55 -0400
Received: from mail.kroah.org ([69.55.234.183]:9449 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964911AbVI0Mnz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 08:43:55 -0400
Date: Tue, 27 Sep 2005 05:43:35 -0700
From: Greg KH <greg@kroah.com>
To: dmitry pervushin <dpervushin@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       spi-devel-general@lists.sourceforge.net
Subject: Re: SPI
Message-ID: <20050927124335.GA10361@kroah.com>
References: <1127733134.7577.0.camel@diimka.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1127733134.7577.0.camel@diimka.dev.rtsoft.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2005 at 03:12:14PM +0400, dmitry pervushin wrote:
> +/*
> + * spi_device_release
> + * 
> + * Pointer to this function will be put to dev->release place
> + * This function gets called as a part of device removing
> + * 
> + * Parameters:
> + * 	struct device* dev
> + * Return value:
> + * 	none
> + */
> +void spi_device_release( struct device* dev )
> +{
> +/* just a placeholder */
> +}

This is ALWAYS wrong, please fix your code.  See the many times I have
been over this issue in the archives.

Also, please fix your coding style to match the kernel if you wish to
have a chance to get it included. :)

thanks,

greg k-h
