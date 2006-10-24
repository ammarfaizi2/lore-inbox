Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752101AbWJXTkz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752101AbWJXTkz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 15:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752110AbWJXTkz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 15:40:55 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:27569 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1752101AbWJXTky
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 15:40:54 -0400
Date: Tue, 24 Oct 2006 15:40:19 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Fastboot mailing list <fastboot@lists.osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Morton Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>
Subject: [PATCH] i386: Mark CONFIG_RELOCATABLE EXPERIMENTAL
Message-ID: <20061024194019.GA14225@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



o Mark CONFIG_RELOCATABLE experimental.

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 arch/i386/Kconfig |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff -puN arch/i386/Kconfig~i386-mark-CONFIG_RELOCATABLE-experimental arch/i386/Kconfig
--- linux-2.6.19-rc2-git7-reloc/arch/i386/Kconfig~i386-mark-CONFIG_RELOCATABLE-experimental	2006-10-24 15:22:22.000000000 -0400
+++ linux-2.6.19-rc2-git7-reloc-root/arch/i386/Kconfig	2006-10-24 15:23:02.000000000 -0400
@@ -774,7 +774,8 @@ config CRASH_DUMP
 	  For more details see Documentation/kdump/kdump.txt
 
 config RELOCATABLE
-	bool "Build a relocatable kernel"
+	bool "Build a relocatable kernel(EXPERIMENTAL)"
+	depends on EXPERIMENTAL
 	help
 	  This build a kernel image that retains relocation information
           so it can be loaded someplace besides the default 1MB.
_
