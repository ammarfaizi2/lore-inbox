Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965149AbVJUVUu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965149AbVJUVUu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 17:20:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751180AbVJUVUu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 17:20:50 -0400
Received: from smtpa1.aruba.it ([62.149.128.206]:58335 "HELO smtpa1.aruba.it")
	by vger.kernel.org with SMTP id S1751150AbVJUVUt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 17:20:49 -0400
From: Mirco Macrelli <pigaz@pigaz.org>
Reply-To: pigaz@pigaz.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Add Logitech MX3100 to logips2pp.c, 2.6.14-rc5-git1
Date: Fri, 21 Oct 2005 23:20:48 +0200
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_wuVWDRxQUAmPPnq"
Message-Id: <200510212320.48896.pigaz@pigaz.org>
X-Spam-Rating: smtp1.aruba.it 1.6.2 0/1000/N
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_wuVWDRxQUAmPPnq
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This simple patch adds the reciver of the Logitech MX3100 to the list of those 
presents in the file logips2pp.c

ciao ;)
-- 
Mirco Macrelli

--Boundary-00=_wuVWDRxQUAmPPnq
Content-Type: text/x-diff;
  charset="us-ascii";
  name="add_logitech_mx3100_to_logips2pp.c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="add_logitech_mx3100_to_logips2pp.c.diff"

diff -Naur linux-2.6.14-rc5-git1/drivers/input/mouse/logips2pp.c linux-2.6.14-rc5-git1.new/drivers/input/mouse/logips2pp.c
--- linux-2.6.14-rc5-git1/drivers/input/mouse/logips2pp.c	2005-10-21 13:12:49.386661000 +0200
+++ linux-2.6.14-rc5-git1.new/drivers/input/mouse/logips2pp.c	2005-10-21 13:21:23.778808500 +0200
@@ -217,6 +217,9 @@
 		{ 61,	PS2PP_KIND_MX,					/* MX700 */
 				PS2PP_WHEEL | PS2PP_SIDE_BTN | PS2PP_TASK_BTN |
 				PS2PP_EXTRA_BTN | PS2PP_NAV_BTN },
+		{ 66,	PS2PP_KIND_MX,					/* MX3100 reciver */
+				PS2PP_WHEEL | PS2PP_SIDE_BTN | PS2PP_TASK_BTN |
+				PS2PP_EXTRA_BTN | PS2PP_NAV_BTN | PS2PP_HWHEEL },
 		{ 73,	0,			PS2PP_SIDE_BTN },
 		{ 75,	PS2PP_KIND_WHEEL,	PS2PP_WHEEL },
 		{ 76,	PS2PP_KIND_WHEEL,	PS2PP_WHEEL },
--Boundary-00=_wuVWDRxQUAmPPnq--
