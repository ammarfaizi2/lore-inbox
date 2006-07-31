Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751485AbWGaE7k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751485AbWGaE7k (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 00:59:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751483AbWGaE7k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 00:59:40 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:16099
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751478AbWGaE7j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 00:59:39 -0400
Date: Sun, 30 Jul 2006 21:59:07 -0700 (PDT)
Message-Id: <20060730.215907.58439803.davem@davemloft.net>
To: kaber@trash.net
Cc: david@davidcoulson.net, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: BUG: warning at net/core/dev.c:1171/skb_checksum_help()
 2.6.18-rc3
From: David Miller <davem@davemloft.net>
In-Reply-To: <44CD85FF.9010607@trash.net>
References: <44CD8415.2020403@davidcoulson.net>
	<44CD85FF.9010607@trash.net>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick McHardy <kaber@trash.net>
Date: Mon, 31 Jul 2006 06:24:31 +0200

> This is a known problem with NAT and HW checksum and will probably get
> fixed in 2.6.19.

I would like to see this fixed for 2.6.18, no later.

Either that or disable the bug trap, but taking this route
is severely discouraged. :)



