Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261655AbULUUCv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261655AbULUUCv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 15:02:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261627AbULUUA5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 15:00:57 -0500
Received: from mail.kroah.org ([69.55.234.183]:20963 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261603AbULUT4q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 14:56:46 -0500
Date: Tue, 21 Dec 2004 11:56:20 -0800
From: Greg KH <greg@kroah.com>
To: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]PCI Express Port Bus Driver
Message-ID: <20041221195620.GA9466@kroah.com>
References: <C7AB9DA4D0B1F344BF2489FA165E5024074C281F@orsmsx404.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C7AB9DA4D0B1F344BF2489FA165E5024074C281F@orsmsx404.amr.corp.intel.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2004 at 11:46:32AM -0800, Nguyen, Tom L wrote:
> On Tuesday, December 21, 2004 10:58 AM, Christoph Hellwig wrote: 
> > Any reason the new files aren't just under drivers/pci/ ?
> PCI Express Port Bus driver runs on PCI Express PCI-PCI Bridges to
> manage service requests as required while under drivers/pci/ includes
> specific drivers for the PCI bus. Please send us your suggestions.

I think drivers/pci/pcie would be a good place for this, as you can't
have PCI-E without PCI, right?

thanks,

greg k-h
