Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161000AbWAKGvQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161000AbWAKGvQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 01:51:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161004AbWAKGvQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 01:51:16 -0500
Received: from mail.kroah.org ([69.55.234.183]:44690 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161000AbWAKGvP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 01:51:15 -0500
Date: Tue, 10 Jan 2006 22:42:35 -0800
From: Greg KH <greg@kroah.com>
To: David.Ronis@McGill.CA
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB problem after upgrade from 2.6.12.6 to 2.6.15
Message-ID: <20060111064235.GB3954@kroah.com>
References: <1136774641.8342.14.camel@montroll.chem.mcgill.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1136774641.8342.14.camel@montroll.chem.mcgill.ca>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 08, 2006 at 09:44:01PM -0500, David Ronis wrote:
> I use gtkam to download photos from a Cannon A75 digital camera
> connected to my laptop via one of the USB ports.  After upgrading from
> 2.6.12.6 to 2.6.15 this stopped working.  The camera is recognized, but
> that all--none of the download commands work.  I see the following in
> syslog:
> 
> Jan  8 20:51:25 montroll kernel: usb 5-1: usbfs: interface 0 claimed by
> usbfs while 'gtkam' sets config #1

Please upgrade your version of libgphoto, it should be fixed there.

thanks,

greg k-h
