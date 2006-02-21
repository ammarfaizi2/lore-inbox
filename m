Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161245AbWBUAzq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161245AbWBUAzq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 19:55:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161247AbWBUAzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 19:55:46 -0500
Received: from digitalimplant.org ([64.62.235.95]:9918 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S1161245AbWBUAzo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 19:55:44 -0500
Date: Mon, 20 Feb 2006 16:55:37 -0800 (PST)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: greg@kroah.com, "" <akpm@osdl.org>, "" <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, "" <linux-pm@osdl.org>
Subject: [PATCH 1/4] [pm] Add state filed to pm_message_t (to hold actual
 state device is in).
Message-ID: <Pine.LNX.4.50.0602201652430.21145-100000@monsoon.he.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Patrick Mochel <mochel@linux.intel.com>

---

 include/linux/pm.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

applies-to: 55ce8c6305fc70b1b544ce7365abd6054e9b5f61
7af37561812f4599841ade4abee067b808b40054
diff --git a/include/linux/pm.h b/include/linux/pm.h
index 5be87ba..a7324ea 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -140,6 +140,7 @@ struct device;

 typedef struct pm_message {
 	int event;
+	u32 state;
 } pm_message_t;

 /*
---
0.99.9.GIT
