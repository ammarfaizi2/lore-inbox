Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261757AbVF1IjX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261757AbVF1IjX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 04:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261781AbVF1IOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 04:14:53 -0400
Received: from mail.kroah.org ([69.55.234.183]:56260 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261900AbVF1IJ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 04:09:59 -0400
Date: Tue, 28 Jun 2005 00:51:40 -0700
From: Greg KH <greg@kroah.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-pci <linux-pci@atrey.karlin.mff.cuni.cz>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: Re: [PATCH] ppc/ppc64: Fix pci mmap via sysfs
Message-ID: <20050628075140.GF3577@kroah.com>
References: <1119836190.5133.59.camel@gaston> <20050626185727.0ce92772.akpm@osdl.org> <1119838264.5133.76.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1119838264.5133.76.camel@gaston>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2005 at 12:11:03PM +1000, Benjamin Herrenschmidt wrote:
> On Sun, 2005-06-26 at 18:57 -0700, Andrew Morton wrote:
> > Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > >
> > > Hi !
> > > 
> > > This implement the change to /proc and sysfs PCI mmap functions that we
> > > discussed a while ago, that is adding an arch optional
> > > pci_resource_to_user() to allow munging on the exposed value of PCI
> > > resources to userland and thus hiding kernel internal values. It also
> > > implements using of that callback to sanitize exposed values on ppc an
> > > ppc64, thus fixing mmap of PCI devices via /proc and sysfs.
> > > 
> > 
> > You sure you want all those printks in there?
> 
> One quilt ref later ... :)
> 
> Hi !
> 
> This implement the change to /proc and sysfs PCI mmap functions that we
> discussed a while ago, that is adding an arch optional
> pci_resource_to_user() to allow munging on the exposed value of PCI
> resources to userland and thus hiding kernel internal values. It also
> implements using of that callback to sanitize exposed values on ppc an
> ppc64, thus fixing mmap of PCI devices via /proc and sysfs.

Hm, did I just send the right one to Linus?

thanks,

greg k-h
