Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932534AbWACWgs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932534AbWACWgs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 17:36:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932533AbWACWgs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 17:36:48 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:7095
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S964781AbWACWgs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 17:36:48 -0500
Date: Tue, 03 Jan 2006 14:36:29 -0800 (PST)
Message-Id: <20060103.143629.73563903.davem@davemloft.net>
To: shemminger@osdl.org
Cc: mikukkon@iki.fi, bridge@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] BRIDGE: Fix faulty check in
 br_stp_recalculate_bridge_id()
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060103104157.1512f5fa@dxpl.pdx.osdl.net>
References: <20051221132527.1ef12bcf@dxpl.pdx.osdl.net>
	<20051221.195107.113618698.davem@davemloft.net>
	<20060103104157.1512f5fa@dxpl.pdx.osdl.net>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Hemminger <shemminger@osdl.org>
Date: Tue, 3 Jan 2006 10:41:57 -0800

> One of the conversions from memcmp to compare_ether_addr is incorrect.
> We need to do relative comparison to determine min MAC address to
> use in bridge id. 
> 
> Signed-off-by: Stephen Hemminger <shemminger@osdl.org>

Applied, thanks.

Is this -stable material?
