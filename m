Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932343AbWDKH7F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932343AbWDKH7F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 03:59:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932342AbWDKH7E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 03:59:04 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:12165
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932338AbWDKH7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 03:59:02 -0400
Date: Tue, 11 Apr 2006 00:58:58 -0700 (PDT)
Message-Id: <20060411.005858.49205474.davem@davemloft.net>
To: vda@ilport.com.ua
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [PATCH 3/3] deinline a few large functions in vlan code - v3
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <200604111047.36941.vda@ilport.com.ua>
References: <200604111043.13605.vda@ilport.com.ua>
	<200604111044.05847.vda@ilport.com.ua>
	<200604111047.36941.vda@ilport.com.ua>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Denis Vlasenko <vda@ilport.com.ua>
Date: Tue, 11 Apr 2006 10:47:36 +0300

> On Tuesday 11 April 2006 10:44, Denis Vlasenko wrote:
> On Tuesday 11 April 2006 10:43, Denis Vlasenko wrote:
> > These patches exclude VLAN code from netdevice drivers
> > and from bonding module, and even remove vlan-related
> > members of struct netdevice if VLAN is not configured.
> > 
> > Compile tested on allyesconfig kernel with CONFIG_8021Q=y,m,n.
> 
> This one add #ifdefs around vlan_rx_* members of struct netdevice,
> and moves large inlines out-of-line.

This is not very nice, there is no way I'm applying these patches.

I think the current situation is far better than the large pile of
ifdefs these patches are adding to the tree.

Let's just leave things the way they are ok?
