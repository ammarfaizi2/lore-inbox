Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261873AbVBAIwW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261873AbVBAIwW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 03:52:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261868AbVBAIvS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 03:51:18 -0500
Received: from mail.kroah.org ([69.55.234.183]:12985 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261870AbVBAIvB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 03:51:01 -0500
Date: Tue, 1 Feb 2005 00:41:18 -0800
From: Greg KH <greg@kroah.com>
To: Kumar Gala <kumar.gala@freescale.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: serial8250_init and platform_device
Message-ID: <20050201084117.GA22229@kroah.com>
References: <20050120154420.D13242@flint.arm.linux.org.uk> <736677C2-6B16-11D9-BD44-000393DBC2E8@freescale.com> <20050120193845.H13242@flint.arm.linux.org.uk> <20050120195058.GA8835@kroah.com> <20050120201059.I13242@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050120201059.I13242@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2005 at 08:10:59PM +0000, Russell King wrote:
> On Thu, Jan 20, 2005 at 11:50:58AM -0800, Greg KH wrote:
> > On Thu, Jan 20, 2005 at 07:38:45PM +0000, Russell King wrote:
> > > 
> > > Greg - the name is constructed from "name" + "id num" thusly:
> > > 
> > > 	serial8250
> > > 	serial82500
> > > 	serial82501
> > > 	serial82502
> > > 
> > > When "name" ends in a number, it gets rather confusing.  Can we have
> > > an optional delimiter in there when we append the ID number, maybe
> > > something like a '.' or ':' ?
> > 
> > Sure, that's fine with me.  Someone send me a patch :)
> 
> Like this?
> -
> 
> Separate platform device name from platform device number such that
> names ending with numbers aren't confusing.
> 
> Signed-off-by: Russell King <rmk@arm.linux.org.uk>

Looks good to me, applied.

thanks,

greg k-h
