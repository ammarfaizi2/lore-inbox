Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262500AbSKTVHo>; Wed, 20 Nov 2002 16:07:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262580AbSKTVHo>; Wed, 20 Nov 2002 16:07:44 -0500
Received: from [192.58.209.91] ([192.58.209.91]:3485 "HELO handhelds.org")
	by vger.kernel.org with SMTP id <S262500AbSKTVHm>;
	Wed, 20 Nov 2002 16:07:42 -0500
From: George France <france@handhelds.org>
To: linux-kernel@vger.kernel.org
Subject: [Patch] 2.5.48 Trivial to ../asm-alpha/suspend.h  
Date: Wed, 20 Nov 2002 16:14:33 -0500
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
Cc: Richard Henderson <rth@twiddle.net>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>
MIME-Version: 1.0
Message-Id: <02112016143302.13910@shadowfax.middleearth>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix compilation failure.

Best Regards,


--George

--- linux/include/asm-alpha/suspend.h.orig      Wed Dec 31 19:00:00 1969
+++ linux/include/asm-alpha/suspend.h   Wed Nov 20 03:55:57 2002
@@ -0,0 +1,4 @@
+#ifdef _ASMALPHA_SUSPEND_H
+#define _ASMALPHA_SUSPEND_H
+ 
+#endif
