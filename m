Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317497AbSGTUVN>; Sat, 20 Jul 2002 16:21:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317494AbSGTUTx>; Sat, 20 Jul 2002 16:19:53 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:44788 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S317497AbSGTUTk>; Sat, 20 Jul 2002 16:19:40 -0400
Subject: [PATCH] export serio_interrupt
From: Robert Love <rml@tech9.net>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 20 Jul 2002 13:22:44 -0700
Message-Id: <1027196564.1086.778.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Other input drivers need serio_interrupt exported...

Patch is against 2.5.27, please apply.

	Robert Love

diff -urN linux-2.5.27/drivers/input/serio/serio.c linux/drivers/input/serio/serio.c
--- linux-2.5.27/drivers/input/serio/serio.c	Sat Jul 20 12:11:05 2002
+++ linux/drivers/input/serio/serio.c	Sat Jul 20 13:04:43 2002
@@ -49,6 +49,7 @@
 EXPORT_SYMBOL(serio_open);
 EXPORT_SYMBOL(serio_close);
 EXPORT_SYMBOL(serio_rescan);
+EXPORT_SYMBOL(serio_interrupt);
 
 static struct serio *serio_list;
 static struct serio_dev *serio_dev;



