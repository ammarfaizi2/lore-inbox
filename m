Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265757AbUBJHn1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 02:43:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265775AbUBJHn1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 02:43:27 -0500
Received: from mail.kroah.org ([65.200.24.183]:23948 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265757AbUBJHnV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 02:43:21 -0500
Date: Mon, 9 Feb 2004 23:39:52 -0800
From: Greg KH <greg@kroah.com>
To: Len Brown <len.brown@intel.com>
Cc: Matthew Wilcox <willy@debian.org>,
       Sundarapandian Durairaj <sundarapandian.durairaj@intel.com>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       Harinarayanan Seshadri <harinarayanan.seshadri@intel.com>,
       Vladimir Kondratiev <vladimir.kondratiev@intel.com>,
       Jun Nakajima <jun.nakajima@intel.com>, Andrew Morton <akpm@zip.com.au>
Subject: Re: [PATCH] pci-mmconfig for 2.6.3-rc1
Message-ID: <20040210073951.GB20139@kroah.com>
References: <20040210044540.GA13351@parcelfarce.linux.theplanet.co.uk> <1076390140.4105.671.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1076390140.4105.671.camel@dhcppc4>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 10, 2004 at 12:15:40AM -0500, Len Brown wrote:
> On Mon, 2004-02-09 at 23:45, Matthew Wilcox wrote:
> > Another round of the MMCONFIG patch.  Changes since last time ...
> 
> If the system has no MADT, then acpi_boot_init() will never call
> acpi_parse_mcfg() -- looks like that call needs to be moved up.  (And
> yes, it seems that HPET has the same problem).
> 
> I see i386 and ia64 updates -- are they the only platforms that will
> support pci-express?

I know of some other platforms that will need pci-express support for
them, but that will probably happen some time next year due to hardware
availability...

I think we can only test i386 and ia64 at this time, unless someone else
knows differently?

thanks,

greg k-h
