Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263809AbTLTRH7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 12:07:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263885AbTLTRH7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 12:07:59 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:55758 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S263809AbTLTRH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 12:07:56 -0500
Date: Sat, 20 Dec 2003 09:07:52 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix es7000 compile
Message-ID: <55300000.1071940072@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- 2.6.0/include/asm-i386/mach-es7000/mach_apic.h.old	2003-08-24 07:28:50.000000000 -0700
+++ 2.6.0/include/asm-i386/mach-es7000/mach_apic.h	2003-12-20 08:07:01.000000000 -0800
@@ -39,6 +39,7 @@
 #endif
 
 #define APIC_BROADCAST_ID	(0xff)
+#define NO_IOAPIC_CHECK (0)
 
 static inline unsigned long check_apicid_used(physid_mask_t bitmap, int apicid)
 { 

