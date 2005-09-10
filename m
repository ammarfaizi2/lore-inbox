Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932343AbVIJWnk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932343AbVIJWnk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 18:43:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932361AbVIJWm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 18:42:29 -0400
Received: from styx.suse.cz ([82.119.242.94]:37028 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S932356AbVIJWdw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 18:33:52 -0400
Subject: [PATCH 18/26] sunkbd - extend mapping to handle Type-6 Sun keyboards
In-Reply-To: <11263916532207@midnight.ucw.cz>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Sun, 11 Sep 2005 00:34:13 +0200
Message-Id: <11263916533441@midnight.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@osdl.org, dtor_core@ameritech.net, linux-kernel@vger.kernel.org,
       vojtech@suse.cz
Content-Transfer-Encoding: 7BIT
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [PATCH] Input: sunkbd - extend mapping to handle Type-6 Sun keyboards
From: Vojtech Pavlik <vojtech@suse.cz>
Date: 1125897167 -0500

Map an unmarked key at 'Esc' position to KEY_MACRO

Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

---

 drivers/input/keyboard/sunkbd.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

8d9a9ae3b2941d94bb0023a3aca2ec2bfa83d0c2
diff --git a/drivers/input/keyboard/sunkbd.c b/drivers/input/keyboard/sunkbd.c
--- a/drivers/input/keyboard/sunkbd.c
+++ b/drivers/input/keyboard/sunkbd.c
@@ -44,7 +44,7 @@ MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL");
 
 static unsigned char sunkbd_keycode[128] = {
-	  0,128,114,129,115, 59, 60, 68, 61, 87, 62, 88, 63,100, 64,  0,
+	  0,128,114,129,115, 59, 60, 68, 61, 87, 62, 88, 63,100, 64,112,
 	 65, 66, 67, 56,103,119, 99, 70,105,130,131,108,106,  1,  2,  3,
 	  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 41, 14,110,113, 98, 55,
 	116,132, 83,133,102, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25,

