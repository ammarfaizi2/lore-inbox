Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268234AbUI2GsL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268234AbUI2GsL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 02:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268247AbUI2GsL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 02:48:11 -0400
Received: from smtp802.mail.sc5.yahoo.com ([66.163.168.181]:35438 "HELO
	smtp802.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S268234AbUI2GsB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 02:48:01 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 1/8] New ALPS signature
Date: Wed, 29 Sep 2004 01:41:46 -0500
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200409290140.53350.dtor_core@ameritech.net>
In-Reply-To: <200409290140.53350.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200409290141.48766.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1947, 2004-09-25 22:36:41-05:00, dtor_core@ameritech.net
  Input: add a new signature for ALPS DualPoint found in
         Dell Inspiron 8500
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 alps.c |    1 +
 1 files changed, 1 insertion(+)


===================================================================



diff -Nru a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
--- a/drivers/input/mouse/alps.c	2004-09-29 01:14:35 -05:00
+++ b/drivers/input/mouse/alps.c	2004-09-29 01:14:35 -05:00
@@ -48,6 +48,7 @@
 	{ { 0x20, 0x02, 0x0e },	ALPS_MODEL_DUALPOINT },
 	{ { 0x22, 0x02, 0x0a },	ALPS_MODEL_DUALPOINT },
 	{ { 0x22, 0x02, 0x14 }, ALPS_MODEL_DUALPOINT },
+	{ { 0x63, 0x03, 0xc8 },	ALPS_MODEL_DUALPOINT },
 };
 
 /*
