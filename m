Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261955AbUK3Ccg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261955AbUK3Ccg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 21:32:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261821AbUK3CBT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 21:01:19 -0500
Received: from baikonur.stro.at ([213.239.196.228]:46556 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S261824AbUK3B52
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 20:57:28 -0500
Subject: [patch 06/11] Subject: ifdef typos: drivers_char_ipmi_ipmi_si_intf.c
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, domen@coderock.org,
       rddunlap@osdl.org
From: janitor@sternwelten.at
Date: Tue, 30 Nov 2004 02:57:25 +0100
Message-ID: <E1CYxGf-0002pu-UD@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



CONFIG_ACPI_INTERPETER is wrong.

Signed-off-by: Domen Puncer <domen@coderock.org>
Acked-by: Randy Dunlap <rddunlap@osdl.org>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>

---

 linux-2.6.10-rc2-bk13-max/drivers/char/ipmi/ipmi_si_intf.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/char/ipmi/ipmi_si_intf.c~ifdef-drivers_char_ipmi_ipmi_si_int drivers/char/ipmi/ipmi_si_intf.c
--- linux-2.6.10-rc2-bk13/drivers/char/ipmi/ipmi_si_intf.c~ifdef-drivers_char_ipmi_ipmi_si_int	2004-11-30 02:41:38.000000000 +0100
+++ linux-2.6.10-rc2-bk13-max/drivers/char/ipmi/ipmi_si_intf.c	2004-11-30 02:41:38.000000000 +0100
@@ -959,7 +959,7 @@ MODULE_PARM_DESC(regshifts, "The amount 
 #define IPMI_MEM_ADDR_SPACE 1
 #define IPMI_IO_ADDR_SPACE  2
 
-#if defined(CONFIG_ACPI_INTERPETER) || defined(CONFIG_X86) || defined(CONFIG_PCI)
+#if defined(CONFIG_ACPI_INTERPRETER) || defined(CONFIG_X86) || defined(CONFIG_PCI)
 static int is_new_interface(int intf, u8 addr_space, unsigned long base_addr)
 {
 	int i;
_
