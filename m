Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030561AbWAGTJX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030561AbWAGTJX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 14:09:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030564AbWAGTIy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 14:08:54 -0500
Received: from smtp112.sbc.mail.re2.yahoo.com ([68.142.229.93]:34937 "HELO
	smtp112.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1030561AbWAGTIY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 14:08:24 -0500
Message-Id: <20060107172102.222056000.dtor_core@ameritech.net>
References: <20060107171559.593824000.dtor_core@ameritech.net>
Date: Sat, 07 Jan 2006 12:16:22 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 23/24] i8042: Add OQO Zepto to noloop dmi table
Content-Disposition: inline; filename=i8042-OQO-Zepto-noloop-dmi.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Collins <bcollins@ubuntu.com>

Input: i8042 - add OQO Zepto to noloop dmi table.

Signed-off-by: Ben Collins <bcollins@ubuntu.com>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/serio/i8042-x86ia64io.h |    8 ++++++++
 1 files changed, 8 insertions(+)

Index: work/drivers/input/serio/i8042-x86ia64io.h
===================================================================
--- work.orig/drivers/input/serio/i8042-x86ia64io.h
+++ work/drivers/input/serio/i8042-x86ia64io.h
@@ -84,6 +84,14 @@ static struct dmi_system_id __initdata i
 			DMI_MATCH(DMI_PRODUCT_VERSION, "DL760"),
 		},
 	},
+	{
+		.ident = "OQO Model 01",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "OQO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "ZEPTO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "00"),
+		},
+	},
 	{ }
 };
 

