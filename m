Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290671AbSAYNkG>; Fri, 25 Jan 2002 08:40:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290678AbSAYNj4>; Fri, 25 Jan 2002 08:39:56 -0500
Received: from serenity.mcc.ac.uk ([130.88.200.93]:17421 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S290671AbSAYNjt>; Fri, 25 Jan 2002 08:39:49 -0500
Date: Fri, 25 Jan 2002 13:42:57 +0000
From: John Levon <movement@marcelothewonderpenguin.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] head.S
Message-ID: <20020125134257.GA37629@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Bendik Singers - Afrotid
X-Toppers: N/A
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


007 has a license to kill, not a right.

enjoy,
john


--- arch/i386/kernel/head.S.old	Fri Jan 25 13:36:09 2002
+++ arch/i386/kernel/head.S	Fri Jan 25 13:36:49 2002
@@ -82,8 +82,8 @@
  * Initialize page tables
  */
 	movl $pg0-__PAGE_OFFSET,%edi /* initialize page tables */
-	movl $007,%eax		/* "007" doesn't mean with right to kill, but
-				   PRESENT+RW+USER */
+	movl $007,%eax		/* "007" doesn't mean with license to kill, 
+				 * but PRESENT+RW+USER */
 2:	stosl
 	add $0x1000,%eax
 	cmp $empty_zero_page-__PAGE_OFFSET,%edi
