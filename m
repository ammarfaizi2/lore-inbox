Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263729AbTCUSdu>; Fri, 21 Mar 2003 13:33:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263728AbTCUScs>; Fri, 21 Mar 2003 13:32:48 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:65411
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263710AbTCUSbz>; Fri, 21 Mar 2003 13:31:55 -0500
Date: Fri, 21 Mar 2003 19:47:05 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303211947.h2LJl5ff025965@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: junkfilter sym53c41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/scsi/sym53c416.h linux-2.5.65-ac2/drivers/scsi/sym53c416.h
--- linux-2.5.65/drivers/scsi/sym53c416.h	2003-02-10 18:38:48.000000000 +0000
+++ linux-2.5.65-ac2/drivers/scsi/sym53c416.h	2003-03-06 23:56:54.000000000 +0000
@@ -18,14 +18,6 @@
 #ifndef _SYM53C416_H
 #define _SYM53C416_H
 
-#if !defined(LINUX_VERSION_CODE)
-#include <linux/version.h>
-#endif
-
-#ifndef LinuxVersionCode
-#define LinuxVersionCode(v, p, s) (((v)<<16)+((p)<<8)+(s))
-#endif
-
 #include <linux/types.h>
 
 #define SYM53C416_SCSI_ID 7
