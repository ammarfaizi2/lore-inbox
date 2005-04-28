Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261644AbVD1BmU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261644AbVD1BmU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 21:42:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261648AbVD1BmU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 21:42:20 -0400
Received: from kalmia.hozed.org ([209.234.73.41]:27266 "EHLO kalmia.hozed.org")
	by vger.kernel.org with ESMTP id S261644AbVD1BmR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 21:42:17 -0400
Date: Wed, 27 Apr 2005 20:42:16 -0500
From: Troy Benjegerdes <hozer@hozed.org>
To: David Addison <addy@quadrics.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Andrea Arcangeli <andrea@suse.de>,
       David Addison <david.addison@quadrics.com>
Subject: Re: [PATCH][RFC] Linux VM hooks for advanced RDMA NICs
Message-ID: <20050428014216.GX999@kalmia.hozed.org>
References: <426E62ED.5090803@quadrics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <426E62ED.5090803@quadrics.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2005 at 04:49:01PM +0100, David Addison wrote:
> Hi,
> 
> here is a patch we use to integrate the Quadrics NICs into the Linux kernel.
> The patch adds hooks to the Linux VM subsystem so that registered 'IOPROC'
> devices can be informed of page table changes.
> This allows the Quadrics NICs to perform user RDMAs safely, without 
> requiring
> page pinning. Looking through some of the recent IB and Ammasso discussions,
> it may also prove useful to those NICs too.
> 

I think the best thing to do is post this patch to openib-general
( http://openib.org/mailman/listinfo/openib-general )
and get a patch developed that works on amasso, IB, and Quadrics
hardware, and then come back to lkml.
