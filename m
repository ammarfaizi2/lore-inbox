Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132392AbRD1EOI>; Sat, 28 Apr 2001 00:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132488AbRD1ENw>; Sat, 28 Apr 2001 00:13:52 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:57093 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S132392AbRD1ENl>;
	Sat, 28 Apr 2001 00:13:41 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: [patch] 2.4.4-pre8 mm/Makefile
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 28 Apr 2001 14:13:32 +1000
Message-ID: <20816.988431212@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix for "__VERSIONED_SYMBOL(shmem_file_setup)".  Against 2.4.4-pre8.

Index: 4-pre8.2/mm/Makefile
--- 4-pre8.2/mm/Makefile Fri, 05 Jan 2001 13:42:29 +1100 kaos (linux-2.4/j/19_Makefile 1.1 644)
+++ 4-pre8.2(w)/mm/Makefile Sat, 28 Apr 2001 14:10:59 +1000 kaos (linux-2.4/j/19_Makefile 1.1 644)
@@ -9,6 +9,8 @@
 
 O_TARGET := mm.o
 
+export-objs := shmem.o
+
 obj-y	 := memory.o mmap.o filemap.o mprotect.o mlock.o mremap.o \
 	    vmalloc.o slab.o bootmem.o swap.o vmscan.o page_io.o \
 	    page_alloc.o swap_state.o swapfile.o numa.o oom_kill.o \

