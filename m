Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261923AbULVAUk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261923AbULVAUk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 19:20:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261921AbULVAUk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 19:20:40 -0500
Received: from mail.kroah.org ([69.55.234.183]:14242 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261919AbULVAUZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 19:20:25 -0500
Date: Tue, 21 Dec 2004 16:20:10 -0800
From: Greg KH <greg@kroah.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: linux-kernel@vger.kernel.org, willy@debian.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH] add legacy resources to sysfs
Message-ID: <20041222002010.GA12799@kroah.com>
References: <200412211247.44883.jbarnes@engr.sgi.com> <200412211542.47997.jbarnes@engr.sgi.com> <20041222000509.GA12595@kroah.com> <200412211614.20958.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412211614.20958.jbarnes@engr.sgi.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2004 at 04:14:20PM -0800, Jesse Barnes wrote:
> On Tuesday, December 21, 2004 4:05 pm, Greg KH wrote:
> > >  drivers/base/class.c    |   16 ++++++++++
> >
> > Hm, how about splitting this further, one for the driver core stuff (you
> > forgot the device.h change here too...) and the other for the PCI stuff?
> 
> Sure, I'll split it out.  Did you mean that I was missing the prototype?  I'll 
> fix that up too.

Yeah, no prototype.  Makes it a bit hard to use the function :)

thanks,

greg k-h
