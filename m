Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267276AbSLEKrU>; Thu, 5 Dec 2002 05:47:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267280AbSLEKqR>; Thu, 5 Dec 2002 05:46:17 -0500
Received: from holomorphy.com ([66.224.33.161]:43657 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267278AbSLEKqE>;
	Thu, 5 Dec 2002 05:46:04 -0500
Date: Thu, 05 Dec 2002 02:52:59 -0800
From: wli@holomorphy.com
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, kernel-janitor-discuss@lists.sourceforge.net,
       rmk@arm.linux.org.uk, jgarzik@pobox.com, miura@da-cha.org,
       alan@lxorguk.ukuu.org.uk, viro@math.psu.edu, pavel@ucw.cz
Subject: [warnings] [4/8] remove unused cr0 in cyrix.c
Message-ID: <0212050252.IbRbEbGcFabaXbkavbedza0aAb2aGaxd20143@holomorphy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <0212050252.uaQcrdGaYaObsdBcOaucHaoa5dScKaTa20143@holomorphy.com>
X-Mailer: patchbomb 0.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove cr0; the variable is unused. Hiroshi, this is yours to ack.

===== arch/i386/kernel/cpu/cyrix.c 1.6 vs edited =====
--- 1.6/arch/i386/kernel/cpu/cyrix.c	Thu Nov 14 18:02:21 2002
+++ edited/arch/i386/kernel/cpu/cyrix.c	Thu Dec  5 01:10:10 2002
@@ -170,7 +170,6 @@
 {
 	unsigned long flags;
 	u8 ccr3, ccr4;
-	unsigned long cr0;
 	local_irq_save(flags);
 	
 	ccr3 = getCx86(CX86_CCR3);
