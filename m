Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264652AbSJOW3r>; Tue, 15 Oct 2002 18:29:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264622AbSJOW33>; Tue, 15 Oct 2002 18:29:29 -0400
Received: from serenity.mcc.ac.uk ([130.88.200.93]:38154 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S264830AbSJOW1c>; Tue, 15 Oct 2002 18:27:32 -0400
Date: Tue, 15 Oct 2002 23:33:26 +0100
From: John Levon <levon@movementarian.org>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] [5/7] oprofile - MSR defines
Message-ID: <20021015223326.GE41906@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add the MSR defines oprofile uses


diff -Naur -X dontdiff linux-linus/include/asm-i386/msr.h linux/include/asm-i386/msr.h
--- linux-linus/include/asm-i386/msr.h	Sun Oct 13 19:51:03 2002
+++ linux/include/asm-i386/msr.h	Tue Oct 15 21:45:52 2002
@@ -99,7 +99,13 @@
 #define MSR_K6_PFIR			0xC0000088
 
 #define MSR_K7_EVNTSEL0			0xC0010000
+#define MSR_K7_EVNTSEL1			0xC0010001
+#define MSR_K7_EVNTSEL2			0xC0010002
+#define MSR_K7_EVNTSEL3			0xC0010003
 #define MSR_K7_PERFCTR0			0xC0010004
+#define MSR_K7_PERFCTR1			0xC0010005
+#define MSR_K7_PERFCTR2			0xC0010006
+#define MSR_K7_PERFCTR3			0xC0010007
 #define MSR_K7_HWCR			0xC0010015
 #define MSR_K7_FID_VID_CTL		0xC0010041
 #define MSR_K7_VID_STATUS		0xC0010042
