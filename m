Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264782AbUHCA5o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264782AbUHCA5o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 20:57:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264767AbUHCA5o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 20:57:44 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:46486 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S264782AbUHCA4s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 20:56:48 -0400
Date: Tue, 3 Aug 2004 01:55:36 +0100
From: Dave Jones <davej@redhat.com>
To: linux.nics@intel.com
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: ixgb boolean typo ?
Message-ID: <20040803005536.GA12571@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, linux.nics@intel.com,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is this perhaps what was meant to be here ?

		Dave

--- 1/drivers/net/ixgb/ixgb_main.c~	2004-08-03 01:18:00.000000000 +0100
+++ 2/drivers/net/ixgb/ixgb_main.c	2004-08-03 01:53:46.653695768 +0100
@@ -1615,7 +1615,7 @@
 	}
 #else
 	for (i = 0; i < IXGB_MAX_INTR; i++)
-		if (!ixgb_clean_rx_irq(adapter) & !ixgb_clean_tx_irq(adapter))
+		if (!ixgb_clean_rx_irq(adapter) && !ixgb_clean_tx_irq(adapter))
 			break;
 	/* if RAIDC:EN == 1 and ICR:RXDMT0 == 1, we need to
 	 * set IMS:RXDMT0 to 1 to restart the RBD timer (POLL)
