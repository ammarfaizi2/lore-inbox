Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315539AbSFYQDP>; Tue, 25 Jun 2002 12:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315540AbSFYQDO>; Tue, 25 Jun 2002 12:03:14 -0400
Received: from d12lmsgate.de.ibm.com ([195.212.91.199]:4852 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id <S315539AbSFYQDO> convert rfc822-to-8bit; Tue, 25 Jun 2002 12:03:14 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.24: auto_fs.h typo.
Date: Tue, 25 Jun 2002 17:59:34 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200206251759.34690.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,
my last patch for include/linux/auto_fs.h contained a typo that removed the
trailing underscores from __x86_64__.

blue skies,
  Martin.

diff -urN linux-2.5.24/include/linux/auto_fs.h linux-2.5.24-s390/include/linux/auto_fs.h
--- linux-2.5.24/include/linux/auto_fs.h	Fri Jun 21 00:53:40 2002
+++ linux-2.5.24-s390/include/linux/auto_fs.h	Fri Jun 21 14:46:59 2002
@@ -45,7 +45,7 @@
  * If so, 32-bit user-space code should be backwards compatible.
  */
 
-#if defined(__sparc__) || defined(__mips__) || defined(__x86_64) \
+#if defined(__sparc__) || defined(__mips__) || defined(__x86_64__) \
  || defined(__powerpc__) || defined(__s390__)
 typedef unsigned int autofs_wqt_t;
 #else

