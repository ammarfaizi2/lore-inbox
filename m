Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272128AbTHRPpB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 11:45:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272130AbTHRPpA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 11:45:00 -0400
Received: from [203.145.184.221] ([203.145.184.221]:61192 "EHLO naturesoft.net")
	by vger.kernel.org with ESMTP id S272128AbTHRPo4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 11:44:56 -0400
From: "Krishnakumar. R" <krishnakumar@naturesoft.net>
Reply-To: krishnakumar@naturesoft.net
Organization: Naturesoft
To: trivial@rustcorp.com.au
Subject: [TRIVIAL][PATCH-2.6.0-test3]remove unused variable in drivers/char/isicom.c
Date: Mon, 18 Aug 2003 21:17:50 +0530
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308182117.50908.krishnakumar@naturesoft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch would remove the 'unused variable' 
error in drivers/char/isicom.c.

Regards
KK

=============================================
diffstat:
isicom.c |    1 -
1 files changed, 1 deletion(-)

=============================================
The following is the patch:


--- linux-2.6.0-test3/drivers/char/isicom.orig.c	2003-08-18 21:07:10.000000000 
+0530
+++ linux-2.6.0-test3/drivers/char/isicom.c	2003-08-18 21:07:25.000000000 
+0530
@@ -972,7 +972,6 @@
 	struct isi_port * port;
 	struct isi_board * card;
 	unsigned int line, board;
-	unsigned long flags;
 	int error;
 
 #ifdef ISICOM_DEBUG	

