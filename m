Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265037AbSLLSIl>; Thu, 12 Dec 2002 13:08:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265065AbSLLSIB>; Thu, 12 Dec 2002 13:08:01 -0500
Received: from d06lmsgate-6.uk.ibm.com ([194.196.100.252]:27106 "EHLO
	d06lmsgate-6.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S264975AbSLLSHJ> convert rfc822-to-8bit; Thu, 12 Dec 2002 13:07:09 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390 (8/8): export sys_wait4.
Date: Thu, 12 Dec 2002 19:10:20 +0100
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200212121910.20852.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add sys_wait4 to the list of exported functions.

diffstat:
 s390/kernel/s390_ksyms.c  |    1 +
 s390x/kernel/s390_ksyms.c |    1 +
 2 files changed, 2 insertions(+)

diff -urN linux-2.5.51/arch/s390/kernel/s390_ksyms.c linux-2.5.51-s390/arch/s390/kernel/s390_ksyms.c
--- linux-2.5.51/arch/s390/kernel/s390_ksyms.c	Tue Dec 10 03:46:11 2002
+++ linux-2.5.51-s390/arch/s390/kernel/s390_ksyms.c	Thu Dec 12 18:03:43 2002
@@ -59,3 +59,4 @@
 EXPORT_SYMBOL(console_mode);
 EXPORT_SYMBOL(console_device);
 EXPORT_SYMBOL_NOVERS(do_call_softirq);
+EXPORT_SYMBOL(sys_wait4);
diff -urN linux-2.5.51/arch/s390x/kernel/s390_ksyms.c linux-2.5.51-s390/arch/s390x/kernel/s390_ksyms.c
--- linux-2.5.51/arch/s390x/kernel/s390_ksyms.c	Tue Dec 10 03:46:16 2002
+++ linux-2.5.51-s390/arch/s390x/kernel/s390_ksyms.c	Thu Dec 12 18:03:43 2002
@@ -83,3 +83,4 @@
 EXPORT_SYMBOL(console_mode);
 EXPORT_SYMBOL(console_device);
 EXPORT_SYMBOL_NOVERS(do_call_softirq);
+EXPORT_SYMBOL(sys_wait4);

