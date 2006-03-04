Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750776AbWCDBkn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbWCDBkn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 20:40:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750895AbWCDBkm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 20:40:42 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:42660
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750882AbWCDBkm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 20:40:42 -0500
Date: Fri, 03 Mar 2006 17:40:48 -0800 (PST)
Message-Id: <20060303.174048.14793187.davem@davemloft.net>
To: christopher.leech@intel.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 1/8] [I/OAT] DMA memcpy subsystem
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060303214220.11908.75517.stgit@gitlost.site>
References: <20060303214036.11908.10499.stgit@gitlost.site>
	<20060303214220.11908.75517.stgit@gitlost.site>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Leech <christopher.leech@intel.com>
Date: Fri, 03 Mar 2006 13:42:20 -0800

> +static spinlock_t dma_list_lock;

Please use DEFINE_SPINLOCK().

> +static void dma_chan_free_rcu(struct rcu_head *rcu) {

Newline before the brace please.

> +static void dma_async_device_cleanup(struct kref *kref) {

Newline before the brace please.

> +struct dma_chan_percpu
> +{

Left brace on the same line as "struct dma_chan_percpu" please.

> +struct dma_chan
> +{

Similarly.

Otherwise this patch looks mostly ok.
