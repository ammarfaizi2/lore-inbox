Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932403AbVIKDMY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932403AbVIKDMY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 23:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932411AbVIKDMX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 23:12:23 -0400
Received: from mail.kroah.org ([69.55.234.183]:27287 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932403AbVIKDMX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 23:12:23 -0400
Date: Sat, 10 Sep 2005 20:11:50 -0700
From: Greg KH <greg@kroah.com>
To: Grant Coady <lkml@dodo.com.au>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       "Gaston, Jason D" <jason.d.gaston@intel.com>, mj@ucw.cz, akpm@osdl.org,
       linux-kernel@vger.kernel.org, Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 2.6.13-rc4 1/1] pci_ids: patch for Intel ICH7R
Message-ID: <20050911031150.GA20536@kroah.com>
References: <26CEE2C804D7BE47BC4686CDE863D0F5046EA44B@orsmsx410> <42EAABD1.8050903@pobox.com> <n4ple1haga8eano2vt2ipl17mrrmmi36jr@4ax.com> <42EAF987.7020607@pobox.com> <6f0me1p2q3g9ralg4a2k2mcra21lhpg6ij@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f0me1p2q3g9ralg4a2k2mcra21lhpg6ij@4ax.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 30, 2005 at 02:54:17PM +1000, Grant Coady wrote:
> On Fri, 29 Jul 2005 23:52:39 -0400, Jeff Garzik <jgarzik@pobox.com> wrote:
> >
> >However you did your search, you did it wrong.  The very first two 
> >entries I tried had zero uses:
> >
> >[jgarzik@pretzel linux-2.6]$ grepsrc ICH7_22
> >./include/linux/pci_ids.h:#define PCI_DEVICE_ID_INTEL_ICH7_22   0x27e0
> >[jgarzik@pretzel linux-2.6]$ grepsrc ICH7_23
> >./include/linux/pci_ids.h:#define PCI_DEVICE_ID_INTEL_ICH7_23   0x27e2
> >[jgarzik@pretzel linux-2.6]$
> 
> Sorry Jeff, excluding "include/linux/pci_ids.h" makes a huge difference :o)
> 
> Does roughly 1/3 unused:
> 
> 63065 2005-07-30 14:51 pci_ids-list
> 19243 2005-07-30 14:52 pci_ids-not_used
> 
> Seem in ballpark?

Great, care to send me a patch that trims this file down?

thanks,

greg k-h
