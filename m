Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932175AbVLGAEi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175AbVLGAEi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 19:04:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932661AbVLGAEh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 19:04:37 -0500
Received: from mail.kroah.org ([69.55.234.183]:43664 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932175AbVLGAEh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 19:04:37 -0500
Date: Tue, 6 Dec 2005 16:02:16 -0800
From: Greg KH <gregkh@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, Takahiro Hirofuchi <taka-hir@is.naist.jp>,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: 2.6.15-rc5-mm1: USB_IP problems
Message-ID: <20051207000216.GA17953@suse.de>
References: <20051204232153.258cd554.akpm@osdl.org> <20051205214055.GN9973@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051205214055.GN9973@stusta.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2005 at 10:40:55PM +0100, Adrian Bunk wrote:
> On Sun, Dec 04, 2005 at 11:21:53PM -0800, Andrew Morton wrote:
> >...
> >  Subsystem trees
> >...
> > +gregkh-usb-usbip.patch
> > 
> >  USB tree updates
> >...
> 
> Problems with this patch:
> - USB_IP: no need for a "default N"

Why not?  Is that the "default"?

> - USB_IP must be a tristate, because currently the illegal configurations 
>   USB=m, USB_IP=y, USB_IP_{VHCI,STUB}=y are allowed
> - compilation fails with USB_IP_VHCI=y, USB_IP_STUB=y:

Yeah, sorry about that.  This code is going to get a lot of scrubbing
before it will go into mainline.  Thanks for your patch, I'll apply it.

greg k-h
