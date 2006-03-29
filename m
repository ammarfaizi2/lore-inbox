Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751252AbWC2XaR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbWC2XaR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 18:30:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWC2XaR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 18:30:17 -0500
Received: from mx.pathscale.com ([64.160.42.68]:13513 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751252AbWC2XaP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 18:30:15 -0500
Subject: Re: [openib-general] InfiniBand 2.6.17 merge plans
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Roland Dreier <rdreier@cisco.com>
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
In-Reply-To: <ada7j6f8xwi.fsf@cisco.com>
References: <ada7j6f8xwi.fsf@cisco.com>
Content-Type: text/plain
Organization: PathScale, Inc.
Date: Wed, 29 Mar 2006 15:30:14 -0800
Message-Id: <1143675014.5238.1.camel@chalcedony.internal.keyresearch.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-03-27 at 11:56 -0800, Roland Dreier wrote:

>  * PathScale ipath driver.  In my git tree at
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/roland/infiniband.git ipath
> 
>    There is still ia64 build breakage and a lot of sparse endian
>    annotations to clean up before it's mergeable.

These are all fixed now.

>    - Working around the IB midlayer SMA (subnet management agent) /
>      implementation with a character device when ib_mad isn't loaded.

We dropped this in the round of changes I just submitted.

>    - The driver depends on 64BIT && PCI_MSI, and is basically
>      x86_64-only for practical purposes.  I think this is OK as far as
>      a merge goes, but it would be nice to be able to use a PCIe
>      device on any system with PCIe slots...

We'll see what we can do about this at some point, but I don't think it
should block the merge.

	<b

