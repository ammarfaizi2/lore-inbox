Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262610AbUKEF5E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262610AbUKEF5E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 00:57:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262614AbUKEF5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 00:57:04 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:65172 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S262610AbUKEF46 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 00:56:58 -0500
Date: Fri, 05 Nov 2004 14:56:09 +0900
From: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
Subject: [PATCH] Fix duplicate config for IA64_MCA_RECOVERY
To: tony.luck@intel.com, akpm@osdl.org
Cc: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Message-id: <20041105145609.0310d9ee.tokunaga.keiich@jp.fujitsu.com>
Organization: FUJITSU LIMITED
MIME-version: 1.0
X-Mailer: Sylpheed version 0.9.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a small bug fix against 2.6.10-rc1-mm2.

Thanks,
Keiichiro Tokunaga

Signed-off-by: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
Description:
Fix duplicate config for IA64_MCA_RECOVERY.

---

 linux-2.6.10-rc1-mm2-kei/arch/ia64/Kconfig |    3 ---
 1 files changed, 3 deletions(-)

diff -puN arch/ia64/Kconfig~fix_mca_kconfig arch/ia64/Kconfig
--- linux-2.6.10-rc1-mm2/arch/ia64/Kconfig~fix_mca_kconfig	2004-11-05 14:44:19.861106461 +0900
+++ linux-2.6.10-rc1-mm2-kei/arch/ia64/Kconfig	2004-11-05 14:45:28.620439785 +0900
@@ -491,9 +491,6 @@ config COMPAT
 config IA64_MCA_RECOVERY
 	tristate "MCA recovery from errors other than TLB."
 
-config IA64_MCA_RECOVERY
-	tristate "MCA recovery from errors other than TLB."
-
 config PERFMON
 	bool "Performance monitor support"
 	help

_
