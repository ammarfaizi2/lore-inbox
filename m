Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261180AbUK0H0u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbUK0H0u (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 02:26:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261167AbUK0HAC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 02:00:02 -0500
Received: from mail3.speakeasy.net ([216.254.0.203]:50921 "EHLO
	mail3.speakeasy.net") by vger.kernel.org with ESMTP id S261182AbUKZTCf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:02:35 -0500
Date: Thu, 25 Nov 2004 13:15:47 -0800 (PST)
From: vlobanov <vlobanov@speakeasy.net>
To: torvalds@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH TRIVIAL] i386/Kconfig: correct minor typo
Message-ID: <Pine.LNX.4.58.0411251311390.29092@shell4.speakeasy.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch to correct a minor typo in arch/i386/Kconfig. Diffed against
linux-2.6.10-rc2.

=========================================================
diff -Nru a/arch/i386/Kconfig b/arch/i386/Kconfig
--- a/arch/i386/Kconfig 2004-11-14 21:56:13.000000000 -0800
+++ b/arch/i386/Kconfig 2004-11-25 13:08:07.000000000 -0800
@@ -866,7 +866,7 @@
        depends on EXPERIMENTAL
        default n
        help
-       Compile the kernel with -mregparm=3. This uses an different ABI
+       Compile the kernel with -mregparm=3. This uses a different ABI
        and passes the first three arguments of a function call in registers.
        This will probably break binary only modules.

=========================================================

Signed-off-by: Vadim Lobanov <vlobanov@speakeasy.net>

