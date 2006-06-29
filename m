Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933029AbWF2WFv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933029AbWF2WFv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 18:05:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933017AbWF2WFJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 18:05:09 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:49888
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932829AbWF2WFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 18:05:03 -0400
Date: Thu, 29 Jun 2006 15:04:17 -0700 (PDT)
Message-Id: <20060629.150417.78710870.davem@davemloft.net>
To: bos@pathscale.com
Cc: akpm@osdl.org, rdreier@cisco.com, mst@mellanox.co.il,
       openib-general@openib.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [PATCH 38 of 39] IB/ipath - More changes to support InfiniPath
 on PowerPC 970 systems
From: David Miller <davem@davemloft.net>
In-Reply-To: <1151618499.10886.26.camel@chalcedony.pathscale.com>
References: <c22b6c244d5db77f7b1d.1151617289@eng-12.pathscale.com>
	<20060629.145319.71091846.davem@davemloft.net>
	<1151618499.10886.26.camel@chalcedony.pathscale.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bryan O'Sullivan <bos@pathscale.com>
Date: Thu, 29 Jun 2006 15:01:39 -0700

> The support for write combining in the kernel is not in a state where
> that makes any sense at the moment.

Please fix the generic code if it doesn't provide the facility
you need at the moment.  Don't shoe horn it into your driver
just to make up for that.
