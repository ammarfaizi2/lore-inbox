Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261740AbSKCLf7>; Sun, 3 Nov 2002 06:35:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261742AbSKCLf7>; Sun, 3 Nov 2002 06:35:59 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:38414 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S261740AbSKCLf7>; Sun, 3 Nov 2002 06:35:59 -0500
Message-Id: <200211031137.gA3BbZp27860@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: linux-kernel@vger.kernel.org
Subject: [PATCH] undefine too generic macro name after use
Date: Sun, 3 Nov 2002 14:29:33 -0200
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --recursive linux-2.5.40org/include/asm-i386/bitops.h linux-2.5.40/include/asm-i386/bitops.h
--- linux-2.5.40org/include/asm-i386/bitops.h	Tue Oct  1 05:07:10 2002
+++ linux-2.5.40/include/asm-i386/bitops.h	Wed Oct  9 09:24:31 2002
@@ -260,6 +260,8 @@
  constant_test_bit((nr),(addr)) : \
  variable_test_bit((nr),(addr)))

+#undef ADDR
+
 /**
  * find_first_zero_bit - find the first zero bit in a memory region
  * @addr: The address to start the search at
