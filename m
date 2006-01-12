Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030297AbWALFgs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030297AbWALFgs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 00:36:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030295AbWALFgs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 00:36:48 -0500
Received: from c-24-22-115-24.hsd1.or.comcast.net ([24.22.115.24]:62601 "EHLO
	aria.kroah.org") by vger.kernel.org with ESMTP id S1030293AbWALFgr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 00:36:47 -0500
Date: Wed, 11 Jan 2006 21:36:22 -0800
From: Greg KH <gregkh@suse.de>
To: Grant Grundler <grundler@parisc-linux.org>
Cc: Mark Maule <maule@sgi.com>, linuxppc64-dev@ozlabs.org,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH 1/3] msi vector targeting abstractions
Message-ID: <20060112053622.GA29142@suse.de>
References: <20060111155251.12460.71269.12163@attica.americas.sgi.com> <20060111155256.12460.26048.32596@attica.americas.sgi.com> <20060112050243.GC332@colo.lackof.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060112050243.GC332@colo.lackof.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2006 at 10:02:43PM -0700, Grant Grundler wrote:
> On Wed, Jan 11, 2006 at 09:52:56AM -0600, Mark Maule wrote:
> > Abstract portions of the MSI core for platforms that do not use standard
> > APIC interrupt controllers.  This is implemented through a new arch-specific
> > msi setup routine, and a set of msi ops which can be set on a per platform
> > basis.
> ...
> > Index: linux-maule/drivers/pci/msi.c
> ...
> > +	if ((status = msi_arch_init()) < 0) {
> 
> Willy told me I should always complain about assignment in if() statements :)
> 
> Greg, I volunteer to submit a patch to fix all occurances in pci/msi.c
> including the one above.  I can prepare that this weekend on my own time.
> Is that ok?

Yes, that would be wonderful to have.

thanks,

greg k-h
