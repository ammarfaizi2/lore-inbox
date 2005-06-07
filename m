Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261928AbVFGQMe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbVFGQMe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 12:12:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261927AbVFGQMe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 12:12:34 -0400
Received: from lyle.provo.novell.com ([137.65.81.174]:4764 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S261925AbVFGQMU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 12:12:20 -0400
Date: Tue, 7 Jun 2005 09:12:06 -0700
From: Greg KH <gregkh@suse.de>
To: Grant Grundler <grundler@parisc-linux.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, "David S. Miller" <davem@davemloft.net>,
       tom.l.nguyen@intel.com, roland@topspin.com,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       ak@suse.de
Subject: Re: [RFC PATCH] PCI: remove access to pci_[enable|disable]_msi() for drivers
Message-ID: <20050607161206.GC15345@suse.de>
References: <20050607002045.GA12849@suse.de> <20050607155324.GA29220@colo.lackof.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050607155324.GA29220@colo.lackof.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2005 at 09:53:24AM -0600, Grant Grundler wrote:
> On Mon, Jun 06, 2005 at 05:20:45PM -0700, Greg KH wrote:
> > -EXPORT_SYMBOL(pci_enable_msi);
> > -EXPORT_SYMBOL(pci_disable_msi);
> > +//EXPORT_SYMBOL(pci_enable_msi);
> > +//EXPORT_SYMBOL(pci_disable_msi);
> 
> You do plan on deleting these lines, right? (Just a reminder)

Heh, yes.  As to your other comments, you're right, I got the logic
wrong in places.  A new patch will be out in a few hours...

thanks,

greg k-h
