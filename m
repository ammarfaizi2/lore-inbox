Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264444AbUHGWD4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264444AbUHGWD4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 18:03:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264479AbUHGWDz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 18:03:55 -0400
Received: from delta.ds3.agh.edu.pl ([149.156.124.3]:44555 "EHLO
	pluto.ds14.agh.edu.pl") by vger.kernel.org with ESMTP
	id S264444AbUHGWDu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 18:03:50 -0400
From: =?iso-8859-2?q?Pawe=B3_Sikora?= <pluto@pld-linux.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cmpxchg(8b) fixes.
Date: Sun, 8 Aug 2004 00:03:44 +0200
User-Agent: KMail/1.6.2
References: <200408072031.44477.pluto@pld-linux.org>
In-Reply-To: <200408072031.44477.pluto@pld-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_AHVFBYoEhyfbrto"
Message-Id: <200408080003.44410.pluto@pld-linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_AHVFBYoEhyfbrto
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

and this one too...

-- 
/* Copyright (C) 2003, SCO, Inc. This is valuable Intellectual Property. */

                           #define say(x) lie(x)

--Boundary-00=_AHVFBYoEhyfbrto
Content-Type: text/x-diff;
  charset="iso-8859-2";
  name="0.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="0.diff"

--- linux-2.6.8-rc3/include/asm-i386/fixmap.h.orig	2004-08-03 23:26:45.000000000 +0200
+++ linux-2.6.8-rc3/include/asm-i386/fixmap.h	2004-08-08 00:01:52.532139504 +0200
@@ -15,7 +15,9 @@
 
 #include <linux/config.h>
 #include <linux/kernel.h>
+#ifdef CONFIG_ACPI_BOOT
 #include <asm/acpi.h>
+#endif
 #include <asm/apicdef.h>
 #include <asm/page.h>
 #ifdef CONFIG_HIGHMEM

--Boundary-00=_AHVFBYoEhyfbrto--
