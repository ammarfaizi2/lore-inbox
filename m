Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261531AbUKSSfN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261531AbUKSSfN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 13:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261530AbUKSSdQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 13:33:16 -0500
Received: from mail.kroah.org ([69.55.234.183]:31467 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261531AbUKSScb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 13:32:31 -0500
Date: Fri, 19 Nov 2004 10:30:48 -0800
From: Greg KH <greg@kroah.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] remove unused drivers/pci/hotplug/pciehp_sysfs.c
Message-ID: <20041119183048.GD20751@kroah.com>
References: <20041113030203.GU2249@stusta.de> <20041115195148.GA12820@kroah.com> <20041115230105.GA4946@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041115230105.GA4946@stusta.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2004 at 12:01:05AM +0100, Adrian Bunk wrote:
> On Mon, Nov 15, 2004 at 11:51:48AM -0800, Greg KH wrote:
> > On Sat, Nov 13, 2004 at 04:02:03AM +0100, Adrian Bunk wrote:
> > > The patch below does some cleanups in the PCI code:
> > > - make OSC_UUID in drivers/pci/pci-acpi.c static
> > > - remove the completely unused drivers/pci/hotplug/pciehp_sysfs.c
> > > - remove other unused code
> > > 
> > > Please review which of these changes are correct and which conflict with 
> > > pending changes.
> > > 
> > 
> > >  drivers/pci/hotplug/Makefile       |    1 
> > >  drivers/pci/hotplug/pciehp.h       |    3 
> > >  drivers/pci/hotplug/pciehp_sysfs.c |  143 -------------
> > 
> > Yeah, this can be deleted.  Care to make a patch for just this?
> 
> It's below.

Applied, thanks.

greg k-h

