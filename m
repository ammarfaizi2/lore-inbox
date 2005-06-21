Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261602AbVFUIyv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbVFUIyv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 04:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261626AbVFUIPW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 04:15:22 -0400
Received: from mail.kroah.org ([69.55.234.183]:60044 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261507AbVFUHSb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 03:18:31 -0400
Date: Tue, 21 Jun 2005 00:18:14 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, gregkh@suse.de
Subject: Re: [PATCH] devfs: Remove the tty_driver devfs_name field as it's no longer needed
Message-ID: <20050621071814.GA15597@kroah.com>
References: <11193354443273@kroah.com> <11193354441545@kroah.com> <20050621080930.A30570@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050621080930.A30570@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2005 at 08:09:30AM +0100, Russell King wrote:
> On Mon, Jun 20, 2005 at 11:30:44PM -0700, Greg KH wrote:
> > [PATCH] devfs: Remove the tty_driver devfs_name field as it's no longer needed
> > 
> > Also fixes all drivers that set this field.
> 
> Except for:
> 
> drivers/serial/serial_core.c:   normal->devfs_name      = drv->devfs_name;

Was fixed in the patch entitled:
	Subject: devfs: Remove the uart_driver devfs_name field as it's no longer needed

which came earlier in this series, but probably hasn't made it out of
vger yet :)

thanks,

greg k-h
