Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263190AbUJ2B5g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263190AbUJ2B5g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 21:57:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263195AbUJ2BzE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 21:55:04 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:21510 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263191AbUJ2ASo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 20:18:44 -0400
Date: Fri, 29 Oct 2004 02:18:09 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Dag Brattli <dagb@cs.uit.no>, Jean Tourrilhes <jt@hpl.hp.com>
Cc: irda-users@lists.sourceforge.net, davem@davemloft.net, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] irda/qos.c: remove an unused function
Message-ID: <20041029001809.GJ29142@stusta.de>
References: <20041028222238.GP3207@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041028222238.GP3207@stusta.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ this time without the problems due to a digital signature... ]

The patch below removes an unused function from net/irda/qos.c


diffstat output:
 net/irda/qos.c |   11 -----------
 1 files changed, 11 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm1-full/net/irda/qos.c.old	2004-10-28 23:51:59.000000000 +0200
+++ linux-2.6.10-rc1-mm1-full/net/irda/qos.c	2004-10-28 23:52:08.000000000 +0200
@@ -211,17 +211,6 @@
 	return index;
 }
 
-static inline __u32 byte_value(__u8 byte, __u32 *array) 
-{
-	int index;
-
-	ASSERT(array != NULL, return -1;);
-
-	index = msb_index(byte);
-
-	return index_value(index, array);
-}
-
 /*
  * Function value_lower_bits (value, array)
  *
