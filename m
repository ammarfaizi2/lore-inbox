Return-Path: <linux-kernel-owner+w=401wt.eu-S1750840AbXACPGG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750840AbXACPGG (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 10:06:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbXACPGG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 10:06:06 -0500
Received: from rrcs-24-153-217-226.sw.biz.rr.com ([24.153.217.226]:56910 "EHLO
	smtp.opengridcomputing.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750838AbXACPGF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 10:06:05 -0500
Subject: Re: [PATCH  v4 01/13] Linux RDMA Core Changes
From: Steve Wise <swise@opengridcomputing.com>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: Roland Dreier <rdreier@cisco.com>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <20070103150230.GP6019@mellanox.co.il>
References: <1167836172.4187.9.camel@stevo-desktop>
	 <20070103150230.GP6019@mellanox.co.il>
Content-Type: text/plain
Date: Wed, 03 Jan 2007 09:06:02 -0600
Message-Id: <1167836762.4187.15.camel@stevo-desktop>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2007-01-03 at 17:02 +0200, Michael S. Tsirkin wrote:
> > I've run this code with mthca and didn't notice any performance
> > degradation, but I wasn't specifically measuring cq_poll overhead in a
> > tight loop...
> 
> We were speaking about ib_req_notify_cq here, actually, not cq poll.
> So what was tested?
> 

Sorry, I meant req_notify.  I didn't specifically measure the cost of
req_notify before and after this change.

I've been running the user mode perftest programs mainly.  



