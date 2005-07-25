Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261575AbVGYCJr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261575AbVGYCJr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Jul 2005 22:09:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261592AbVGYCJr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Jul 2005 22:09:47 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:11736
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S261590AbVGYCJr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Jul 2005 22:09:47 -0400
Date: Sun, 24 Jul 2005 19:09:39 -0700 (PDT)
Message-Id: <20050724.190939.03085123.davem@davemloft.net>
To: laforge@netfilter.org
Cc: yoshfuji@linux-ipv6.org, johnpol@2ka.mipt.ru,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 1 Wire drivers illegally overload NETLINK_NFLOG
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050723133353.GB11177@rama>
References: <20050723125427.GA11177@rama>
	<20050722.230559.123762041.yoshfuji@linux-ipv6.org>
	<20050723133353.GB11177@rama>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Harald Welte <laforge@netfilter.org>
Date: Sat, 23 Jul 2005 09:33:53 -0400

> I strongly disrecommend increasing NPROTO.  Maybe we should look into
> reusing NETLINK_FIREWALL (which was an old 2.2.x kernel interface).

That is how I will fix this 1-wire case, by reusing the NETLINK_FIREWALL
thing.

> But to be honest, I don't really care all that much as long as existing
> and still very actively used values are not just overloaded.

Absolutely.
