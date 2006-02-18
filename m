Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750709AbWBRCEk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbWBRCEk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 21:04:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750712AbWBRCEL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 21:04:11 -0500
Received: from digitalimplant.org ([64.62.235.95]:452 "HELO digitalimplant.org")
	by vger.kernel.org with SMTP id S1750709AbWBRCDo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 21:03:44 -0500
Date: Fri, 17 Feb 2006 18:03:36 -0800 (PST)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: greg@kroah.com, "" <torvalds@osdl.org>, "" <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, "" <linux-pm@osdl.org>
Subject: [PATCH 2/5] [pm] Add state field to pm_message_t (to hold actual
 state device is in)
Message-ID: <Pine.LNX.4.50.0602171757360.30811-100000@monsoon.he.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Patrick Mochel <mochel@linux.intel.com>

---

 include/linux/pm.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

applies-to: 1ac50ba99ca37c65bdf3643c4056c246e401c18a
63b8e7f0896ce93834ac60c15df954b1e6d45e56
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
