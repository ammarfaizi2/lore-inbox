Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136592AbRAHCVU>; Sun, 7 Jan 2001 21:21:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136581AbRAHCVK>; Sun, 7 Jan 2001 21:21:10 -0500
Received: from lists.indstate.edu ([139.102.15.43]:39594 "EHLO
	online.indstate.edu") by vger.kernel.org with ESMTP
	id <S136533AbRAHCUu>; Sun, 7 Jan 2001 21:20:50 -0500
From: "Rich Baum" <baumr1@coral.indstate.edu>
To: linux-kernel@vger.kernel.org
Date: Sun, 7 Jan 2001 21:20:06 -0500
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: [PATCH] Fix typo in drivers/video/amifb.c in 2.4.0
Reply-to: richbaum@acm.org
Message-ID: <3A58DD86.5998.13C0BD1@localhost>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a comment at the end of an #endif.  This should fix all of 
the warnings about tokens at the end of #endifs.  Please disregard 
the parts of my earlier patch which made changes to comments 
and .S files.  I should have reviewed the patch the script made 
more closely.

diff -urN -X dontdiff linux/drivers/video/amifb.c rb/drivers/video/amifb.c
--- linux/drivers/video/amifb.c	Fri Dec 29 17:07:23 2000
+++ rb/drivers/video/amifb.c	Sun Jan  7 13:33:28 2001
@@ -1534,7 +1534,7 @@
 			}
 			return i;
 		}
-#endif */ DEBUG */
+#endif	/* DEBUG */
 	}
 	return -EINVAL;
 }

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
