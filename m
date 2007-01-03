Return-Path: <linux-kernel-owner+w=401wt.eu-S1750829AbXACPEZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750829AbXACPEZ (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 10:04:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750832AbXACPEZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 10:04:25 -0500
Received: from dev.mellanox.co.il ([194.90.237.44]:36498 "EHLO
	dev.mellanox.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750829AbXACPEY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 10:04:24 -0500
Date: Wed, 3 Jan 2007 17:02:30 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Steve Wise <swise@opengridcomputing.com>
Cc: Roland Dreier <rdreier@cisco.com>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH  v4 01/13] Linux RDMA Core Changes
Message-ID: <20070103150230.GP6019@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <1167836172.4187.9.camel@stevo-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1167836172.4187.9.camel@stevo-desktop>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've run this code with mthca and didn't notice any performance
> degradation, but I wasn't specifically measuring cq_poll overhead in a
> tight loop...

We were speaking about ib_req_notify_cq here, actually, not cq poll.
So what was tested?

-- 
MST
