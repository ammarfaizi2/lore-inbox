Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964786AbVLNR5F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964786AbVLNR5F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 12:57:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964788AbVLNR5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 12:57:04 -0500
Received: from mail.usfltd.com ([69.222.0.23]:8720 "EHLO usfltd.com")
	by vger.kernel.org with ESMTP id S964773AbVLNR5C convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 12:57:02 -0500
Subject: =?ISO-8859-1?Q?kernel-2=2E6=2E15-rc5-rt2=20-=20compilation=20error=20=91?=
 =?ISO-8859-1?Q?RWSEM=5FACTIVE=5FBIAS=92=20undeclared?=
Date: Wed, 14 Dec 2005 11:57:42 -0600
Message-Id: <200512141157.AA15073854@usfltd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
From: "art" <art@usfltd.com>
Reply-To: <art@usfltd.com>
To: <linux-kernel@vger.kernel.org>
CC: <mingo@elte.hu>
X-Mailer: <IMail v8.05>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


kernel-2.6.15-rc5-rt2 - compilation error ‘RWSEM_ACTIVE_BIAS’ undeclared

gcc version 4.0.2
........
  CC      lib/kref.o
  CC      lib/prio_tree.o
  CC      lib/radix-tree.o
  CC      lib/rbtree.o
  CC      lib/rwsem.o
lib/rwsem.c: In function ‘__rwsem_do_wake’:
lib/rwsem.c:57: warning: implicit declaration of function ‘rwsem_atomic_update’
lib/rwsem.c:57: error: ‘RWSEM_ACTIVE_BIAS’ undeclared (first use in this function)
lib/rwsem.c:57: error: (Each undeclared identifier is reported only once
lib/rwsem.c:57: error: for each function it appears in.)
lib/rwsem.c:59: error: ‘RWSEM_ACTIVE_MASK’ undeclared (first use in this function)
lib/rwsem.c:62: error: ‘struct rw_semaphore’ has no member named ‘wait_list’
lib/rwsem.c:85: error: ‘struct rw_semaphore’ has no member named ‘wait_list’
lib/rwsem.c:99: error: ‘struct rw_semaphore’ has no member named ‘wait_list’
lib/rwsem.c:108: error: ‘RWSEM_WAITING_BIAS’ undeclared (first use in this function)
lib/rwsem.c:113: warning: implicit declaration of function ‘rwsem_atomic_add’
lib/rwsem.c:115: error: ‘struct rw_semaphore’ has no member named ‘wait_list’
lib/rwsem.c:126: error: ‘struct rw_semaphore’ has no member named ‘wait_list’
lib/rwsem.c:127: error: ‘struct rw_semaphore’ has no member named ‘wait_list’
lib/rwsem.c: In function ‘rwsem_down_failed_common’:
lib/rwsem.c:153: error: ‘struct rw_semaphore’ has no member named ‘wait_lock’
lib/rwsem.c:153: warning: type defaults to ‘int’ in declaration of ‘type name’
lib/rwsem.c:153: error: ‘struct rw_semaphore’ has no member named ‘wait_lock’
lib/rwsem.c:153: error: ‘struct rw_semaphore’ has no member named ‘wait_lock’
lib/rwsem.c:153: warning: type defaults to ‘int’ in declaration of ‘type name’
lib/rwsem.c:153: error: ‘struct rw_semaphore’ has no member named ‘wait_lock’
lib/rwsem.c:157: error: ‘struct rw_semaphore’ has no member named ‘wait_list’
lib/rwsem.c:163: error: ‘RWSEM_ACTIVE_MASK’ undeclared (first use in this function)
lib/rwsem.c:166: error: ‘struct rw_semaphore’ has no member named ‘wait_lock’
lib/rwsem.c:166: warning: type defaults to ‘int’ in declaration of ‘type name’
lib/rwsem.c:166: error: ‘struct rw_semaphore’ has no member named ‘wait_lock’
lib/rwsem.c:166: error: ‘struct rw_semaphore’ has no member named ‘wait_lock’
lib/rwsem.c:166: warning: type defaults to ‘int’ in declaration of ‘type name’
lib/rwsem.c:166: error: ‘struct rw_semaphore’ has no member named ‘wait_lock’
lib/rwsem.c: In function ‘rwsem_down_read_failed’:
lib/rwsem.c:193: error: ‘RWSEM_WAITING_BIAS’ undeclared (first use in this function)
lib/rwsem.c:193: error: ‘RWSEM_ACTIVE_BIAS’ undeclared (first use in this function)
lib/rwsem.c: In function ‘rwsem_down_write_failed’:
lib/rwsem.c:210: error: ‘RWSEM_ACTIVE_BIAS’ undeclared (first use in this function)
lib/rwsem.c: In function ‘rwsem_wake’:
lib/rwsem.c:226: error: ‘struct rw_semaphore’ has no member named ‘wait_lock’
lib/rwsem.c:226: warning: type defaults to ‘int’ in declaration of ‘type name’
lib/rwsem.c:226: error: ‘struct rw_semaphore’ has no member named ‘wait_lock’
lib/rwsem.c:226: error: ‘struct rw_semaphore’ has no member named ‘wait_lock’
lib/rwsem.c:226: warning: type defaults to ‘int’ in declaration of ‘type name’
lib/rwsem.c:226: error: ‘struct rw_semaphore’ has no member named ‘wait_lock’
lib/rwsem.c:229: error: ‘struct rw_semaphore’ has no member named ‘wait_list’
lib/rwsem.c:232: error: ‘struct rw_semaphore’ has no member named ‘wait_lock’
lib/rwsem.c:232: warning: type defaults to ‘int’ in declaration of ‘type name’
lib/rwsem.c:232: error: ‘struct rw_semaphore’ has no member named ‘wait_lock’
lib/rwsem.c:232: error: ‘struct rw_semaphore’ has no member named ‘wait_lock’
lib/rwsem.c:232: warning: type defaults to ‘int’ in declaration of ‘type name’
lib/rwsem.c:232: error: ‘struct rw_semaphore’ has no member named ‘wait_lock’
lib/rwsem.c: In function ‘rwsem_downgrade_wake’:
lib/rwsem.c:250: error: ‘struct rw_semaphore’ has no member named ‘wait_lock’
lib/rwsem.c:250: warning: type defaults to ‘int’ in declaration of ‘type name’
lib/rwsem.c:250: error: ‘struct rw_semaphore’ has no member named ‘wait_lock’
lib/rwsem.c:250: error: ‘struct rw_semaphore’ has no member named ‘wait_lock’
lib/rwsem.c:250: warning: type defaults to ‘int’ in declaration of ‘type name’
lib/rwsem.c:250: error: ‘struct rw_semaphore’ has no member named ‘wait_lock’
lib/rwsem.c:253: error: ‘struct rw_semaphore’ has no member named ‘wait_list’
lib/rwsem.c:256: error: ‘struct rw_semaphore’ has no member named ‘wait_lock’
lib/rwsem.c:256: warning: type defaults to ‘int’ in declaration of ‘type name’
lib/rwsem.c:256: error: ‘struct rw_semaphore’ has no member named ‘wait_lock’
lib/rwsem.c:256: error: ‘struct rw_semaphore’ has no member named ‘wait_lock’
lib/rwsem.c:256: warning: type defaults to ‘int’ in declaration of ‘type name’
lib/rwsem.c:256: error: ‘struct rw_semaphore’ has no member named ‘wait_lock’
make[1]: *** [lib/rwsem.o] Error 1
make: *** [lib] Error 2

xboom

