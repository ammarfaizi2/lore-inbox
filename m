Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312704AbSCVPPG>; Fri, 22 Mar 2002 10:15:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312705AbSCVPOr>; Fri, 22 Mar 2002 10:14:47 -0500
Received: from tstac.esa.lanl.gov ([128.165.46.3]:52452 "EHLO
	tstac.esa.lanl.gov") by vger.kernel.org with ESMTP
	id <S312704AbSCVPO0>; Fri, 22 Mar 2002 10:14:26 -0500
Subject: [PATCH] 2.5.7-dj1, add 1 help text to sound/oss/Config.help
From: Steven Cole <elenstev@mesatop.com>
To: Dave Jones <davej@suse.de>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 22 Mar 2002 08:11:40 -0700
Message-Id: <1016809900.24907.37.camel@spc.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a help text for CONFIG_SOUND_IT8172 in
sound/oss/Config.help.  The text was obtained from ESR's v2.97
Configure.help.

Steven


--- linux-2.5.7-dj1/sound/oss/Config.help.orig	Fri Mar 22 07:59:11 2002
+++ linux-2.5.7-dj1/sound/oss/Config.help	Fri Mar 22 08:03:09 2002
@@ -220,6 +220,12 @@
   <file:Documentation/sound/vwsnd> for more info on this driver's
   capabilities.
 
+CONFIG_SOUND_IT8172
+  Say Y here to support the on-board sound generator on the Integrated
+  Technology Express, Inc. ITE8172 SBC.  Vendor page at
+  <http://www.ite.com.tw/ia/brief_it8172bsp.htm>; picture of the
+  board at <http://www.mvista.com/allies/semiconductor/ite.html>.
+
 CONFIG_SOUND_VRC5477
   Say Y here to enable sound support for the NEC Vrc5477 chip, an
   integrated, multi-function controller chip for MIPS CPUs.  Works


