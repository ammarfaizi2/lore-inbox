Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265321AbSLXRRo>; Tue, 24 Dec 2002 12:17:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265506AbSLXRRo>; Tue, 24 Dec 2002 12:17:44 -0500
Received: from mailout11.sul.t-online.com ([194.25.134.85]:63671 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S265321AbSLXRRn>; Tue, 24 Dec 2002 12:17:43 -0500
Message-Id: <4.3.2.7.2.20021224182426.00b59100@pop.t-online.de>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Tue, 24 Dec 2002 18:26:25 +0100
To: linux-kernel@vger.kernel.org
From: margitsw@t-online.de (Margit Schubert-While)
Subject: 2.5.53 Activate P4 prefetch
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- linux-2.5.53/include/asm-i386/processor.h   2002-12-24 
06:19:28.000000000 +0100
+++ linux-2.5.53mw0/include/asm-i386/processor.h        2002-12-24 
18:22:16.000000000 +0100
@@ -485,7 +485,7 @@
  #define cpu_relax()    rep_nop()

  /* Prefetch instructions for Pentium III and AMD Athlon */
-#ifdef         CONFIG_MPENTIUMIII
+#if defined(CONFIG_MPENTIUMIII) || defined(CONFIG_MPENTIUM4)

  #define ARCH_HAS_PREFETCH
  extern inline void prefetch(const void *x)


Merry Christmas all.
Margit 

