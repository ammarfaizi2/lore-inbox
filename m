Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262931AbVALAIn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262931AbVALAIn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 19:08:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262954AbVALAFI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 19:05:08 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:44242 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262931AbVAKXkt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 18:40:49 -0500
Date: Tue, 11 Jan 2005 15:39:22 -0800
From: Greg KH <greg@kroah.com>
To: long <tlnguyen@snoqualmie.dp.intel.com>
Cc: hch@infradead.org, linux-kernel@vger.kernel.org, tom.l.nguyen@intel.com
Subject: Re: [PATCH]PCI Express Port Bus Driver
Message-ID: <20050111233922.GA19818@kroah.com>
References: <200412230123.iBN1NFVd008420@snoqualmie.dp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412230123.iBN1NFVd008420@snoqualmie.dp.intel.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2004 at 05:23:15PM -0800, long wrote:
> On Tuesday, December 21, 2004 11:56 AM, Greg KH wrote:  
> > On Tue, Dec 21, 2004 at 11:46:32AM -0800, Nguyen, Tom L wrote:
> >> On Tuesday, December 21, 2004 10:58 AM, Christoph Hellwig wrote: 
> >> > Any reason the new files aren't just under drivers/pci/ ?
> >> PCI Express Port Bus driver runs on PCI Express PCI-PCI Bridges to
> >> manage service requests as required while under drivers/pci/ includes
> >> specific drivers for the PCI bus. Please send us your suggestions.
> >
> > I think drivers/pci/pcie would be a good place for this, as you can't
> > have PCI-E without PCI, right?
> Patch below includes changes based on your comments.
> 
> Signed-off-by: T. Long Nguyen <tom.l.nguyen@intel.com>

Looks good, thanks for making the changes.  I've applied this to my
trees, so it should show up in the next -mm release, and then on to
Linus.

greg k-h
