Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932518AbWEXAWM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932518AbWEXAWM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 20:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932517AbWEXAWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 20:22:12 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:7657
	"EHLO sunset.sfo1.dsl.speakeasy.net") by vger.kernel.org with ESMTP
	id S932508AbWEXAWK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 20:22:10 -0400
Date: Tue, 23 May 2006 17:22:10 -0700 (PDT)
Message-Id: <20060523.172210.78710967.davem@davemloft.net>
To: christopher.leech@intel.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 0/9] I/OAT repost
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060524001653.19403.31396.stgit@gitlost.site>
References: <20060524001653.19403.31396.stgit@gitlost.site>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Leech <christopher.leech@intel.com>
Subject: [PATCH 0/9] I/OAT repost
Date: Tue, 23 May 2006 17:16:53 -0700

> This is a repost of the I/OAT patches, the only changes from last time
> are refreshing the patches and removing an unused macro that was causing
> the vger spam filters to drop patch 2/9.
> 
> This patch series is the a full release of the Intel(R) I/O
> Acceleration Technology (I/OAT) for Linux.  It includes an in kernel API
> for offloading memory copies to hardware, a driver for the I/OAT DMA memcpy
> engine, and changes to the TCP stack to offload copies of received
> networking data to application space.

I'm going to apply this into a net-2.6.18 GIT tree, do some build
and sanity checking, then ask Andrew to pull it into -mm for testing.

Thanks guys.
