Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130315AbQLLXeh>; Tue, 12 Dec 2000 18:34:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130329AbQLLXe2>; Tue, 12 Dec 2000 18:34:28 -0500
Received: from web.sajt.cz ([212.71.160.9]:49157 "EHLO web.sajt.cz")
	by vger.kernel.org with ESMTP id <S130315AbQLLXeK>;
	Tue, 12 Dec 2000 18:34:10 -0500
Date: Wed, 13 Dec 2000 00:01:07 +0100 (CET)
From: Pavel Rabel <pavel@web.sajt.cz>
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] timer.h obsolete comments
Message-ID: <Pine.LNX.4.21.0012122343180.26198-100000@web.sajt.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

Are the old static timers gone completely?
Some comments are either obsolete or out of place.

Pavel Rabel

--- include/linux/timer.h.old	Tue Dec 12 22:07:35 2000
+++ include/linux/timer.h	Tue Dec 12 22:09:28 2000
@@ -5,13 +5,9 @@
 #include <linux/list.h>
 
 /*
- * This is completely separate from the above, and is the
+ * Old-style "hardcoded" timers are gone, this is the
  * "new and improved" way of handling timers more dynamically.
  * Hopefully efficient and general enough for most things.
- *
- * The "hardcoded" timers above are still useful for well-
- * defined problems, but the timer-list is probably better
- * when you need multiple outstanding timers or similar.
  *
  * The "data" field is in case you want to use the same
  * timeout function for several timeouts. You can use this

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
