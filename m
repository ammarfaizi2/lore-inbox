Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262955AbTI2LEo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 07:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262965AbTI2LEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 07:04:44 -0400
Received: from [203.145.184.221] ([203.145.184.221]:65035 "EHLO naturesoft.net")
	by vger.kernel.org with ESMTP id S262955AbTI2LEn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 07:04:43 -0400
From: Shine Mohamed <shinemohamed_j@naturesoft.net>
Organization: Naturesoft
To: trivial@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: [TRIVIAL][PATCH] Removed unused symbol from drivers/char/esp.c
Date: Mon, 29 Sep 2003 16:36:06 +0530
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309291636.06040.shinemohamed_j@naturesoft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A quick patch to remove unused symbol from drivers/char/esp.c

--- drivers/char/esp.c.orig     2003-09-29 14:27:46.000000000 +0530
+++ drivers/char/esp.c  2003-09-29 14:27:59.000000000 +0530
@@ -2612,7 +2612,7 @@
 static void __exit espserial_exit(void)
 {
        unsigned long flags;
-       int e1, e2;
+       int e1;
        unsigned int region_start, region_end;
        struct esp_struct *temp_async;
        struct esp_pio_buffer *pio_buf;

