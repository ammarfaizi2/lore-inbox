Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751355AbVJSV1r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751355AbVJSV1r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 17:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751356AbVJSV1r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 17:27:47 -0400
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:30698 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1751355AbVJSV1r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 17:27:47 -0400
From: Grant Coady <gcoady@gmail.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] pci_ids: cleanup comments
Date: Wed, 19 Oct 2005 15:37:18 +1000
Organization: http://bugsplatter.mine.nu/
Message-ID: <irmbl1dm869kot3sjnf4581kd723145d94@4ax.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Grant Coady <gcoady@gmail.com>

pci_ids.h cleanup comments, convert '// style' to '/* style */' 
and move comments to first column to simplify file layout in 
preparation for whitespace cleanup script.  No code change.

Signed-off-by: Grant Coady <gcoady@gmail.com>

---
 pci_ids.h |  108 ++++++++++++++++++++++++++++++++++++++++----------------------
 1 files changed, 70 insertions(+), 38 deletions(-)

--- linux-2.6.14-rc4-mm1a/include/linux/pci_ids.h	2005-10-17 15:14:41.000000000 +1000
+++ linux-2.6.14-rc4-mm1b/include/linux/pci_ids.h	2005-10-19 07:50:05.000000000 +1000
@@ -448,7 +448,8 @@
 #define PCI_DEVICE_ID_IBM_ICOM_V2_ONE_PORT_RVX_ONE_PORT_MDM	0x0251
 #define PCI_DEVICE_ID_IBM_ICOM_FOUR_PORT_MODEL	0x252
 
-#define PCI_VENDOR_ID_COMPEX2		0x101a // pci.ids says "AT&T GIS (NCR)"
+/* pci.ids says "AT&T GIS (NCR)" */
+#define PCI_VENDOR_ID_COMPEX2		0x101a
 #define PCI_DEVICE_ID_COMPEX2_100VG	0x0005
 
 #define PCI_VENDOR_ID_WD		0x101c
@@ -544,28 +545,44 @@
 #define PCI_DEVICE_ID_MIRO_DC30PLUS	0xd801
 
 #define PCI_VENDOR_ID_NEC		0x1033
-#define PCI_DEVICE_ID_NEC_CBUS_1	0x0001 /* PCI-Cbus Bridge */
-#define PCI_DEVICE_ID_NEC_LOCAL		0x0002 /* Local Bridge */
-#define PCI_DEVICE_ID_NEC_ATM		0x0003 /* ATM LAN Controller */
-#define PCI_DEVICE_ID_NEC_R4000		0x0004 /* R4000 Bridge */
-#define PCI_DEVICE_ID_NEC_486		0x0005 /* 486 Like Peripheral Bus Bridge */
-#define PCI_DEVICE_ID_NEC_ACCEL_1	0x0006 /* Graphic Accelerator */
-#define PCI_DEVICE_ID_NEC_UXBUS		0x0007 /* UX-Bus Bridge */
-#define PCI_DEVICE_ID_NEC_ACCEL_2	0x0008 /* Graphic Accelerator */
-#define PCI_DEVICE_ID_NEC_GRAPH		0x0009 /* PCI-CoreGraph Bridge */
-#define PCI_DEVICE_ID_NEC_VL		0x0016 /* PCI-VL Bridge */
-#define PCI_DEVICE_ID_NEC_STARALPHA2	0x002c /* STAR ALPHA2 */
-#define PCI_DEVICE_ID_NEC_CBUS_2	0x002d /* PCI-Cbus Bridge */
-#define PCI_DEVICE_ID_NEC_USB		0x0035 /* PCI-USB Host */
+/* PCI-Cbus Bridge */
+#define PCI_DEVICE_ID_NEC_CBUS_1	0x0001
+/* Local Bridge */
+#define PCI_DEVICE_ID_NEC_LOCAL		0x0002
+/* ATM LAN Controller */
+#define PCI_DEVICE_ID_NEC_ATM		0x0003
+/* R4000 Bridge */
+#define PCI_DEVICE_ID_NEC_R4000		0x0004
+/* 486 Like Peripheral Bus Bridge */
+#define PCI_DEVICE_ID_NEC_486		0x0005
+/* Graphic Accelerator */
+#define PCI_DEVICE_ID_NEC_ACCEL_1	0x0006
+/* UX-Bus Bridge */
+#define PCI_DEVICE_ID_NEC_UXBUS		0x0007
+/* Graphic Accelerator */
+#define PCI_DEVICE_ID_NEC_ACCEL_2	0x0008
+/* PCI-CoreGraph Bridge */
+#define PCI_DEVICE_ID_NEC_GRAPH		0x0009
+/* PCI-VL Bridge */
+#define PCI_DEVICE_ID_NEC_VL		0x0016
+/* STAR ALPHA2 */
+#define PCI_DEVICE_ID_NEC_STARALPHA2	0x002c
+/* PCI-Cbus Bridge */
+#define PCI_DEVICE_ID_NEC_CBUS_2	0x002d
+/* PCI-USB Host */
+#define PCI_DEVICE_ID_NEC_USB		0x0035
 #define PCI_DEVICE_ID_NEC_CBUS_3	0x003b
 #define PCI_DEVICE_ID_NEC_NAPCCARD	0x003e
