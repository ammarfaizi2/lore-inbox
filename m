Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129192AbQKMFwR>; Mon, 13 Nov 2000 00:52:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129401AbQKMFwH>; Mon, 13 Nov 2000 00:52:07 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:58636 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129192AbQKMFv4>;
	Mon, 13 Nov 2000 00:51:56 -0500
Message-ID: <3A0F815C.1EEDBFFA@mandrakesoft.com>
Date: Mon, 13 Nov 2000 00:51:24 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: initcalls in pre4?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alas...


--- include/linux/init.h        2000/10/30 19:37:38     1.1.1.5
+++ include/linux/init.h        2000/11/13 04:30:02     1.1.1.6
@@ -73,7 +73,7 @@
-#define __init         __attribute__ ((__section__ (".text.init")))
+#define __init         /* __attribute__ ((__section__ (".text.init")))
*/

-- 
Jeff Garzik             |
Building 1024           | The chief enemy of creativity is "good" sense
MandrakeSoft            |          -- Picasso
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
