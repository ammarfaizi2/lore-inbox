Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751040AbVKDWP2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751040AbVKDWP2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 17:15:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751041AbVKDWP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 17:15:28 -0500
Received: from mail.kroah.org ([69.55.234.183]:55195 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751039AbVKDWP1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 17:15:27 -0500
Date: Fri, 4 Nov 2005 14:14:37 -0800
From: Greg KH <greg@kroah.com>
To: linas@austin.ibm.com
Cc: paulus@samba.org, linuxppc64-dev@ozlabs.org, johnrose@austin.ibm.com,
       linux-pci@atrey.karlin.mff.cuni.cz,
       bluesmoke-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/42] PCI Error Recovery for PPC64 and misc device drivers
Message-ID: <20051104221437.GA20004@kroah.com>
References: <20051103235918.GA25616@mail.gnucash.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051103235918.GA25616@mail.gnucash.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2005 at 05:59:18PM -0600, Linas Vepstas wrote:
> What follows is a long sequence of mostly small patches to implement
> PCI Error Recovery by adding notification callbacks to the PCI device
> driver structure, implementing the recovery in 5 device drivers
> (3 ethernet, two scsi drivers), and adding the actual error detection
> and recovery code to the ppc64/powerpc arch tree.
> 
> Highlights:
> 
> -- Patches 1-14: Misc required ppc64/powerpc cleanup/bugfixes/restructuring
> -- Patch 15: Overview documentation
> -- Patch 16: changes to include/linux/pci.h
> -- Patches 17-26: error detection and recovery for pSeries PCI bridge chips
> -- Patchs 27-32: recovery patches for ethernet, scsi device drivers
> -- Patches 33-42: More misc ppc64-specific changes

Ok, so at first glance, I only need to pay attention to patches 15, 16,
and 27-32?  If so, please send the ppc64 specific patches through the
ppc64 maintainers, and the rpaphp specific patches through that specific
maintainer.  Then care to resend the 8 remaining patches to me, so I can
stage them in -mm for a while?

thanks,

greg k-h
