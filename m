Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751273AbWJEAgj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751273AbWJEAgj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 20:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWJEAgj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 20:36:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:17098 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751268AbWJEAgi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 20:36:38 -0400
Date: Wed, 4 Oct 2006 17:36:33 -0700
From: Andrew Morton <akpm@osdl.org>
To: Greg KH <greg@kroah.com>
Cc: John Keller <jpk@sgi.com>, linux-ia64@vger.kernel.org,
       pcihpd-discuss@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org
Subject: Re: [Pcihpd-discuss] [PATCH 1/3] - Altix: Add initial ACPI IO
 support
Message-Id: <20061004173633.c193eafd.akpm@osdl.org>
In-Reply-To: <20061004225649.GB14395@kroah.com>
References: <20061004214925.3193.26724.sendpatchset@attica.americas.sgi.com>
	<20061004225649.GB14395@kroah.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Oct 2006 15:56:49 -0700
Greg KH <greg@kroah.com> wrote:

> On Wed, Oct 04, 2006 at 04:49:25PM -0500, John Keller wrote:
> > First phase in introducing ACPI support to SN.
> > In this phase, when running with an ACPI capable PROM,
> > the DSDT will define the root busses and all SN nodes
> > (SGIHUB, SGITIO). An ACPI bus driver will be registered
> > for the node devices, with the acpi_pci_root_driver being
> > used for the root busses. An ACPI vendor descriptor is
> > now used to pass platform specific information for both
> > nodes and busses, eliminating the need for the current
> > SAL calls. Also, with ACPI support, SN fixup code is no longer
> > needed to initiate the PCI bus scans, as the acpi_pci_root_driver
> > does that.
> 
> How do these three patches differ from the ones I added to my tree
> yesterday?

A bunch of other stuff got merged out of order this morning and broke your
tree.  I asked John for a rediff.  Check your inbox ;)

> > Resend #2 - resync with TOT
> 
> "TOT"?

tip-of-tree.
