Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265603AbSK1Oxm>; Thu, 28 Nov 2002 09:53:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265608AbSK1Oxl>; Thu, 28 Nov 2002 09:53:41 -0500
Received: from tolkor.SGI.COM ([198.149.18.6]:11685 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S265603AbSK1OxD>;
	Thu, 28 Nov 2002 09:53:03 -0500
Date: Thu, 28 Nov 2002 17:14:23 -0500
From: Christoph Hellwig <hch@sgi.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] remove unused variable in arch/i386/kernel/cpu/cyrix.c
Message-ID: <20021128171423.C6592@sgi.com>
Mail-Followup-To: Christoph Hellwig <hch@sgi.com>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- 1.6/arch/i386/kernel/cpu/cyrix.c	Fri Nov 15 03:02:21 2002
+++ edited/arch/i386/kernel/cpu/cyrix.c	Thu Nov 28 14:22:16 2002
@@ -170,7 +170,7 @@
 {
 	unsigned long flags;
 	u8 ccr3, ccr4;
-	unsigned long cr0;
+
 	local_irq_save(flags);
 	
 	ccr3 = getCx86(CX86_CCR3);
