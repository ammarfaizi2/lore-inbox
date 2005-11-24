Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030549AbVKXAuu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030549AbVKXAuu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 19:50:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030550AbVKXAuu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 19:50:50 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:28331
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1030548AbVKXAut (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 19:50:49 -0500
Date: Wed, 23 Nov 2005 16:50:37 -0800 (PST)
Message-Id: <20051123.165037.130468768.davem@davemloft.net>
To: bcrl@kvack.org
Cc: ak@suse.de, jgarzik@pobox.com, andrew.grover@intel.com,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       john.ronciak@intel.com, christopher.leech@intel.com
Subject: Re: [RFC] [PATCH 0/3] ioat: DMA engine support
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20051124001700.GC14246@kvack.org>
References: <4384E7F2.2030508@pobox.com>
	<20051123223007.GA5921@wotan.suse.de>
	<20051124001700.GC14246@kvack.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin LaHaise <bcrl@kvack.org>
Date: Wed, 23 Nov 2005 19:17:01 -0500

> Similarly, we should make sure that network drivers prefetch the
> header at the earliest possible time, too.

Several do already, thankfully :)  At last check skge, tg3, chelsio,
and ixgb do the necessary prefetching on receive.
