Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264993AbUDUGVf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264993AbUDUGVf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 02:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264985AbUDUGIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 02:08:17 -0400
Received: from smtp804.mail.sc5.yahoo.com ([66.163.168.183]:38316 "HELO
	smtp804.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264987AbUDUGFo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 02:05:44 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 7/15] New set of input patches: atkbd trailing whitespace
Date: Wed, 21 Apr 2004 00:56:59 -0500
User-Agent: KMail/1.6.1
Cc: Vojtech Pavlik <vojtech@suse.cz>
References: <200404210049.17139.dtor_core@ameritech.net>
In-Reply-To: <200404210049.17139.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200404210057.01429.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1908, 2004-04-20 22:28:38-05:00, dtor_core@ameritech.net
  Input: fix trailing whitespace in atkbd


 atkbd.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


===================================================================



diff -Nru a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
--- a/drivers/input/keyboard/atkbd.c	Tue Apr 20 23:07:43 2004
+++ b/drivers/input/keyboard/atkbd.c	Tue Apr 20 23:07:43 2004
@@ -814,12 +814,12 @@
 		param[0] = (test_bit(LED_SCROLLL, atkbd->dev.led) ? 1 : 0)
 		         | (test_bit(LED_NUML,    atkbd->dev.led) ? 2 : 0)
  		         | (test_bit(LED_CAPSL,   atkbd->dev.led) ? 4 : 0);
-		
+
 		if (atkbd_probe(atkbd))
 			return -1;
 		if (atkbd->set != atkbd_set_3(atkbd))
 			return -1;
-		
+
 		atkbd_enable(atkbd);
 
 		if (atkbd_command(atkbd, param, ATKBD_CMD_SETLEDS))
