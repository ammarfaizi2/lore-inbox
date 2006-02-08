Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030487AbWBHDTM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030487AbWBHDTM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 22:19:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030486AbWBHDTL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 22:19:11 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:63616 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030485AbWBHDTH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 22:19:07 -0500
To: torvalds@osdl.org
Subject: [PATCH 15/29] dvb NULL noise removal
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1F6frH-0006Cy-34@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 08 Feb 2006 03:19:07 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Date: 1138791770 -0500

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 drivers/media/dvb/dvb-usb/dtt200u.c |    4 ++--
 drivers/media/dvb/dvb-usb/vp7045.c  |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

dad08dfc48529e3f907c2680f8b34f1fe2d75880
diff --git a/drivers/media/dvb/dvb-usb/dtt200u.c b/drivers/media/dvb/dvb-usb/dtt200u.c
index 130ea7f..12ebaf8 100644
--- a/drivers/media/dvb/dvb-usb/dtt200u.c
+++ b/drivers/media/dvb/dvb-usb/dtt200u.c
@@ -151,7 +151,7 @@ static struct dvb_usb_properties dtt200u
 		  .cold_ids = { &dtt200u_usb_table[0], NULL },
 		  .warm_ids = { &dtt200u_usb_table[1], NULL },
 		},
-		{ 0 },
+		{ NULL },
 	}
 };
 
@@ -192,7 +192,7 @@ static struct dvb_usb_properties wt220u_
 		  .cold_ids = { &dtt200u_usb_table[2], NULL },
 		  .warm_ids = { &dtt200u_usb_table[3], NULL },
 		},
-		{ 0 },
+		{ NULL },
 	}
 };
 
diff --git a/drivers/media/dvb/dvb-usb/vp7045.c b/drivers/media/dvb/dvb-usb/vp7045.c
index 0282049..3835235 100644
--- a/drivers/media/dvb/dvb-usb/vp7045.c
+++ b/drivers/media/dvb/dvb-usb/vp7045.c
@@ -247,7 +247,7 @@ static struct dvb_usb_properties vp7045_
 		  .cold_ids = { &vp7045_usb_table[2], NULL },
 		  .warm_ids = { &vp7045_usb_table[3], NULL },
 		},
-		{ 0 },
+		{ NULL },
 	}
 };
 
-- 
0.99.9.GIT

