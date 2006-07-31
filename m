Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751487AbWGaE6x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751487AbWGaE6x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 00:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751486AbWGaE6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 00:58:53 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:15331
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751479AbWGaE6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 00:58:52 -0400
Date: Sun, 30 Jul 2006 21:58:20 -0700 (PDT)
Message-Id: <20060730.215820.71162954.davem@davemloft.net>
To: akpm@osdl.org
Cc: david@davidcoulson.net, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: BUG: warning at net/core/dev.c:1171/skb_checksum_help()
 2.6.18-rc3
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060730213437.e2ce619d.akpm@osdl.org>
References: <44CD8415.2020403@davidcoulson.net>
	<20060730213437.e2ce619d.akpm@osdl.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>
Date: Sun, 30 Jul 2006 21:34:37 -0700

> Several people are reporting this.  It's apparently harmless and
> serves as a(n odd) way for the net guys to remind themselves that
> this needs fixing.
>
> It'd be nice to not let this escape into 2.6.18, please?

I'll make sure it doesn't. :)

