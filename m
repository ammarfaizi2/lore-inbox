Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263792AbUASXEG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 18:04:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263800AbUASXEG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 18:04:06 -0500
Received: from mail.kroah.org ([65.200.24.183]:58259 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263792AbUASXEE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 18:04:04 -0500
Date: Mon, 19 Jan 2004 15:03:36 -0800
From: Greg KH <greg@kroah.com>
To: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       anton@samba.org
Subject: Re: [PATCH] ppc64: VIO support, from Dave Boutcher, Hollis Blanchard and Santiago Leon
Message-ID: <20040119230336.GA5008@kroah.com>
References: <200401192200.i0JM0dtb006058@hera.kernel.org> <20040119223230.GA4885@kroah.com> <20040119224953.A7395@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040119224953.A7395@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 19, 2004 at 10:49:53PM +0000, Christoph Hellwig wrote:
> On Mon, Jan 19, 2004 at 02:32:30PM -0800, Greg KH wrote:
> > Ick ick ick.  I thought you all were not going to add this function, but
> > just use vio_register_driver() on it's own?  Loading a driver should not
> > depend on CONFIG_HOTPLUG, as we now have different ways we can bind
> > drivers to devices after they are loaded (see the new_id stuff for pci
> > devices as an example.)
> 
> I wonder why this code got merged at all.  Half of it could easily be
> scrapped by using the driver model properly.

Which is another point.  I thought I saw a port of this code to the
driver model for 2.6 on the ppc mailing list.  Why this old code?

thanks,

greg k-h
