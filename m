Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129063AbRBFQgp>; Tue, 6 Feb 2001 11:36:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129235AbRBFQgg>; Tue, 6 Feb 2001 11:36:36 -0500
Received: from musse.tninet.se ([195.100.94.12]:60133 "HELO musse.tninet.se")
	by vger.kernel.org with SMTP id <S129063AbRBFQga>;
	Tue, 6 Feb 2001 11:36:30 -0500
Date: Tue, 6 Feb 2001 14:55:30 +0100
From: André Dahlqvist <anedah-9@sm.luth.se>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix typo in linux/include/asm-ppc/semaphore.h
Message-ID: <20010206145530.A3245@sm.luth.se>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
X-Unexpected-Header: The Spanish Inquisition
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Below is a patch for a typo that I found while doing some grepping.
The patch is against 2.4.1-ac3.

--- linux-2.4.1-ac3/include/asm-ppc/semaphore.h~	Tue Feb  6 14:50:41 2001
+++ linux-2.4.1-ac3/include/asm-ppc/semaphore.h	Tue Feb  6 14:50:45 2001
@@ -132,7 +132,7 @@
 
 #define DECLARE_RWSEM(name) __DECLARE_RWSEM_GENERIC(name, 0, 0)
 #define DECLARE_RWSEM_READ_LOCKED(name) __DECLARE_RWSEM_GENERIC(name, 1, 0)
-#define DECLAER_RWSEM_WRITE_LOCKED(name) __DECLARE_RWSEM_GENERIC(name, 0, 1)
+#define DECLARE_RWSEM_WRITE_LOCKED(name) __DECLARE_RWSEM_GENERIC(name, 0, 1)
 
 extern inline void init_rwsem(struct rw_semaphore *sem)
 {
-- 

André Dahlqvist <anedah-9@sm.luth.se>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
