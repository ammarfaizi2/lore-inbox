Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161310AbWBUEGy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161310AbWBUEGy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 23:06:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161309AbWBUEGx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 23:06:53 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:7119
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1161307AbWBUEGx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 23:06:53 -0500
Date: Mon, 20 Feb 2006 20:07:03 -0800 (PST)
Message-Id: <20060220.200703.132025777.davem@davemloft.net>
To: kaber@trash.net
Cc: earny@net4u.de, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       netfilter-devel@lists.netfilter.org
Subject: Re: 2.6.16-rc4 bridge/iptables Oops
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <43FA8439.6080009@trash.net>
References: <43FA0C02.8000909@trash.net>
	<200602210211.22364.earny@net4u.de>
	<43FA8439.6080009@trash.net>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick McHardy <kaber@trash.net>
Date: Tue, 21 Feb 2006 04:08:41 +0100

> Thanks for testing. Dave, please take this patch instead, it avoids
> having to guess whether a packet originates from bridging in IP
> netfilter by using DST_NOXFRM for bridge-netfilter's fake dst_entry.

Applied, thanks Patrick.
