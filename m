Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932310AbVLMA7g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932310AbVLMA7g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 19:59:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932317AbVLMA7g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 19:59:36 -0500
Received: from fmr23.intel.com ([143.183.121.15]:50050 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S932310AbVLMA7f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 19:59:35 -0500
Date: Mon, 12 Dec 2005 16:59:11 -0800
From: Rajesh Shah <rajesh.shah@intel.com>
To: Anton Blanchard <anton@samba.org>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz,
       pcihpd-discuss@lists.sourceforge.net, miltonm@bga.com
Subject: Re: [PATCH] PCI express must be initialized before PCI hotplug
Message-ID: <20051212165910.A6042@unix-os.sc.intel.com>
Reply-To: Rajesh Shah <rajesh.shah@intel.com>
References: <20051212001201.GF23641@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20051212001201.GF23641@krispykreme>; from anton@samba.org on Mon, Dec 12, 2005 at 11:12:01AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2005 at 11:12:01AM +1100, Anton Blanchard wrote:
> 
> From: Milton Miller <miltonm@bga.com>
> 
> PCI express hotplug uses the pcieportbus driver so pcie must be
> initialized before hotplug/.  This patch changes the link order.
> 
Yes, this fixes it. Long term, I'm hoping to avoid this problem
by merging the pcie code a bit more closely with pci.

thanks,
Rajesh

