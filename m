Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750802AbWGLEXL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbWGLEXL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 00:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbWGLEXK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 00:23:10 -0400
Received: from cantor2.suse.de ([195.135.220.15]:15260 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750802AbWGLEXJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 00:23:09 -0400
Date: Tue, 11 Jul 2006 21:18:47 -0700
From: Greg KH <greg@kroah.com>
To: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       linux-pci maillist <linux-pci@atrey.karlin.mff.cuni.cz>,
       Tom Long Nguyen <tom.l.nguyen@intel.com>
Subject: Re: [PATCH 1/6] PCI-Express AER implemetation
Message-ID: <20060712041847.GA20793@kroah.com>
References: <1152668200.28493.178.camel@ymzhang-perf.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1152668200.28493.178.camel@ymzhang-perf.sh.intel.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2006 at 09:36:40AM +0800, Zhang, Yanmin wrote:
> I changed a little about the patches, so resend and cc to Greg.
> 
> Greg,
> 
> Could you consider for your testing tree?

Two comments on this series:
  - the pci_regs.h change I can take right now, that's in the standard
    so it can't hurt to add it now, right?  Is this ok?

  - the patches break the build if you try to build things without the
    whole series applied.  That's not good for users running 'git
    bisect' on Linus's tree.  Can you redo the series so this doesn't
    happen?

thanks,

greg k-h
