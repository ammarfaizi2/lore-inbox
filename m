Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312712AbSCVP2g>; Fri, 22 Mar 2002 10:28:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312716AbSCVP21>; Fri, 22 Mar 2002 10:28:27 -0500
Received: from tstac.esa.lanl.gov ([128.165.46.3]:44417 "EHLO
	tstac.esa.lanl.gov") by vger.kernel.org with ESMTP
	id <S312712AbSCVP2X>; Fri, 22 Mar 2002 10:28:23 -0500
Subject: [PATCH] 2.5.7-dj1, add 3 help texts to arch/mips/Config.help
From: Steven Cole <elenstev@mesatop.com>
To: Ralf Baechle <ralf@gnu.org>, Dave Jones <davej@suse.de>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 22 Mar 2002 08:25:36 -0700
Message-Id: <1016810736.2266.44.camel@spc.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds three help texts to arch/mips/Config.help.
The texts were obtained from ESR's v2.97 Configure.help.

Steven


--- linux-2.5.7-dj1/arch/mips/Config.help.orig	Fri Mar 22 08:13:57 2002
+++ linux-2.5.7-dj1/arch/mips/Config.help	Fri Mar 22 08:17:12 2002
@@ -809,6 +809,24 @@
   either a NEC Vr5432 or QED RM5231. Say Y here if you wish to build
   a kernel for this platform.
 
+CONFIG_IT8172_REVC
+  Say Y here to support the older, Revision C version of the Integrated
+  Technology Express, Inc. ITE8172 SBC.  Vendor page at
+  <http://www.ite.com.tw/ia/brief_it8172bsp.htm>; picture of the
+  board at <http://www.mvista.com/allies/semiconductor/ite.html>.
+
+CONFIG_IT8172_SCR0
+  Say Y here to support smart-card reader 0 (SCR0) on the Integrated
+  Technology Express, Inc. ITE8172 SBC.  Vendor page at
+  <http://www.ite.com.tw/ia/brief_it8172bsp.htm>; picture of the
+  board at <http://www.mvista.com/allies/semiconductor/ite.html>.
+
+CONFIG_IT8172_SCR1
+  Say Y here to support smart-card reader 1 (SCR1) on the Integrated
+  Technology Express, Inc. ITE8172 SBC.  Vendor page at
+  <http://www.ite.com.tw/ia/brief_it8172bsp.htm>; picture of the
+  board at <http://www.mvista.com/allies/semiconductor/ite.html>.
+
 CONFIG_MIPS_IVR
   This is an evaluation board built by Globespan to showcase thir
   iVR (Internet Video Recorder) design. It utilizes a QED RM5231


