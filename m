Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275390AbTHITdd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 15:33:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275391AbTHITdd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 15:33:33 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:23750 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S275390AbTHITdc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 15:33:32 -0400
Date: Sat, 9 Aug 2003 21:33:23 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: kwalker@broadcom.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] kill EXPORT_NO_SYMBOLS from OSS swarm_cs4297a.c
Message-ID: <20030809193323.GK16091@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below kills an occurence of the obsolete EXPORT_NO_SYMBOLS
from sound/oss/swarm_cs4297a.c in 2.6.0-test3.   

--- linux-2.6.0-test3-not-full/sound/oss/swarm_cs4297a.c.old	2003-08-09 21:15:13.000000000 +0200
+++ linux-2.6.0-test3-not-full/sound/oss/swarm_cs4297a.c	2003-08-09 21:15:48.000000000 +0200
@@ -2735,8 +2735,6 @@
 
 // --------------------------------------------------------------------- 
 
-EXPORT_NO_SYMBOLS;
-
 MODULE_AUTHOR("Kip Walker, kwalker@broadcom.com");
 MODULE_DESCRIPTION("Cirrus Logic CS4297a Driver for Broadcom SWARM board");
 


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

