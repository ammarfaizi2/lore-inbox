Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272161AbTHRQAN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 12:00:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272162AbTHRQAN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 12:00:13 -0400
Received: from [203.145.184.221] ([203.145.184.221]:17929 "EHLO naturesoft.net")
	by vger.kernel.org with ESMTP id S272161AbTHRQAJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 12:00:09 -0400
From: "Krishnakumar. R" <krishnakumar@naturesoft.net>
Reply-To: krishnakumar@naturesoft.net
Organization: Naturesoft
To: trivial@rustcorp.com.au
Subject: [TRIVIAL][PATCH-2.6.0-test3]removes the unused variable in drivers/char/esp.c
Date: Mon, 18 Aug 2003 21:33:12 +0530
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308182133.12378.krishnakumar@naturesoft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch would remove the 'unused variable' 
error in drivers/char/esp.c

Regards
KK

=============================================
diffstat output:

esp.c |    2 +-
1 files changed, 1 insertion(+), 1 deletion(-)

=============================================
The following is the patch:



--- linux-2.6.0-test3/drivers/char/esp.orig.c	2003-08-18 21:19:20.000000000 +0530
+++ linux-2.6.0-test3/drivers/char/esp.c	2003-08-18 21:20:01.000000000 +0530
@@ -2632,7 +2632,7 @@
 static void __exit espserial_exit(void) 
 {
 	unsigned long flags;
-	int e1, e2;
+	int e1;
 	unsigned int region_start, region_end;
 	struct esp_struct *temp_async;
 	struct esp_pio_buffer *pio_buf;




