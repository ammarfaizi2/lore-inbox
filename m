Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750798AbVJRROK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798AbVJRROK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 13:14:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750870AbVJRROK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 13:14:10 -0400
Received: from mail.kroah.org ([69.55.234.183]:2514 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750798AbVJRROJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 13:14:09 -0400
Date: Tue, 18 Oct 2005 10:13:33 -0700
From: Greg KH <greg@kroah.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: usb: Patch for USBDEVFS_IOCTL from 32-bit programs
Message-ID: <20051018171333.GA29504@kroah.com>
References: <20051017181554.77d0d45d.zaitcev@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051017181554.77d0d45d.zaitcev@redhat.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2005 at 06:15:54PM -0700, Pete Zaitcev wrote:
> I'm cross-posting to l-k because someone I know was making sounds at
> a notion of #ifdef CONFIG_COMPAT. But I think this solutions is superior
> to adding anything outside of devio.c.

Why not put this in fs/compat_ioctl.c where the other usbfs 32bit ioctls
are?

thanks,

greg k-h
