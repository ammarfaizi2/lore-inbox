Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261903AbREYVLp>; Fri, 25 May 2001 17:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261907AbREYVLf>; Fri, 25 May 2001 17:11:35 -0400
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:53287
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S261903AbREYVL3>; Fri, 25 May 2001 17:11:29 -0400
Date: Fri, 25 May 2001 23:11:22 +0200
From: Rasmus Andersen <rasmus@jaquet.dk>
To: vandrove@vc.cvut.cz
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] __init -> __initdata in drivers/video/matrox/matroxfb_base.c (244ac16)
Message-ID: <20010525231122.N851@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

The following patch changes an __init to __initdata. Applies against
2.4.4-ac11.


--- linux-244-ac11-clean/drivers/video/matrox/matroxfb_base.c	Sat May 19 20:58:43 2001
+++ linux-244-ac11/drivers/video/matrox/matroxfb_base.c	Sun May 20 23:55:24 2001
@@ -2483,7 +2483,7 @@
 	return 0;
 }
 
-static int __init initialized = 0;
+static int __initdata initialized = 0;
 
 int __init matroxfb_init(void)
 {

-- 
Regards,
        Rasmus(rasmus@jaquet.dk)
