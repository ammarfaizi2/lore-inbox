Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261756AbUD3Wly@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261756AbUD3Wly (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 18:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261752AbUD3Wly
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 18:41:54 -0400
Received: from mail.kroah.org ([65.200.24.183]:46289 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261756AbUD3Wll (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 18:41:41 -0400
Date: Fri, 30 Apr 2004 15:41:11 -0700
From: Greg KH <greg@kroah.com>
To: Duncan Sands <baldrick@free.fr>
Cc: Grzegorz Kulewski <kangur@polcom.net>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, linux-usb-devel@lists.sourceforge.net,
       speedtouch@ml.free.fr
Subject: Re: [linux-usb-devel] 3 USB regressions (2.6.6-rc3-bk1) that should be fixed before 2.6.6
Message-ID: <20040430224111.GB14643@kroah.com>
References: <Pine.LNX.4.58.0404300113120.444@alpha.polcom.net> <200404300952.00454.baldrick@free.fr> <20040430155521.GA4463@kroah.com> <200404301810.56271.baldrick@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404301810.56271.baldrick@free.fr>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 30, 2004 at 06:10:56PM +0200, Duncan Sands wrote:
> > Honestly, I don't see how some of these issues started showing up
> > between those two kernel releases.  You can see the only changes made in
> > the USB section broken out by patch at:
> > 	kernel.org/pub/linux/kernel/people/gregkh/2.6/2.6.6-rc2/
> 
> Hi Greg, I'm not sure when these problems started showing up, maybe they
> have been in 2.6.6- for a while.  One patch that may be worth having in 2.6.6
> by the way is the one for device_disconnect in devio.c that changes
> destroy_all_async to destroy_async_on_interface.  It's clearly correct and does
> do some good!

Care to point out which one this was?  I'm swimming in a sea of patches
right now :)

thanks,

greg k-h
