Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266539AbVBDRjN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266539AbVBDRjN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 12:39:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266021AbVBDRgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 12:36:13 -0500
Received: from mx1.redhat.com ([66.187.233.31]:62663 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265104AbVBDRcJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 12:32:09 -0500
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] FRV: vmlinux.lds.S comment cleanup
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.1
Date: Fri, 04 Feb 2005 17:32:02 +0000
Message-ID: <28799.1107538322@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch cleans up a comment in vmlinux.lds.S - emacs now has an LD
script mode, so it shouldn't be forced into C mode.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 frv-ldscript-cleanup-2611rc3.diff 
 arch/frv/kernel/vmlinux.lds.S |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -uNrp /warthog/kernels/linux-2.6.11-rc3/arch/frv/kernel/vmlinux.lds.S linux-2.6.11-rc3-frv/arch/frv/kernel/vmlinux.lds.S
--- /warthog/kernels/linux-2.6.11-rc3/arch/frv/kernel/vmlinux.lds.S	2005-02-04 11:49:30.000000000 +0000
+++ linux-2.6.11-rc3-frv/arch/frv/kernel/vmlinux.lds.S	2005-02-04 12:35:19.000000000 +0000
@@ -1,4 +1,4 @@
-/* ld script to make FRV Linux kernel -*- c -*-
+/* ld script to make FRV Linux kernel
  * Written by Martin Mares <mj@atrey.karlin.mff.cuni.cz>;
  */
 OUTPUT_FORMAT("elf32-frv", "elf32-frv", "elf32-frv")
