Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261215AbVG1EuV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261215AbVG1EuV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 00:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261217AbVG1EuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 00:50:21 -0400
Received: from lyle.provo.novell.com ([137.65.81.174]:50494 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S261215AbVG1EuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 00:50:17 -0400
Date: Wed, 27 Jul 2005 21:50:05 -0700
From: Greg KH <gregkh@suse.de>
To: Roland Dreier <rolandd@cisco.com>
Cc: "Michael S. Tsirkin" <mst@mellanox.co.il>,
       linux-pci@atrey.karlin.mff.cuni.cz, openib-general@openib.org,
       linux-kernel@vger.kernel.org, mj@ucw.cz
Subject: Re: [openib-general] Re: [PATCH] arch/xx/pci: remap_pfn_range -> io_remap_pfn_range
Message-ID: <20050728045005.GA13070@suse.de>
References: <20050725223200.GA1545@mellanox.co.il> <20050728042607.GA12799@suse.de> <52d5p3sgbq.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52d5p3sgbq.fsf@cisco.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2005 at 09:30:17PM -0700, Roland Dreier wrote:
>     Greg> Hm, you do realize that io_remap_pfn_range() is the same
>     Greg> thing as remap_pfn_range() on i386, right?
> 
>     Greg> So, why would this patch change anything?
> 
> It's not the same thing under Xen.  I think this patch fixes userspace
> access to PCI memory for XenLinux.

But Xen is a separate arch, and hence, will get different pci arch
specific functions, right?

In short, what is this patch trying to fix?  What is the problem anyone
is seeing with the existing code?

thanks,

greg k-h
