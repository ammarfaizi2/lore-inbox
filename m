Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293461AbSCKCCZ>; Sun, 10 Mar 2002 21:02:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293462AbSCKCCQ>; Sun, 10 Mar 2002 21:02:16 -0500
Received: from pizda.ninka.net ([216.101.162.242]:37305 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S293461AbSCKCCL>;
	Sun, 10 Mar 2002 21:02:11 -0500
Date: Sun, 10 Mar 2002 17:58:58 -0800 (PST)
Message-Id: <20020310.175858.21402963.davem@redhat.com>
To: beezly@beezly.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: Sun GEM card looses TX on x86 32bit PCI
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020310.173935.74819813.davem@redhat.com>
In-Reply-To: <1015792619.1801.4.camel@monkey>
	<20020310.173935.74819813.davem@redhat.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I inadvertantly left out this part of the patch, sorry.

--- drivers/net/sungem.h.~1~	Wed Jan 23 07:40:02 2002
+++ drivers/net/sungem.h	Sun Mar 10 17:22:07 2002
@@ -986,6 +986,8 @@
 	int			mii_phy_addr;
 	int			gigabit_capable;
 
+	u32			mac_rx_cfg;
+
 	/* Autoneg & PHY control */
 	int			link_cntl;
 	int			link_advertise;
