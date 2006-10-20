Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751024AbWJTTw0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751024AbWJTTw0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 15:52:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751104AbWJTTw0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 15:52:26 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:2715
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750934AbWJTTwZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 15:52:25 -0400
Date: Fri, 20 Oct 2006 12:52:26 -0700 (PDT)
Message-Id: <20061020.125226.59656580.davem@davemloft.net>
To: shemminger@osdl.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] netpoll: rework skb transmit queue
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061020122527.56292b56@dxpl.pdx.osdl.net>
References: <20061020081857.743b5eb7@localhost.localdomain>
	<20061020.122427.55507415.davem@davemloft.net>
	<20061020122527.56292b56@dxpl.pdx.osdl.net>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Hemminger <shemminger@osdl.org>
Date: Fri, 20 Oct 2006 12:25:27 -0700

> Sorry, but why should we treat out-of-tree vendor code any
> differently than out-of-tree other code.

I think what netdump was trying to do, provide a way to
requeue instead of fully drop the SKB, is quite reasonable.
Don't you think?
