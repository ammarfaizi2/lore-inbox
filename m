Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265010AbSKKNHv>; Mon, 11 Nov 2002 08:07:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265016AbSKKNHv>; Mon, 11 Nov 2002 08:07:51 -0500
Received: from itaqui.terra.com.br ([200.176.3.19]:16808 "EHLO
	itaqui.terra.com.br") by vger.kernel.org with ESMTP
	id <S265010AbSKKNHu>; Mon, 11 Nov 2002 08:07:50 -0500
Date: Mon, 11 Nov 2002 11:14:36 -0200
From: Lucio Maciel <abslucio@terra.com.br>
To: LKML <linux-kernel@vger.kernel.org>
Cc: "rusty's trivial patch monkey" <trivial@rustcorp.com.au>
Subject: [TRIVIAL PATCH 2.5.47] implicit declaration in drivers/acpi/bus.c
Message-Id: <20021111111436.068b6c4b.abslucio@terra.com.br>
Organization: absoluta
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this patchs fix a  implicit declaration of function "firmware_register" warning in 2.5.47


--- linux/drivers/acpi/bus.c~	11 Nov 2002 12:28:44 -0000
+++ linux/drivers/acpi/bus.c	11 Nov 2002 12:40:07 -0000
@@ -28,6 +28,7 @@
 #include <linux/sched.h>
 #include <linux/pm.h>
 #include <linux/proc_fs.h>
+#include <linux/device.h>
 #ifdef CONFIG_X86
 #include <asm/mpspec.h>
 #endif


-- 
::: Lucio F. Maciel
::: abslucio@terra.com.br
::: icq 93065464
::: Absoluta.net
