Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161097AbWFVNPE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161097AbWFVNPE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 09:15:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030636AbWFVNPE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 09:15:04 -0400
Received: from sun-email.corp.avocent.com ([65.217.42.16]:40075 "EHLO
	sun-email.corp.avocent.com") by vger.kernel.org with ESMTP
	id S1030634AbWFVNPC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 09:15:02 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: [RFC][PATCH 5/13] Equinox SST driver: general defines
Date: Thu, 22 Jun 2006 09:15:01 -0400
Message-ID: <4821D5B6CD3C1B4880E6E94C6E70913E01B71107@sun-email.corp.avocent.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC][PATCH 5/13] Equinox SST driver: general defines
Thread-Index: AcaV/d4Lf0QSQRnJSn+W1AXeCjW0ZQ==
From: "Straub, Michael" <Michael.Straub@avocent.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adds Equinox multi-port serial (SST) driver.

Part 5: new header file: drivers/char/eqnx/eqnx_def.h.  Contains general
driver
defines.

Signed-off-by: Mike Straub <michael.straub@avocent.com>

---
 eqnx_def.h |   37 +++++++++++++++++++++++++++++++++++++
 1 files changed, 37 insertions(+)

diff -Naurp -X dontdiff linux-2.6.17/drivers/char/eqnx/eqnx_def.h
linux-2.6.17.eqnx/drivers/char/eqnx/eqnx_def.h
--- linux-2.6.17/drivers/char/eqnx/eqnx_def.h	1969-12-31
19:00:00.000000000 -0500
+++ linux-2.6.17.eqnx/drivers/char/eqnx/eqnx_def.h	2006-06-20
09:50:03.000000000 -0400
@@ -0,0 +1,37 @@
+/*
+ * Equinox / Avocent SST (multi-port serial) driver.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+
+/*
+ * General driver defines
+ */
+
+#define	MAXCHNL_ICP	64		/* max channels per
single ASIC */
+#define	MAXCHNL_BRD	128		/* max channels per
board */
+
+#define	MAXSSP64_BRD	2		/* max SSP64 ASICs per
board */
+#define	MAXSSP4_BRD	4		/* max SSP4 ASICs per
board */
+#define	MAXSSP_BRD	4		/* max ASICs per board
*/
+
+#define	MAXSSP		8		/* maximum possible SST
boards */
+					/* this can be changed for more
brds */
+
+#define	MAXCHNL		(MAXCHNL_BRD * MAXSSP)
+
+#define	MAXCHNL_LMX	16		/* max RS232/422
channels per lmx */
+#define	MAXLMX		4		/* max LMXs per single
ASIC */
