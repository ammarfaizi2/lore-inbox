Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261532AbUKSSdD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261532AbUKSSdD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 13:33:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261530AbUKSSb4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 13:31:56 -0500
Received: from mail.kroah.org ([69.55.234.183]:58602 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261531AbUKSSbi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 13:31:38 -0500
Date: Fri, 19 Nov 2004 10:30:11 -0800
From: Greg KH <greg@kroah.com>
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Documentation/pci.txt inconsistency
Message-ID: <20041119183011.GB20751@kroah.com>
References: <200411171334.56492@bilbo.math.uni-mannheim.de> <20041117220310.GB1291@kroah.com> <200411181045.01691@bilbo.math.uni-mannheim.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411181045.01691@bilbo.math.uni-mannheim.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2004 at 10:45:01AM +0100, Rolf Eike Beer wrote:
> Greg KH wrote:
> > On Wed, Nov 17, 2004 at 01:34:56PM +0100, Rolf Eike Beer wrote:
> > > The examples in section 2 of Documentation/pci.txt use pci_get_*. Some
> > > lines
> > >
> > > later there is this funny little paragraph:
> > > > Note that these functions are not hotplug-safe.  Their hotplug-safe
> > > > replacements are pci_get_device(), pci_get_class() and
> > > > pci_get_subsys(). They increment the reference count on the pci_dev
> > > > that they return. You must eventually (possibly at module unload)
> > > > decrement the reference count on these devices by calling
> > > > pci_dev_put().
> > >
> > > How about this:
> > >
> > > These functions are hotplug-safe. They increment the reference count on
> > > the pci_dev that they return. You must eventually (possibly at module
> > > unload) decrement the reference count on these devices by calling
> > > pci_dev_put().
> >
> > Great, care to send a patch instead?
> 
> Signed-off-by: Rolf Eike Beer <eike-kernel@sf-tec.de>

Applied, thanks.

greg k-h

