Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278488AbRJPBtr>; Mon, 15 Oct 2001 21:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278489AbRJPBti>; Mon, 15 Oct 2001 21:49:38 -0400
Received: from patan.Sun.COM ([192.18.98.43]:10372 "EHLO patan.sun.com")
	by vger.kernel.org with ESMTP id <S278488AbRJPBtY>;
	Mon, 15 Oct 2001 21:49:24 -0400
Message-ID: <3BCB9188.EB25C198@sun.com>
Date: Mon, 15 Oct 2001 18:46:48 -0700
From: Tim Hockin <thockin@sun.com>
Organization: Sun Microsystems, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: andrew.grover@intel.com
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH]  Add defines for ACPI general events
Content-Type: multipart/mixed;
 boundary="------------5B423A56113318FDCF30F54C"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------5B423A56113318FDCF30F54C
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Andy,

A simple patch - add 8 defines for 8 GEVENTs.  Please apply for the next
round.  Let me know if there is any reason you can't apply it.

Tim

-- 
Tim Hockin
Systems Software Engineer
Sun Microsystems, Cobalt Server Appliances
thockin@sun.com
--------------5B423A56113318FDCF30F54C
Content-Type: text/plain; charset=us-ascii;
 name="acpi-gevents.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="acpi-gevents.diff"

diff -ruN dist-2.4.12+patches/include/linux/acpi.h cvs-2.4.12+patches/include/linux/acpi.h
--- dist-2.4.12+patches/include/linux/acpi.h	Mon Oct 15 10:23:40 2001
+++ cvs-2.4.12+patches/include/linux/acpi.h	Mon Oct 15 10:23:40 2001
@@ -80,6 +80,16 @@
 #define ACPI_SLP_TYP2 0x1000
 #define ACPI_SLP_EN   0x2000
 
+/* GPE0/1 general event flags */
+#define ACPI_GEVENT0  0x0001
+#define ACPI_GEVENT1  0x0002
+#define ACPI_GEVENT2  0x0004
+#define ACPI_GEVENT3  0x0008
+#define ACPI_GEVENT4  0x0010
+#define ACPI_GEVENT5  0x0020
+#define ACPI_GEVENT6  0x0040
+#define ACPI_GEVENT7  0x0080
+
 #define ACPI_SLP_TYP_MASK  0x1c00
 #define ACPI_SLP_TYP_SHIFT 10
 

--------------5B423A56113318FDCF30F54C--

