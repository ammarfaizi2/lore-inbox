Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264346AbUH0Mj5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264346AbUH0Mj5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 08:39:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264396AbUH0Mj4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 08:39:56 -0400
Received: from mail.broadpark.no ([217.13.4.2]:56557 "EHLO mail.broadpark.no")
	by vger.kernel.org with ESMTP id S264346AbUH0Mit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 08:38:49 -0400
Message-ID: <412F2B79.40609@linux-user.net>
Date: Fri, 27 Aug 2004 14:39:21 +0200
From: Daniel Andersen <anddan@linux-user.net>
User-Agent: Mozilla Thunderbird 0.7.2 (X11/20040712)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] README - Explain new 2.6.xx.x bug-fix release numbering scheme
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch explains the new 2.6.xx.x bug-fix release numbering scheme 
introduced with 2.6.8.1. I hope this can help people understand how to 
patch such kernels.

Daniel Andersen
--

diff -urN linux/README.orig linux/README
--- linux/README.orig	2004-08-14 07:37:40.000000000 +0200
+++ linux/README	2004-08-27 14:37:09.242341334 +0200
@@ -77,6 +77,13 @@
     failed patches (xxx# or xxx.rej). If there are, either you or me has
     made a mistake.

+   As of kernel 2.6.8 there was a bug-fix release numbering scheme
+   introduced. In such cases a fourth number is added to the release
+   version, eg. 2.6.8.1. When patching from a 2.6.xx(.x) release to a
+   newer version, patches are to be applied against the original
+   release, eg. 2.6.8 and not the bug-fix release 2.6.8.1. Old patches
+   can be reversed by adding the "-R" option to patch.
+
     Alternatively, the script patch-kernel can be used to automate this
     process.  It determines the current kernel version and applies any
     patches found.
