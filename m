Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964805AbWGNHdb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964805AbWGNHdb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 03:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964804AbWGNHdb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 03:33:31 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:22709
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S964801AbWGNHda (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 03:33:30 -0400
Date: Fri, 14 Jul 2006 00:33:34 -0700 (PDT)
Message-Id: <20060714.003334.57160916.davem@davemloft.net>
To: reuben-lkml@reub.net
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: 2.6.18-rc1-mm2
From: David Miller <davem@davemloft.net>
In-Reply-To: <44B73FEE.6040908@reub.net>
References: <20060713224800.6cbdbf5d.akpm@osdl.org>
	<44B73FEE.6040908@reub.net>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Reuben Farrelly <reuben-lkml@reub.net>
Date: Fri, 14 Jul 2006 18:55:42 +1200

> Ugh.  This on bootup..
> 
> Starting HAL daemon: BUG: warning at net/core/dev.c:1171/skb_checksum_help()

It's perfectly normal, and it's there to remind us that
we need to deal with an incremental checksumming issue
wrt. ip_nat_fn for GSO segments at some point.

You can safely ignore it for now.
