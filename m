Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264208AbUDGX5o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 19:57:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261298AbUDGX5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 19:57:39 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:56294 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261355AbUDGXzP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 19:55:15 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] obsolete asm/hdreg.h [1/5]
Date: Thu, 8 Apr 2004 00:22:04 +0200
User-Agent: KMail/1.5.3
Cc: linux-ide@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404080022.04693.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[IDE] asm-arm26/hdreg.h: use unsigned long for ide_ioreg_t

 linux-2.6.5-root/include/asm-arm26/hdreg.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN include/asm-arm26/hdreg.h~arm26_ide_ioreg_t include/asm-arm26/hdreg.h
--- linux-2.6.5/include/asm-arm26/hdreg.h~arm26_ide_ioreg_t	2004-04-06 00:23:04.039180016 +0200
+++ linux-2.6.5-root/include/asm-arm26/hdreg.h	2004-04-06 00:23:16.078349784 +0200
@@ -9,7 +9,7 @@
 #ifndef __ASMARM_HDREG_H
 #define __ASMARM_HDREG_H
 
-typedef unsigned int ide_ioreg_t;
+typedef unsigned long ide_ioreg_t;
 
 #endif /* __ASMARM_HDREG_H */
 

_

