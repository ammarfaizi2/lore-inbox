Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161025AbWAGTdT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161025AbWAGTdT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 14:33:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161023AbWAGTcy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 14:32:54 -0500
Received: from smtp106.sbc.mail.re2.yahoo.com ([68.142.229.99]:52863 "HELO
	smtp106.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1161021AbWAGTcq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 14:32:46 -0500
Message-Id: <20060107172100.785251000.dtor_core@ameritech.net>
References: <20060107171559.593824000.dtor_core@ameritech.net>
Date: Sat, 07 Jan 2006 12:16:10 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 11/24] lifebook: add DMI signature of Fujitsu Lifebook B142
Content-Disposition: inline; filename=lifebook-add-b142-signature.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniele Gozzi <daniele.gozzi@gmail.com>

Input: lifebook - add DMI signature of Fujitsu Lifebook B142

This DMI data was found in Fujitsu LifeBook B142 (Product S/N
FPC01003B, italian keyboard); re: bugzilla #5335

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/mouse/lifebook.c |    7 +++++++
 1 files changed, 7 insertions(+)

Index: work/drivers/input/mouse/lifebook.c
===================================================================
--- work.orig/drivers/input/mouse/lifebook.c
+++ work/drivers/input/mouse/lifebook.c
@@ -27,6 +27,13 @@ static struct dmi_system_id lifebook_dmi
                        DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK B Series"),
                },
        },
+       {
+               .ident = "Lifebook B142",
+               .matches = {
+                       DMI_MATCH(DMI_PRODUCT_NAME, "LifeBook B142"),
+               },
+
+       },
        { }
 };
 

