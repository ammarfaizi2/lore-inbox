Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267175AbSKSSef>; Tue, 19 Nov 2002 13:34:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267173AbSKSSeb>; Tue, 19 Nov 2002 13:34:31 -0500
Received: from air-2.osdl.org ([65.172.181.6]:10624 "EHLO doc.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S267167AbSKSSe1>;
	Tue, 19 Nov 2002 13:34:27 -0500
Date: Tue, 19 Nov 2002 10:41:29 -0800
From: Bob Miller <rem@osdl.org>
To: trivial@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org
Subject: [TRIVIAL PATCH 2.5.48] Remove compile warning from drivers/acpi/bus.c
Message-ID: <20021119184129.GA1986@doc.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add the include of linux/device.h to remove a compile time waring
from drivers/acpi/bus.c


diff -Nru a/drivers/acpi/bus.c b/drivers/acpi/bus.c
--- a/drivers/acpi/bus.c	Tue Nov 19 10:31:17 2002
+++ b/drivers/acpi/bus.c	Tue Nov 19 10:31:17 2002
@@ -29,6 +29,7 @@
 #include <linux/pm.h>
 #include <linux/device.h>
 #include <linux/proc_fs.h>
+#include <linux/device.h>
 #ifdef CONFIG_X86
 #include <asm/mpspec.h>
 #endif


-- 
Bob Miller					Email: rem@osdl.org
Open Source Development Lab			Phone: 503.626.2455 Ext. 17
