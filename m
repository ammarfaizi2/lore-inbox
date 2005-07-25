Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261856AbVGYGTk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261856AbVGYGTk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 02:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261714AbVGYF53
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 01:57:29 -0400
Received: from smtp109.sbc.mail.re2.yahoo.com ([68.142.229.96]:55165 "HELO
	smtp109.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S261712AbVGYFzo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 01:55:44 -0400
Message-Id: <20050725054532.211189000.dtor_core@ameritech.net>
References: <20050725053449.483098000.dtor_core@ameritech.net>
Date: Mon, 25 Jul 2005 00:35:01 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: [patch 12/24] i8042 - add Alienware Sentia to NOMUX blacklist
Content-Disposition: inline; filename=i8042-nomux-alienware-sentia.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Input: i8042 - add Alienware Sentia to NOMUX blacklist.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/serio/i8042-x86ia64io.h |    7 +++++++
 1 files changed, 7 insertions(+)

Index: work/drivers/input/serio/i8042-x86ia64io.h
===================================================================
--- work.orig/drivers/input/serio/i8042-x86ia64io.h
+++ work/drivers/input/serio/i8042-x86ia64io.h
@@ -137,6 +137,13 @@ static struct dmi_system_id __initdata i
 			DMI_MATCH(DMI_PRODUCT_NAME, "Satellite P10"),
 		},
 	},
+	{
+		.ident = "Alienware Sentia",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ALIENWARE"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Sentia"),
+		},
+	},
 	{ }
 };
 

