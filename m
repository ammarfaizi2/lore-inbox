Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264798AbSKRT05>; Mon, 18 Nov 2002 14:26:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264679AbSKRT02>; Mon, 18 Nov 2002 14:26:28 -0500
Received: from d12lmsgate-4.de.ibm.com ([194.196.100.237]:19671 "EHLO
	d12lmsgate-4.de.ibm.com") by vger.kernel.org with ESMTP
	id <S264677AbSKRTYw> convert rfc822-to-8bit; Mon, 18 Nov 2002 14:24:52 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] 2.5.48 s390 (6/16): missing includes.
Date: Mon, 18 Nov 2002 20:19:14 +0100
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200211182019.14251.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urN linux-2.5.48/include/asm-s390/debug.h linux-2.5.48-s390/include/asm-s390/debug.h
--- linux-2.5.48/include/asm-s390/debug.h	Mon Nov 18 05:29:46 2002
+++ linux-2.5.48-s390/include/asm-s390/debug.h	Mon Nov 18 20:11:29 2002
@@ -9,6 +9,8 @@
 #ifndef DEBUG_H
 #define DEBUG_H
 
+#include <linux/string.h>
+
 /* Note:
  * struct __debug_entry must be defined outside of #ifdef __KERNEL__ 
  * in order to allow a user program to analyze the 'raw'-view.
diff -urN linux-2.5.48/include/asm-s390x/debug.h linux-2.5.48-s390/include/asm-s390x/debug.h
--- linux-2.5.48/include/asm-s390x/debug.h	Mon Nov 18 05:29:46 2002
+++ linux-2.5.48-s390/include/asm-s390x/debug.h	Mon Nov 18 20:11:29 2002
@@ -9,6 +9,8 @@
 #ifndef DEBUG_H
 #define DEBUG_H
 
+#include <linux/string.h>
+
 /* Note:
  * struct __debug_entry must be defined outside of #ifdef __KERNEL__ 
  * in order to allow a user program to analyze the 'raw'-view.

