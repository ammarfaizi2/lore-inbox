Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966145AbWKTQ0Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966145AbWKTQ0Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 11:26:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966148AbWKTQ0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 11:26:25 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:12423 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S966146AbWKTQ0Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 11:26:24 -0500
Date: Mon, 20 Nov 2006 11:25:55 -0500
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Fastboot mailing list <fastboot@lists.osdl.org>,
       Morton Andrew Morton <akpm@osdl.org>
Subject: [PATCH] i386: Correct documentation for bzImage protocol v2.05
Message-ID: <20061120162555.GI11450@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

o Correct the documentation for bzImage protocol extension due to relocatable
  bzImage.

o Last time forgot to copy the patch to mailing list. Hence sending it
  again.

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 linux-2.6.19-rc5-mm2-vivek/Documentation/i386/boot.txt |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff -puN Documentation/i386/boot.txt~i386-correct-documentation-for-bzImage-protocol-extension Documentation/i386/boot.txt
--- linux-2.6.19-rc5-mm2/Documentation/i386/boot.txt~i386-correct-documentation-for-bzImage-protocol-extension	2006-11-17 20:40:33.000000000 -0500
+++ linux-2.6.19-rc5-mm2-vivek/Documentation/i386/boot.txt	2006-11-17 20:41:38.000000000 -0500
@@ -2,7 +2,7 @@
 		     ----------------------------
 
 		    H. Peter Anvin <hpa@zytor.com>
-			Last update 2005-09-02
+			Last update 2006-11-17
 
 On the i386 platform, the Linux kernel uses a rather complicated boot
 convention.  This has evolved partially due to historical aspects, as
@@ -131,8 +131,8 @@ Offset	Proto	Name		Meaning
 0226/2	N/A	pad1		Unused
 0228/4	2.02+	cmd_line_ptr	32-bit pointer to the kernel command line
 022C/4	2.03+	initrd_addr_max	Highest legal initrd address
-0230/4	2.04+	kernel_alignment Physical addr alignment required for kernel
-0234/1	2.04+	relocatable_kernel Whether kernel is relocatable or not
+0230/4	2.05+	kernel_alignment Physical addr alignment required for kernel
+0234/1	2.05+	relocatable_kernel Whether kernel is relocatable or not
 
 (1) For backwards compatibility, if the setup_sects field contains 0, the
     real value is 4.
_

----- End forwarded message -----
