Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261738AbTCGUDt>; Fri, 7 Mar 2003 15:03:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261731AbTCGUDt>; Fri, 7 Mar 2003 15:03:49 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:29378 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S261738AbTCGUDs>; Fri, 7 Mar 2003 15:03:48 -0500
Date: Fri, 7 Mar 2003 21:14:17 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] 2.5.64-ac3: fix a typo in ide-default.c
Message-ID: <20030307201417.GA19615@fs.tum.de>
References: <200303071756.h27HuiY01551@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303071756.h27HuiY01551@devserv.devel.redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch fixes a typo in ide-default.c that causes a compile 
error:

--- linux-2.5.64-ac3/drivers/ide/ide-default.c.old	2003-03-07 21:11:35.000000000 +0100
+++ linux-2.5.64-ac3/drivers/ide/ide-default.c	2003-03-07 21:12:17.000000000 +0100
@@ -51,7 +51,7 @@
 	.name		=	"ide-default",
 	.version	=	IDEDEFAULT_VERSION,
 	.attach		=	idedefault_attach,
-	.supports_dma	=	1.
+	.supports_dma	=	1,
 	.drives		=	LIST_HEAD_INIT(idedefault_driver.drives)
 };
 


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

