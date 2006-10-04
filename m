Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751210AbWJDW4x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbWJDW4x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 18:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751212AbWJDW4x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 18:56:53 -0400
Received: from ns.suse.de ([195.135.220.2]:6843 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751210AbWJDW4v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 18:56:51 -0400
Date: Wed, 4 Oct 2006 15:56:49 -0700
From: Greg KH <greg@kroah.com>
To: John Keller <jpk@sgi.com>
Cc: akpm@osdl.org, linux-ia64@vger.kernel.org,
       pcihpd-discuss@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org
Subject: Re: [Pcihpd-discuss] [PATCH 1/3] - Altix: Add initial ACPI IO support
Message-ID: <20061004225649.GB14395@kroah.com>
References: <20061004214925.3193.26724.sendpatchset@attica.americas.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061004214925.3193.26724.sendpatchset@attica.americas.sgi.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2006 at 04:49:25PM -0500, John Keller wrote:
> First phase in introducing ACPI support to SN.
> In this phase, when running with an ACPI capable PROM,
> the DSDT will define the root busses and all SN nodes
> (SGIHUB, SGITIO). An ACPI bus driver will be registered
> for the node devices, with the acpi_pci_root_driver being
> used for the root busses. An ACPI vendor descriptor is
> now used to pass platform specific information for both
> nodes and busses, eliminating the need for the current
> SAL calls. Also, with ACPI support, SN fixup code is no longer
> needed to initiate the PCI bus scans, as the acpi_pci_root_driver
> does that.

How do these three patches differ from the ones I added to my tree
yesterday?

> Resend #2 - resync with TOT

"TOT"?

thanks,

greg k-h
