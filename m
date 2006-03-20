Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932176AbWCTL1L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932176AbWCTL1L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 06:27:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932208AbWCTL1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 06:27:10 -0500
Received: from [194.90.237.34] ([194.90.237.34]:25733 "EHLO mtlexch01.mtl.com")
	by vger.kernel.org with ESMTP id S932176AbWCTL1J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 06:27:09 -0500
Date: Mon, 20 Mar 2006 13:27:53 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: "David S. Miller" <davem@davemloft.net>
Cc: rick.jones2@hp.com, netdev@vger.kernel.org, rdreier@cisco.com,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: TSO and IPoIB performance degradation
Message-ID: <20060320112753.GX29929@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20060320090629.GA11352@mellanox.co.il> <20060320.015500.72136710.davem@davemloft.net> <20060320102234.GV29929@mellanox.co.il> <20060320.023704.70907203.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060320.023704.70907203.davem@davemloft.net>
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 20 Mar 2006 11:29:49.0046 (UTC) FILETIME=[98ECF960:01C64C11]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting David S. Miller <davem@davemloft.net>:
> I disagree with Linux changing it's behavior.  It would be great to
> turn off congestion control completely over local gigabit networks,
> but that isn't determinable in any way, so we don't do that.

Interesting. Would it make sense to make it another tunable knob in
/proc, sysfs or sysctl then?

-- 
Michael S. Tsirkin
Staff Engineer, Mellanox Technologies
