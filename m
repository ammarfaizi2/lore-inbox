Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263056AbTI2LMh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 07:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263057AbTI2LMh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 07:12:37 -0400
Received: from [203.145.184.221] ([203.145.184.221]:13324 "EHLO naturesoft.net")
	by vger.kernel.org with ESMTP id S263056AbTI2LMg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 07:12:36 -0400
From: Shine Mohamed <shinemohamed_j@naturesoft.net>
Organization: Naturesoft
To: trivial@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: [PATCH] Initializedd the module parameters in drivers/net/wireless/arlan-main.c
Date: Mon, 29 Sep 2003 16:44:06 +0530
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309291644.06043.shinemohamed_j@naturesoft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quick patch to  Initialize  the module parameters in 
drivers/net/wireless/arlan-main.c


--- drivers/net/wireless/arlan-main.c.orig      2003-09-29 16:40:33.000000000 
+0530
+++ drivers/net/wireless/arlan-main.c   2003-09-29 16:40:18.000000000 +0530
@@ -33,6 +33,7 @@
 static int retries = 5;
 static int tx_queue_len = 1;
 static int arlan_EEPROM_bad;
+static int probe = 0; /* Initially it is setting to be 'Probing Disabled' */

 #ifdef ARLAN_DEBUGGING


