Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262850AbVA2Edz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262850AbVA2Edz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 23:33:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262851AbVA2Edz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 23:33:55 -0500
Received: from mail.kroah.org ([69.55.234.183]:50410 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262850AbVA2Ecv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 23:32:51 -0500
Date: Fri, 28 Jan 2005 20:06:47 -0800
From: Greg KH <greg@kroah.com>
To: Christoph Hellwig <hch@infradead.org>, brking@us.ibm.com,
       linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org
Subject: Re: [PATCH 1/2] pci: Arch hook to determine config space size
Message-ID: <20050129040647.GA6261@kroah.com>
References: <200501281456.j0SEuI12020454@d01av01.pok.ibm.com> <20050128185234.GB21760@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050128185234.GB21760@infradead.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2005 at 06:52:34PM +0000, Christoph Hellwig wrote:
> > +int __attribute__ ((weak)) pcibios_exp_cfg_space(struct pci_dev *dev) { return 1; }
> 
>  - prototypes belong to headers
>  - weak linkage is the perfect way for total obsfucation
> 
> please make this a regular arch hook

I agree.  Also, when sending PCI related patches, please cc the
linux-pci mailing list.

thanks,

greg k-h