-#define PCI_DEVICE_ID_NEC_PCX2		0x0046 /* PowerVR */
+/* PowerVR */
+#define PCI_DEVICE_ID_NEC_PCX2		0x0046
 #define PCI_DEVICE_ID_NEC_NILE4		0x005a
 #define PCI_DEVICE_ID_NEC_VRC5476       0x009b
 #define PCI_DEVICE_ID_NEC_VRC4173	0x00a5
 #define PCI_DEVICE_ID_NEC_VRC5477_AC97  0x00a6
-#define PCI_DEVICE_ID_NEC_PC9821CS01    0x800c /* PC-9821-CS01 */
-#define PCI_DEVICE_ID_NEC_PC9821NRB06   0x800d /* PC-9821NR-B06 */
+/* PC-9821-CS01 */
+#define PCI_DEVICE_ID_NEC_PC9821CS01    0x800c
+/* PC-9821NR-B06 */
+#define PCI_DEVICE_ID_NEC_PC9821NRB06   0x800d
 
 #define PCI_VENDOR_ID_FD		0x1036
 #define PCI_DEVICE_ID_FD_36C70		0x0000
@@ -1161,10 +1178,12 @@
 
 #define PCI_VENDOR_ID_INIT		0x1101
 
-#define PCI_VENDOR_ID_CREATIVE		0x1102 // duplicate: ECTIVA
+/* duplicate: ECTIVA */
+#define PCI_VENDOR_ID_CREATIVE		0x1102
 #define PCI_DEVICE_ID_CREATIVE_EMU10K1	0x0002
 
-#define PCI_VENDOR_ID_ECTIVA		0x1102 // duplicate: CREATIVE
+/* duplicate: CREATIVE */
+#define PCI_VENDOR_ID_ECTIVA		0x1102
 #define PCI_DEVICE_ID_ECTIVA_EV1938	0x8938
 
 #define PCI_VENDOR_ID_TTI		0x1103
@@ -1174,7 +1193,8 @@
 #define PCI_DEVICE_ID_TTI_HPT302	0x0006
 #define PCI_DEVICE_ID_TTI_HPT371	0x0007
 #define PCI_DEVICE_ID_TTI_HPT374	0x0008
-#define PCI_DEVICE_ID_TTI_HPT372N	0x0009	// apparently a 372N variant?
+/* apparently a 372N variant? */
+#define PCI_DEVICE_ID_TTI_HPT372N	0x0009
 
 #define PCI_VENDOR_ID_VIA		0x1106
 #define PCI_DEVICE_ID_VIA_8763_0	0x0198
@@ -1433,8 +1453,8 @@
 #define PCI_DEVICE_ID_RP8OCTA		0x0005
 #define PCI_DEVICE_ID_RP8J		0x0006
 #define PCI_DEVICE_ID_RP4J		0x0007
-#define PCI_DEVICE_ID_RP8SNI		0x0008	
-#define PCI_DEVICE_ID_RP16SNI		0x0009	
+#define PCI_DEVICE_ID_RP8SNI		0x0008
+#define PCI_DEVICE_ID_RP16SNI		0x0009
 #define PCI_DEVICE_ID_RPP4		0x000A
 #define PCI_DEVICE_ID_RPP8		0x000B
 #define PCI_DEVICE_ID_RP4M		0x000D
@@ -1444,9 +1464,9 @@
 #define PCI_DEVICE_ID_URP8INTF		0x0802
 #define PCI_DEVICE_ID_URP16INTF		0x0803
 #define PCI_DEVICE_ID_URP8OCTA		0x0805
-#define PCI_DEVICE_ID_UPCI_RM3_8PORT	0x080C       
+#define PCI_DEVICE_ID_UPCI_RM3_8PORT	0x080C     
 #define PCI_DEVICE_ID_UPCI_RM3_4PORT	0x080D
-#define PCI_DEVICE_ID_CRP16INTF		0x0903       
+#define PCI_DEVICE_ID_CRP16INTF		0x0903     
 
 #define PCI_VENDOR_ID_CYCLADES		0x120e
 #define PCI_DEVICE_ID_CYCLOM_Y_Lo	0x0100
