Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261767AbSJIMcQ>; Wed, 9 Oct 2002 08:32:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261616AbSJIMbl>; Wed, 9 Oct 2002 08:31:41 -0400
Received: from d12lmsgate-4.de.ibm.com ([194.196.100.237]:60063 "EHLO
	d12lmsgate-4.de.ibm.com") by vger.kernel.org with ESMTP
	id <S261767AbSJIM36> convert rfc822-to-8bit; Wed, 9 Oct 2002 08:29:58 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] 2.5.41 s390 (4/8): linker script typo.
Date: Wed, 9 Oct 2002 14:29:44 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200210091429.44020.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Correct typo in the vmlinux.lds.S files.

diff -urN linux-2.5.41/arch/s390/vmlinux.lds.S linux-2.5.41-s390/arch/s390/vmlinux.lds.S
--- linux-2.5.41/arch/s390/vmlinux.lds.S	Mon Oct  7 20:24:03 2002
+++ linux-2.5.41-s390/arch/s390/vmlinux.lds.S	Wed Oct  9 14:01:28 2002
@@ -66,7 +66,7 @@
   __initcall_end = .;
   . = ALIGN(256);
   __per_cpu_start = .;
-  .date.percpu  : { *(.data.percpu) }
+  .data.percpu  : { *(.data.percpu) }
   __per_cpu_end = .;
   . = ALIGN(4096);
   __init_end = .;
diff -urN linux-2.5.41/arch/s390x/vmlinux.lds.S linux-2.5.41-s390/arch/s390x/vmlinux.lds.S
--- linux-2.5.41/arch/s390x/vmlinux.lds.S	Mon Oct  7 20:24:01 2002
+++ linux-2.5.41-s390/arch/s390x/vmlinux.lds.S	Wed Oct  9 14:01:28 2002
@@ -66,7 +66,7 @@
   __initcall_end = .;
   . = ALIGN(256);
   __per_cpu_start = .;
-  .date.percpu  : { *(.data.percpu) }
+  .data.percpu  : { *(.data.percpu) }
   __per_cpu_end = .;
   . = ALIGN(4096);
   __init_end = .;

