Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131386AbQLPUts>; Sat, 16 Dec 2000 15:49:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131878AbQLPUti>; Sat, 16 Dec 2000 15:49:38 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:12374
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S131386AbQLPUtd>; Sat, 16 Dec 2000 15:49:33 -0500
Date: Sat, 16 Dec 2000 21:19:00 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, fritz@isdn4linux.de
Subject: [PATCH] makefile patch for drivers/isdn/sc/Makefile (240t13p2)
Message-ID: <20001216211900.B609@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

This patch fixes a trivial makefile problem i drivers/isdn/sc.


--- linux-240-t13-pre2-clean/drivers/isdn/sc/Makefile	Sat Dec 16 20:40:56 2000
+++ linux/drivers/isdn/sc/Makefile	Sat Dec 16 21:14:57 2000
@@ -2,7 +2,7 @@
 
 # The target object and module list name.
 
-O_TARGET	:= sc_drv
+O_TARGET	:= sc_drv.o
 
 # Objects that export symbols.
 

-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

"God prevent we should ever be twenty years without a revolution." 
  -- Thomas Jefferson
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
