Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262449AbVAEOc5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262449AbVAEOc5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 09:32:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262448AbVAEOc5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 09:32:57 -0500
Received: from mx1.redhat.com ([66.187.233.31]:22152 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262449AbVAEOcx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 09:32:53 -0500
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] FRV: provide stub asm/a.out.h
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.1
Date: Wed, 05 Jan 2005 14:32:49 +0000
Message-ID: <28569.1104935569@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch provides a stub asm/a.out.h for the FRV arch. This
shouldn't be necessary as FRV doesn't support the AOUT binfmt, but it seems to
be required by some archs for compilation of fs/exec.c.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat frv-aouth-2610bk8.diff 
 a.out.h |    5 +++++
 1 files changed, 5 insertions(+)

diff -uNrp /warthog/kernels/linux-2.6.10-bk8/include/asm-frv/a.out.h linux-2.6.10-bk8-frv/include/asm-frv/a.out.h
--- /warthog/kernels/linux-2.6.10-bk8/include/asm-frv/a.out.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-bk8-frv/include/asm-frv/a.out.h	2005-01-05 13:33:46.113126564 +0000
@@ -0,0 +1,5 @@
+/*
+ * FRV doesn't do AOUT format. This header file should be removed as
+ * soon as fs/exec.c and fs/proc/kcore.c and the archs that require
+ * them to include linux/a.out.h are fixed.
+ */
