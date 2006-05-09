Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750946AbWEISyw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750946AbWEISyw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 14:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750955AbWEISyw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 14:54:52 -0400
Received: from [194.90.237.34] ([194.90.237.34]:3397 "EHLO mtlexch01.mtl.com")
	by vger.kernel.org with ESMTP id S1750946AbWEISyv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 14:54:51 -0400
Date: Tue, 9 May 2006 21:55:33 +0300
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Shirley Ma <xma@us.ibm.com>
Cc: Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org, Marcus Eder <MEDER@de.ibm.com>,
       openib-general@openib.org, openib-general-bounces@openib.org,
       Christoph Raisch <RAISCH@de.ibm.com>, Roland Dreier <rdreier@cisco.com>
Subject: Re: Re: [PATCH 07/16] ehca: interrupt handling routines
Message-ID: <20060509185533.GG22825@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20060509184451.GF22825@mellanox.co.il> <OF9332FF11.38007290-ON87257169.00673F71-88257169.006C7F6E@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF9332FF11.38007290-ON87257169.00673F71-88257169.006C7F6E@us.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 09 May 2006 18:58:33.0578 (UTC) FILETIME=[91DA04A0:01C6739A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. Shirley Ma <xma@us.ibm.com>:
> No, CPU utilization wasn't reduced. When you use single CQ, NAPI polls on both RX/TX.

I think NAPI's point is to reduce the interrupt rate.
Wouldn't this reduce CPU load?

> netperf, iperf, mpstat, netpipe, oprofiling, what's your suggestion?

netperf has -C which gives CPU load, which is handy.
Running vmstat in another window also works reasoably well.

-- 
MST
