Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263771AbTCUStA>; Fri, 21 Mar 2003 13:49:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263789AbTCUSsK>; Fri, 21 Mar 2003 13:48:10 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:21892
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263771AbTCUSqr>; Fri, 21 Mar 2003 13:46:47 -0500
Date: Fri, 21 Mar 2003 20:02:02 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303212002.h2LK228J026199@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: add pc9800 port types
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/include/linux/serial_core.h linux-2.5.65-ac2/include/linux/serial_core.h
--- linux-2.5.65/include/linux/serial_core.h	2003-03-18 16:46:52.000000000 +0000
+++ linux-2.5.65-ac2/include/linux/serial_core.h	2003-03-18 17:12:12.000000000 +0000
@@ -59,6 +59,14 @@
 /* NEC v850.  */
 #define PORT_NB85E_UART	40
 
+/* NEC PC-9800 */
+#define PORT_8251_PC98	41
+#define PORT_19K_PC98	42
+#define PORT_FIFO_PC98	43
+#define PORT_VFAST_PC98	44
+#define PORT_PC9861	45
+#define PORT_PC9801_101	46
+
 
 #ifdef __KERNEL__
 
