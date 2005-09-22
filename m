Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030264AbVIVJkY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030264AbVIVJkY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 05:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030265AbVIVJkY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 05:40:24 -0400
Received: from mail.kroah.org ([69.55.234.183]:17374 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030264AbVIVJkW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 05:40:22 -0400
Date: Thu, 22 Sep 2005 01:55:34 -0700
From: Greg KH <gregkh@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: ISDN USB build breakage
Message-ID: <20050922085534.GA7419@suse.de>
References: <43322900.7050500@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43322900.7050500@pobox.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2005 at 11:46:08PM -0400, Jeff Garzik wrote:
> 
> Latest -git tree 'make allmodconfig' build breaks on 32-bit x86:
> 
>   CC [M]  drivers/isdn/hisax/st5481_usb.o
> drivers/isdn/hisax/st5481_usb.c: In function `st5481_in_mode':
> drivers/isdn/hisax/st5481_usb.c:648: error: `URB_ASYNC_UNLINK' 
> undeclared (first use in this function)
> drivers/isdn/hisax/st5481_usb.c:648: error: (Each undeclared identifier 
> is reported only once
> drivers/isdn/hisax/st5481_usb.c:648: error: for each function it appears 
> in.)

Patch has been posted to lkml, hopefully it will make it into Linus's
tree soon...

thanks,

greg k-h
