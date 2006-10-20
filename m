Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992731AbWJTTY3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992731AbWJTTY3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 15:24:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992730AbWJTTY3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 15:24:29 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:62872
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S2992724AbWJTTY1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 15:24:27 -0400
Date: Fri, 20 Oct 2006 12:24:27 -0700 (PDT)
Message-Id: <20061020.122427.55507415.davem@davemloft.net>
To: shemminger@osdl.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] netpoll: rework skb transmit queue
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061020081857.743b5eb7@localhost.localdomain>
References: <20061019171814.281988608@osdl.org>
	<20061020.001530.35664340.davem@davemloft.net>
	<20061020081857.743b5eb7@localhost.localdomain>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Hemminger <shemminger@osdl.org>
Date: Fri, 20 Oct 2006 08:18:57 -0700

> Netdump is not in the tree, so I can't fix it. Also netdump is pretty
> much superseded by kdump.

Unless kdump is %100 ready you can be sure vendors will ship netdump
for a little while longer.  I think gratuitously breaking netdump is
not the best idea.

It's not like netdump is some binary blob you can't get the source
to easily. :-)

