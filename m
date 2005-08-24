Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751179AbVHXQ6V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179AbVHXQ6V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 12:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbVHXQ6V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 12:58:21 -0400
Received: from az33egw02.freescale.net ([192.88.158.103]:5020 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S1751179AbVHXQ6U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 12:58:20 -0400
Date: Wed, 24 Aug 2005 11:58:03 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@nylon.am.freescale.net
To: linux-kernel@vger.kernel.org
cc: Andrew Morton <akpm@osdl.org>, schwidefsky@de.ibm.com,
       linux-390@vm.marist.edu, linux390@de.ibm.com
Subject: [PATCH 10/15] s390: remove use of asm/segment.h
In-Reply-To: <Pine.LNX.4.61.0508241139100.23956@nylon.am.freescale.net>
Message-ID: <Pine.LNX.4.61.0508241157010.23956@nylon.am.freescale.net>
References: <Pine.LNX.4.61.0508241139100.23956@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Removed S390 architecture specific users of asm/segment.h and
asm-s390/segment.h itself

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit 6ee9ded730a875d63e42add1c3094eca7d5a6cdf
tree 5d340a409fd593e5f5d7e71467a038fd90def51b
parent 8f20e153d5d5c3efd95835e814fae7b3ccbfcd08
author Kumar K. Gala <kumar.gala@freescale.com> Wed, 24 Aug 2005 11:01:20 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Wed, 24 Aug 2005 11:01:20 -0500

 arch/s390/kernel/ptrace.c  |    1 -
 include/asm-s390/segment.h |    4 ----
 2 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/arch/s390/kernel/ptrace.c b/arch/s390/kernel/ptrace.c
--- a/arch/s390/kernel/ptrace.c
+++ b/arch/s390/kernel/ptrace.c
@@ -34,7 +34,6 @@
 #include <linux/audit.h>
 #include <linux/signal.h>
 
-#include <asm/segment.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
diff --git a/include/asm-s390/segment.h b/include/asm-s390/segment.h
deleted file mode 100644
--- a/include/asm-s390/segment.h
+++ /dev/null
@@ -1,4 +0,0 @@
-#ifndef _ASM_SEGMENT_H
-#define _ASM_SEGMENT_H
-
-#endif
