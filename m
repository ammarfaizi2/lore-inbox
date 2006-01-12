Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030268AbWALHQg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030268AbWALHQg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 02:16:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030271AbWALHQg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 02:16:36 -0500
Received: from mail.kroah.org ([69.55.234.183]:38787 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030268AbWALHQf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 02:16:35 -0500
Date: Wed, 11 Jan 2006 23:12:36 -0800
From: Greg KH <greg@kroah.com>
To: Shaohua Li <shaohua.li@intel.com>
Cc: Matthew Wilcox <matthew@wil.cx>, Andrew Morton <akpm@osdl.org>,
       linux-pci <linux-pci@atrey.karlin.mff.cuni.cz>,
       lkml <linux-kernel@vger.kernel.org>,
       Rajesh Shah <rajesh.shah@intel.com>
Subject: Re: [PATCH 1/2]MSI(X) save/restore for suspend/resume
Message-ID: <20060112071236.GA32453@kroah.com>
References: <20060103231304.56e3228b.akpm@osdl.org> <1136422680.30655.1.camel@sli10-desk.sh.intel.com> <20060110202841.GZ19769@parisc-linux.org> <1136942240.5750.35.camel@sli10-desk.sh.intel.com> <20060111012625.GA29108@kroah.com> <1136967502.5750.65.camel@sli10-desk.sh.intel.com> <20060111155142.GA19828@kroah.com> <1137033060.5750.68.camel@sli10-desk.sh.intel.com> <20060112024732.GE19769@parisc-linux.org> <1137035871.5750.80.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1137035871.5750.80.camel@sli10-desk.sh.intel.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2006 at 11:17:51AM +0800, Shaohua Li wrote:
> On Wed, 2006-01-11 at 19:47 -0700, Matthew Wilcox wrote:
> > On Thu, Jan 12, 2006 at 10:30:59AM +0800, Shaohua Li wrote:
> > 
> > Did you not understand my comment about using the hlist functions?
> > 
> > > +struct pci_cap_saved_state {
> > > +	struct list_head next;
> > 
> > struct hlist_node list;
> 
> Add MSI(X) configure space save/restore in generic PCI helper.

What hardware has this patch been tested on?

thanks,

greg k-h
