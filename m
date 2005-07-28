Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261191AbVG1Eak@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261191AbVG1Eak (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 00:30:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261196AbVG1Eaj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 00:30:39 -0400
Received: from ams-iport-1.cisco.com ([144.254.224.140]:35359 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S261191AbVG1Eae (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 00:30:34 -0400
To: Greg KH <gregkh@suse.de>
Cc: "Michael S. Tsirkin" <mst@mellanox.co.il>,
       linux-pci@atrey.karlin.mff.cuni.cz, openib-general@openib.org,
       linux-kernel@vger.kernel.org, mj@ucw.cz
Subject: Re: [openib-general] Re: [PATCH] arch/xx/pci: remap_pfn_range ->
 io_remap_pfn_range
X-Message-Flag: Warning: May contain useful information
References: <20050725223200.GA1545@mellanox.co.il>
	<20050728042607.GA12799@suse.de>
From: Roland Dreier <rolandd@cisco.com>
Date: Wed, 27 Jul 2005 21:30:17 -0700
In-Reply-To: <20050728042607.GA12799@suse.de> (Greg KH's message of "Wed, 27
 Jul 2005 21:26:07 -0700")
Message-ID: <52d5p3sgbq.fsf@cisco.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 28 Jul 2005 04:30:29.0599 (UTC) FILETIME=[15A6C6F0:01C5932D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Greg> Hm, you do realize that io_remap_pfn_range() is the same
    Greg> thing as remap_pfn_range() on i386, right?

    Greg> So, why would this patch change anything?

It's not the same thing under Xen.  I think this patch fixes userspace
access to PCI memory for XenLinux.

 - R.
