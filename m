Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264590AbTIDDce (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 23:32:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264605AbTIDDav
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 23:30:51 -0400
Received: from dp.samba.org ([66.70.73.150]:18880 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264609AbTIDDaT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 23:30:19 -0400
From: Rusty Trivial Russell <trivial@rustcorp.com.au>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [TRIVIAL] Documentation_vm_hugetlbfs.txt
Date: Thu, 04 Sep 2003 13:20:27 +1000
Message-Id: <20030904033017.D77DA2C018@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From:  Maciej Soltysiak <solt@dns.toxicfilms.tv>

  Hi Rusty,
  
  here's a patch to change the hugetlbfs examples actually being possible to
  compile. errno is being used while it's not included.
  
  Regards,
  Maciej
  

--- trivial-2.6.0-test4-bk5/Documentation/vm/hugetlbpage.txt.orig	2003-09-04 13:01:50.000000000 +1000
+++ trivial-2.6.0-test4-bk5/Documentation/vm/hugetlbpage.txt	2003-09-04 13:01:50.000000000 +1000
@@ -107,6 +107,7 @@
 #include <sys/shm.h>
 #include <sys/types.h>
 #include <sys/mman.h>
+#include <errno.h>
 
 extern int errno;
 #define SHM_HUGETLB 04000
@@ -167,6 +168,7 @@
 #include <stdio.h>
 #include <sys/mman.h>
 #include <fcntl.h>
+#include <errno.h>
 
 #define FILE_NAME "/mnt/hugepagefile"
 #define LENGTH (256*1024*1024)
-- 
  What is this? http://www.kernel.org/pub/linux/kernel/people/rusty/trivial/
  Don't blame me: the Monkey is driving
  File: Maciej Soltysiak <solt@dns.toxicfilms.tv>: [TRIVIAL][2.6] Documentation_vm_hugetlbfs.txt
