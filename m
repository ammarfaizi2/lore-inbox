Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318361AbSGYH75>; Thu, 25 Jul 2002 03:59:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318362AbSGYH75>; Thu, 25 Jul 2002 03:59:57 -0400
Received: from [80.94.163.134] ([80.94.163.134]:22144 "HELO blacklake.uucp")
	by vger.kernel.org with SMTP id <S318361AbSGYH74>;
	Thu, 25 Jul 2002 03:59:56 -0400
Date: Thu, 25 Jul 2002 11:01:56 +0300
From: Dzmitry Chekmarou <diavolo@mail.ru>
To: Andy Grover <andrew.grover@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: linux-2.5.28 drivers/acpi/system.c missed interrupt.h
Message-ID: <20020725080156.GA7422@blacklake>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Andy

here it is:
diff -uNr a/drivers/acpi/system.c b/drivers/acpi/system.c
--- a/drivers/acpi/system.c     Thu Jul 25 10:50:16 2002
+++ b/drivers/acpi/system.c     Thu Jul 25 10:44:31 2002
@@ -40,6 +40,7 @@
 #include <linux/pm.h>
 #include <linux/device.h>
 #include <linux/suspend.h>
+#include <linux/interrupt.h>
 #include <asm/uaccess.h>
 #include <asm/acpi.h>
 #include "acpi_bus.h"

-- 
Best regards,
zmiter.
