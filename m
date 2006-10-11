Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030784AbWJKDp0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030784AbWJKDp0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 23:45:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030783AbWJKDp0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 23:45:26 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:14027
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1030781AbWJKDpZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 23:45:25 -0400
Date: Tue, 10 Oct 2006 20:45:28 -0700 (PDT)
Message-Id: <20061010.204528.90823856.davem@davemloft.net>
To: rdreier@cisco.com
Cc: mst@mellanox.co.il, shemminger@osdl.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, openib-general@openib.org, rolandd@cisco.com
Subject: Re: Dropping NETIF_F_SG since no checksum feature.
From: David Miller <davem@davemloft.net>
In-Reply-To: <adak637bjs3.fsf@cisco.com>
References: <adar6xfbk6d.fsf@cisco.com>
	<20061010.203624.91207079.davem@davemloft.net>
	<adak637bjs3.fsf@cisco.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 10 Oct 2006 20:42:20 -0700

> On the other hand I'm not sure how useful such a netdevice would be --
> will non-sendfile() paths generate big packets even if the MTU is 64KB?

non-sendfile() paths will generate big packets just fine, as long
as the application is providing that much data.
