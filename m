Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129607AbRATP0i>; Sat, 20 Jan 2001 10:26:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129729AbRATP02>; Sat, 20 Jan 2001 10:26:28 -0500
Received: from mailproxy.de.uu.net ([192.76.144.34]:51075 "EHLO
	mailproxy.de.uu.net") by vger.kernel.org with ESMTP
	id <S129607AbRATP0J>; Sat, 20 Jan 2001 10:26:09 -0500
Date: Sat, 20 Jan 2001 16:26:05 +0100
From: Ulrich Kunitz <gefm21@uumail.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] two comment typos, kernel 2.4.0
Message-ID: <20010120162605.A763@uumail.de>
Mail-Followup-To: Ulrich Kunitz <gefm21@uumail.de>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These patches work for 2.4.0-pre9 too.

--- linux-2.4.0/include/asm-i386/highmem.h	Tue Jan  9 15:00:08 2001
+++ linux/include/asm-i386/highmem.h	Thu Jan 11 17:30:55 2001
@@ -9,7 +9,7 @@
  *
  *
  * Redesigned the x86 32-bit VM architecture to deal with 
- * up to 16 Terrabyte physical memory. With current x86 CPUs
+ * up to 16 Terabyte physical memory. With current x86 CPUs
  * we now support up to 64 Gigabytes physical RAM.
  *
  * Copyright (C) 1999 Ingo Molnar <mingo@redhat.com>
--- linux-2.4.0/include/asm-i386/pgtable-3level.h	Wed Oct 18 23:25:46 2000
+++ linux/include/asm-i386/pgtable-3level.h	Fri Jan 12 13:17:28 2001
@@ -48,7 +48,7 @@
 /* Rules for using set_pte: the pte being assigned *must* be
  * either not present or in a state where the hardware will
  * not attempt to update the pte.  In places where this is
- * not possible, use pte_get_and_clear to obtain the old pte
+ * not possible, use ptep_get_and_clear to obtain the old pte
  * value and then use set_pte to update it.  -ben
  */
 static inline void set_pte(pte_t *ptep, pte_t pte)

-- 
Ulrich Kunitz (gefm21@uumail.de)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
