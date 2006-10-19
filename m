Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946256AbWJSRTS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946256AbWJSRTS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 13:19:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946258AbWJSRTS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 13:19:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:59846 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1946256AbWJSRTQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 13:19:16 -0400
Message-Id: <20061019171541.062261760@osdl.org>
User-Agent: quilt/0.45-1
Date: Thu, 19 Oct 2006 10:15:41 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] netpoll/netconsole fixes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The netpoll transmit skb management is a mess, it has two
paths and it's on Txq. These patches try and clean this up.

--

