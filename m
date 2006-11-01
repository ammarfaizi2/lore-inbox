Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946216AbWKAALB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946216AbWKAALB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 19:11:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946218AbWKAALB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 19:11:01 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:43668 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1946216AbWKAALA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 19:11:00 -0500
Date: Tue, 31 Oct 2006 16:10:48 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: David Miller <davem@davemloft.net>, Christoph Hellwig <hch@lst.de>
cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, linux-mm@kvack.org
Subject: Re: [PATCH 2/3] add dev_to_node()
In-Reply-To: <20061030.143357.130208425.davem@davemloft.net>
Message-ID: <Pine.LNX.4.64.0610311610150.7609@schroedinger.engr.sgi.com>
References: <20061030141501.GC7164@lst.de> <20061030.143357.130208425.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2006, David Miller wrote:

> So, please add some sanity to this situation and just put the node
> into the generic struct device. :-)

Good. Then we can remove the node from the pci structure and get rid of 
pcibus_to_node?

