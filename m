Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263538AbTIBEUK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 00:20:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263553AbTIBEUK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 00:20:10 -0400
Received: from smtp801.mail.sc5.yahoo.com ([66.163.168.180]:56922 "HELO
	smtp801.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263538AbTIBEUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 00:20:05 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.0 - 8250_acpi taints kernel
Date: Mon, 1 Sep 2003 23:19:58 -0500
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309012320.01156.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

8250_acpi module does not have MODULE_LICENSE specified. 8250_gsc does
not have it either but as I can't compile it I did not touch it.

Dmitry

diff -urN --exclude-from=/usr/src/exclude 2.6.0-test4/drivers/serial/8250_acpi.c linux-2.6.0-test4/drivers/serial/8250_acpi.c
--- 2.6.0-test4/drivers/serial/8250_acpi.c	2003-07-27 12:10:57.000000000 -0500
+++ linux-2.6.0-test4/drivers/serial/8250_acpi.c	2003-09-01 23:01:18.000000000 -0500
@@ -108,3 +108,6 @@
 
 module_init(acpi_serial_init);
 module_exit(acpi_serial_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Generic 8250/16x50 ACPI serial driver");
