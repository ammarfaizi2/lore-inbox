Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316900AbSGHNwi>; Mon, 8 Jul 2002 09:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316906AbSGHNwh>; Mon, 8 Jul 2002 09:52:37 -0400
Received: from d12lmsgate.de.ibm.com ([195.212.91.199]:62390 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id <S316900AbSGHNwh> convert rfc822-to-8bit; Mon, 8 Jul 2002 09:52:37 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] 2.5.25: auto_fs.h typo
Date: Mon, 8 Jul 2002 15:45:45 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200207081545.45427.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,
before the __x86_64 folks start hitting me, again the patch for auto_fs.h:

* readd accidentally removed underscores of __x86_64__

blue skies,
  Martin.

diff -urN linux-2.5.25/include/linux/auto_fs.h linux-2.5.25-s390/include/linux/auto_fs.h
--- linux-2.5.25/include/linux/auto_fs.h	Sat Jul  6 01:42:00 2002
+++ linux-2.5.25-s390/include/linux/auto_fs.h	Fri Jun 21 14:46:59 2002
@@ -45,7 +45,7 @@
  * If so, 32-bit user-space code should be backwards compatible.
  */
 
-#if defined(__sparc__) || defined(__mips__) || defined(__x86_64) \
+#if defined(__sparc__) || defined(__mips__) || defined(__x86_64__) \
  || defined(__powerpc__) || defined(__s390__)
 typedef unsigned int autofs_wqt_t;
 #else

