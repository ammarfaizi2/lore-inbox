Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751137AbWCJQFB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137AbWCJQFB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 11:05:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbWCJQFB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 11:05:01 -0500
Received: from mx.pathscale.com ([64.160.42.68]:22737 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751137AbWCJQFB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 11:05:01 -0500
Subject: Re: [PATCH 9 of 20] ipath - char devices for diagnostics and
	lightweight subnet management
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: Roland Dreier <rdreier@cisco.com>, akpm@osdl.org, gregkh@suse.de,
       linux-kernel@vger.kernel.org, openib-general@openib.org,
       davem@davemloft.net
In-Reply-To: <20060310155434.GB12778@mellanox.co.il>
References: <eac2ad3017b5f160d24c.1141922822@localhost.localdomain>
	 <adalkvjfbo0.fsf@cisco.com>
	 <1141947581.10693.45.camel@serpentine.pathscale.com>
	 <20060310155434.GB12778@mellanox.co.il>
Content-Type: text/plain
Organization: PathScale, Inc.
Date: Fri, 10 Mar 2006 08:05:00 -0800
Message-Id: <1142006700.29925.17.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-10 at 17:54 +0200, Michael S. Tsirkin wrote:

> >       * OpenSM wasn't usable when we wrote our SMA.  We have customers
> >         using ours now, so we have to support it.
> 
> Presumably you mean the ib_mad SMA - OpenSM is not an SMA.

Yes, I already mentioned that I got my terms swapped in another message.

> So what do customers care which SMA
> implementation is used, as long as it formats the management packets
> correctly?

Many, perhaps most right now, of our customers don't have a full IB
stack loaded.  That's why we have this small userspace SMA.

	<b

