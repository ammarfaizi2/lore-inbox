Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752149AbWCJBVY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752149AbWCJBVY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 20:21:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752158AbWCJBVX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 20:21:23 -0500
Received: from ns2.suse.de ([195.135.220.15]:30126 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1752149AbWCJBVW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 20:21:22 -0500
From: Andi Kleen <ak@muc.de>
To: Terence Ripperda <tripperda@nvidia.com>
Subject: Re: [PATCH] x86-64: Make GART_IOMMU kconfig help text more specific (trivial)
Date: Thu, 9 Mar 2006 18:47:28 +0100
User-Agent: KMail/1.9.1
Cc: Jon Mason <jdmason@us.ibm.com>, linux-kernel@vger.kernel.org,
       mulix@mulix.org
References: <20060308214829.GJ28921@us.ibm.com> <20060310010230.GV8626@hygelac>
In-Reply-To: <20060310010230.GV8626@hygelac>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603091847.29787.ak@muc.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 10 March 2006 02:02, Terence Ripperda wrote:
> > Also, note that the previous help text stated that IOMMU was needed for
> > >3GB memory instead of >4GB.  This is fixed in the newer version.
> 
> note that many system bioses have memory remapping, to accomodate pci
> i/o ranges. some address space is reserved by the bios for these i/o
> ranges, and as system memory approaches this reserved space, the
> memory is remapped to >4GB. this usually happens around 3.25GB -
> 3.5GB, but probably varies based on bios and pci devices. once this
> memory is remapped to >4GB, the IOMMU kicks in.
> 
> so the original text is probably more accurate.

Yep. I already fixed this when applying the patch.

3GB is a rough round number I generally use for this.

-Andi

