Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751712AbWCJQCS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751712AbWCJQCS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 11:02:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751686AbWCJQCS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 11:02:18 -0500
Received: from mx.pathscale.com ([64.160.42.68]:7377 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751169AbWCJQCR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 11:02:17 -0500
Subject: Re: [openib-general] [PATCH 0 of 20] [RFC] ipath driver - another
	round for review
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: rolandd@cisco.com, gregkh@suse.de, akpm@osdl.org, davem@davemloft.net,
       linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <20060310153559.GA12778@mellanox.co.il>
References: <patchbomb.1141950930@eng-12.pathscale.com>
	 <20060310153559.GA12778@mellanox.co.il>
Content-Type: text/plain
Organization: PathScale, Inc.
Date: Fri, 10 Mar 2006 08:02:16 -0800
Message-Id: <1142006537.29925.13.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-10 at 17:35 +0200, Michael S. Tsirkin wrote:

> Two questions on this
> 1. It is not standard ethernet nor standard IP over Infiniband either, is it?

Correct.

> Is there some documentation on the wire protocol that you use?

No, but the encapsulation is very simple and easy to figure out from
reading the code.

> Is it pathscale specific?

It doesn't have to be.

> 2. Are there practical reasons why you get lower latency and higher
> bandwidth with this than with IPoIB?

The principal reason is that we haven't had time to pay attention to
IPoIB performance yet.  The ipath_ether driver was developed before
IPoIB was usable for any real work.

> If there are optimizations, can they not be added to the standard, common
> IP over IB driver?

That's certainly our intention.  It's simply a matter of finding the
time for it.

	<b

