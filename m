Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751218AbVHSQRc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218AbVHSQRc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 12:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751223AbVHSQRc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 12:17:32 -0400
Received: from mail.kroah.org ([69.55.234.183]:7643 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751218AbVHSQRb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 12:17:31 -0400
Date: Fri, 19 Aug 2005 00:29:47 -0700
From: Greg KH <gregkh@suse.de>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sysfs: write returns ENOMEM?
Message-ID: <20050819072947.GA6894@kroah.com>
References: <200508190055.25747.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508190055.25747.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2005 at 12:55:25AM -0500, Dmitry Torokhov wrote:
> [Apologies if you see this message twice - I accidentially sent it in HTML
>  format first time around and I am pretty sure LKML will eat it]
> 
> Hi,
> 
> According to the SuS write() can not return ENOMEM, only ENOBUFS is allowed
> (surprisingly read() is allowed to use both ENOMEM and ENOBUFS):
> 
> http://www.opengroup.org/onlinepubs/000095399/functions/write.html
> 
> Should we adjust sysfs write to follow the standard?

Sure, I don't have a problem with this.  Anyone else object?

thanks,

greg k-h
