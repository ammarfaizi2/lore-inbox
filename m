Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264741AbTFTVTW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 17:19:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264753AbTFTVTV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 17:19:21 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:32443 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264741AbTFTVTT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 17:19:19 -0400
Date: Fri, 20 Jun 2003 14:24:13 -0700
From: Greg KH <greg@kroah.com>
To: Matthew Wilcox <willy@debian.org>
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@redhat.com>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Anton Blanchard <anton@samba.org>, David Mosberger <davidm@hpl.hp.com>
Subject: Re: [PATCH] reimplement pci proc name
Message-ID: <20030620212413.GA13694@kroah.com>
References: <20030620134811.GR24357@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030620134811.GR24357@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 20, 2003 at 02:48:11PM +0100, Matthew Wilcox wrote:
> 
> Hi Greg.  Ivan's not happy with the solution I came up with for naming
> /proc/bus/pci and Anton would prefer something slightly different too,
> so I abstracted the name out so each architecture can do its own thing.
> 
> This is against 2.5.72 so won't apply cleanly to your tree (it
> applies to bitkeeper as of a few minutes ago with only minor offsets).
> I've implemented the original name for non-PCI-domain machines; done what
> ia64 and alpha need, respectively (assuming I didn't misunderstand Ivan),
> and plopped in the Old Way of doing things for Sparc64, PPC and PPC64.
> Maintainers may alter this to whatever degree of complexity they wish.

Thanks, I've reverted your previous patch, and fixed the one typo in
this patch and applied it all to my bk tree.  Hopefully Linus will pull
from it sometime soon :)

thanks,

greg k-h
