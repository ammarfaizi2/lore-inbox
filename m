Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261913AbULVAOf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261913AbULVAOf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 19:14:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261914AbULVAOe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 19:14:34 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:48618 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261913AbULVAOd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 19:14:33 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] add legacy resources to sysfs
Date: Tue, 21 Dec 2004 16:14:20 -0800
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, willy@debian.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>
References: <200412211247.44883.jbarnes@engr.sgi.com> <200412211542.47997.jbarnes@engr.sgi.com> <20041222000509.GA12595@kroah.com>
In-Reply-To: <20041222000509.GA12595@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412211614.20958.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, December 21, 2004 4:05 pm, Greg KH wrote:
> You can make a symlink to a kobject, not a attribute.  We already have a
> symlink in that directory to the device, so do you really need another
> one?

I guess not, it would just be a little more convenient, but it's no biggie.

> >  drivers/base/class.c    |   16 ++++++++++
>
> Hm, how about splitting this further, one for the driver core stuff (you
> forgot the device.h change here too...) and the other for the PCI stuff?

Sure, I'll split it out.  Did you mean that I was missing the prototype?  I'll 
fix that up too.

Thanks,
Jesse
