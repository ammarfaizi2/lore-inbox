Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261324AbVFOTEN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261324AbVFOTEN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 15:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261355AbVFOTEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 15:04:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:61829 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261324AbVFOTDj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 15:03:39 -0400
Date: Wed, 15 Jun 2005 21:03:38 +0200
From: Andi Kleen <ak@suse.de>
To: Greg KH <gregkh@suse.de>
Cc: Andi Kleen <ak@suse.de>, len.brown@intel.com,
       acpi-devel@lists.sourceforge.net, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/04] PCI: use the MCFG table to properly access pci devices (i386)
Message-ID: <20050615190338.GT11898@wotan.suse.de>
References: <20050615052916.GA23394@kroah.com> <20050615053031.GB23394@kroah.com> <20050615053120.GC23394@kroah.com> <20050615094833.GB11898@wotan.suse.de> <20050615175447.GA29138@suse.de> <20050615182346.GQ11898@wotan.suse.de> <20050615183547.GA29587@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050615183547.GA29587@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > For those you would have bus->ops pointing to the old port code,
> > for the others to the mmconfig code.
> 
> Well, for that, I'll have to set the bus ops when they are discovered.
> So the same callback I mentioned can be used for that (due to the need
> to check the ranges in the MCFG table).  I'll work on that too.
> 
> Does the K8 box just not have MCFG entries for the northbridge busses?

I believe so. 

-Andi
