Return-Path: <linux-kernel-owner+willy=40w.ods.org-S281565AbUKBH1X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S281565AbUKBH1X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 02:27:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S446894AbUKBHVq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 02:21:46 -0500
Received: from fw.osdl.org ([65.172.181.6]:30675 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S446935AbUKBHUk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 02:20:40 -0500
Date: Tue, 2 Nov 2004 00:18:43 -0800
From: Andrew Morton <akpm@osdl.org>
To: dhowells@redhat.com
Cc: torvalds@osdl.org, davidm@snapgear.com, linux-kernel@vger.kernel.org,
       uclinux-dev@uclinux.org
Subject: Re: [PATCH 11/14] FRV: Add FDPIC ELF binary format driver
Message-Id: <20041102001843.20a4ad7d.akpm@osdl.org>
In-Reply-To: <200411011930.iA1JULwr023235@warthog.cambridge.redhat.com>
References: <76b4a884-2c3c-11d9-91a1-0002b3163499@redhat.com>
	<200411011930.iA1JULwr023235@warthog.cambridge.redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



It doesn't compile on x86.

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/fs/Kconfig.binfmt |    1 +
 1 files changed, 1 insertion(+)

diff -puN fs/Kconfig.binfmt~frv-add-fdpic-elf-binary-format-driver-fix fs/Kconfig.binfmt
--- 25/fs/Kconfig.binfmt~frv-add-fdpic-elf-binary-format-driver-fix	2004-11-01 23:27:54.951435224 -0800
+++ 25-akpm/fs/Kconfig.binfmt	2004-11-01 23:28:38.771773520 -0800
@@ -26,6 +26,7 @@ config BINFMT_ELF
 config BINFMT_ELF_FDPIC
 	bool "Kernel support for FDPIC ELF binaries"
 	default y
+	depends on FRV
 	help
 	  ELF FDPIC binaries are based on ELF, but allow the individual load
 	  segments of a binary to be located in memory independently of each
_

