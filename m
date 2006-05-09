Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750899AbWEISoL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750899AbWEISoL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 14:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751049AbWEISoL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 14:44:11 -0400
Received: from [194.90.237.34] ([194.90.237.34]:2882 "EHLO mtlexch01.mtl.com")
	by vger.kernel.org with ESMTP id S1750899AbWEISoK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 14:44:10 -0400
Date: Tue, 9 May 2006 21:44:52 +0300
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Shirley Ma <xma@us.ibm.com>
Cc: Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org, Marcus Eder <MEDER@de.ibm.com>,
       openib-general@openib.org, openib-general-bounces@openib.org,
       Christoph Raisch <RAISCH@de.ibm.com>, Roland Dreier <rdreier@cisco.com>
Subject: Re: [openib-general] Re: [PATCH 07/16] ehca: interrupt handling routines
Message-ID: <20060509184451.GF22825@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20060509164919.GC5063@mellanox.co.il> <OF22D08323.20D303C1-ON87257169.0063C980-88257169.006A41AB@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF22D08323.20D303C1-ON87257169.0063C980-88257169.006A41AB@us.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 09 May 2006 18:47:51.0734 (UTC) FILETIME=[13486560:01C67399]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. Shirley Ma <xma@us.ibm.com>:
> According to some results from different resouces, NAPI only gives 3%-10% performance improvement on single CQ.

When you say performance you mean bandwidth.
But I think it should improve the CPU utilization on RX side significantly.
If it does, that an important metric as well.

> I am trying a simple NAPI patch on splitting CQ now to see how much performance there.

What are you using for a benchmark?

-- 
MST
