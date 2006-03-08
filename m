Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751977AbWCHBYr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751977AbWCHBYr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 20:24:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752000AbWCHBYr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 20:24:47 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:58285
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751977AbWCHBYq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 20:24:46 -0500
Date: Tue, 07 Mar 2006 17:23:36 -0800 (PST)
Message-Id: <20060307.172336.107863253.davem@davemloft.net>
To: rdreier@cisco.com
Cc: mlleinin@hpcn.ca.sandia.gov, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, openib-general@openib.org,
       shemminger@osdl.org
Subject: Re: [openib-general] Re: TSO and IPoIB performance degradation
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <adaacc1raz9.fsf@cisco.com>
References: <1141776697.6119.938.camel@localhost>
	<20060307.161808.60227862.davem@davemloft.net>
	<adaacc1raz9.fsf@cisco.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 07 Mar 2006 17:17:30 -0800

> The reason TSO comes up is that reverting the patch described below
> helps (or helped at some point at least) IPoIB throughput quite a bit.

I wish you had started the thread by mentioning this specific
patch, we wasted an enormous amount of precious developer time
speculating and asking for arbitrary tests to be run in order
to narrow down the problem, yet you knew the specific change
that introduced the performance regression already...

This is a good example of how not to report a bug.