@@ -1718,19 +1738,31 @@
 #define PCI_DEVICE_ID_CMEDIA_CM8738B	0x0112
 
 #define PCI_VENDOR_ID_LAVA		0x1407
-#define PCI_DEVICE_ID_LAVA_DSERIAL	0x0100 /* 2x 16550 */
-#define PCI_DEVICE_ID_LAVA_QUATRO_A	0x0101 /* 2x 16550, half of 4 port */
-#define PCI_DEVICE_ID_LAVA_QUATRO_B	0x0102 /* 2x 16550, half of 4 port */
-#define PCI_DEVICE_ID_LAVA_OCTO_A	0x0180 /* 4x 16550A, half of 8 port */
-#define PCI_DEVICE_ID_LAVA_OCTO_B	0x0181 /* 4x 16550A, half of 8 port */
-#define PCI_DEVICE_ID_LAVA_PORT_PLUS	0x0200 /* 2x 16650 */
-#define PCI_DEVICE_ID_LAVA_QUAD_A	0x0201 /* 2x 16650, half of 4 port */
-#define PCI_DEVICE_ID_LAVA_QUAD_B	0x0202 /* 2x 16650, half of 4 port */
-#define PCI_DEVICE_ID_LAVA_SSERIAL	0x0500 /* 1x 16550 */
-#define PCI_DEVICE_ID_LAVA_PORT_650	0x0600 /* 1x 16650 */
+/* 2x 16550 */
+#define PCI_DEVICE_ID_LAVA_DSERIAL	0x0100
+/* 2x 16550, half of 4 port */
+#define PCI_DEVICE_ID_LAVA_QUATRO_A	0x0101
+/* 2x 16550, half of 4 port */
+#define PCI_DEVICE_ID_LAVA_QUATRO_B	0x0102
+/* 4x 16550A, half of 8 port */
+#define PCI_DEVICE_ID_LAVA_OCTO_A	0x0180
+/* 4x 16550A, half of 8 port */
+#define PCI_DEVICE_ID_LAVA_OCTO_B	0x0181
+/* 2x 16650 */
+#define PCI_DEVICE_ID_LAVA_PORT_PLUS	0x0200
+/* 2x 16650, half of 4 port */
+#define PCI_DEVICE_ID_LAVA_QUAD_A	0x0201
+/* 2x 16650, half of 4 port */
+#define PCI_DEVICE_ID_LAVA_QUAD_B	0x0202
+/* 1x 16550 */
+#define PCI_DEVICE_ID_LAVA_SSERIAL	0x0500
+/* 1x 16650 */
+#define PCI_DEVICE_ID_LAVA_PORT_650	0x0600
 #define PCI_DEVICE_ID_LAVA_PARALLEL	0x8000
-#define PCI_DEVICE_ID_LAVA_DUAL_PAR_A	0x8002 /* The Lava Dual Parallel is */
-#define PCI_DEVICE_ID_LAVA_DUAL_PAR_B	0x8003 /* two PCI devices on a card */
+/* The Lava Dual Parallel is */
+#define PCI_DEVICE_ID_LAVA_DUAL_PAR_A	0x8002
+/* two PCI devices on a card */
+#define PCI_DEVICE_ID_LAVA_DUAL_PAR_B	0x8003
 #define PCI_DEVICE_ID_LAVA_BOCA_IOPPAR	0x8800
 
 #define PCI_VENDOR_ID_TIMEDIA		0x1409
@@ -1840,7 +1872,7 @@
 #define PCI_DEVICE_ID_RASTEL_2PORT	0x2000
 
 #define PCI_VENDOR_ID_ZOLTRIX		0x15b0
-#define PCI_DEVICE_ID_ZOLTRIX_2BD0	0x2bd0 
+#define PCI_DEVICE_ID_ZOLTRIX_2BD0	0x2bd0
 
 #define PCI_VENDOR_ID_MELLANOX		0x15b3
 #define PCI_DEVICE_ID_MELLANOX_TAVOR	0x5a44
@@ -1939,7 +1971,7 @@
 #define PCI_DEVICE_ID_INTEL_82815_MC	0x1130
 #define PCI_DEVICE_ID_INTEL_82815_CGC	0x1132
 #define PCI_DEVICE_ID_INTEL_82092AA_0	0x1221
-#define PCI_DEVICE_ID_INTEL_7505_0	0x2550  
+#define PCI_DEVICE_ID_INTEL_7505_0	0x2550
 #define PCI_DEVICE_ID_INTEL_7205_0	0x255d
 #define PCI_DEVICE_ID_INTEL_82437	0x122d
 #define PCI_DEVICE_ID_INTEL_82371FB_0	0x122e
