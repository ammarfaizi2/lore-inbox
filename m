Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262266AbSLMRj5>; Fri, 13 Dec 2002 12:39:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262448AbSLMRj5>; Fri, 13 Dec 2002 12:39:57 -0500
Received: from mailout11.sul.t-online.com ([194.25.134.85]:41400 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S262266AbSLMRj4>; Fri, 13 Dec 2002 12:39:56 -0500
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.4.21-BK] Fix typo in arch/arm/config.in
Date: Fri, 13 Dec 2002 18:47:08 +0100
User-Agent: KMail/1.4.3
Organization: WOLK - Working Overloaded Linux Kernel
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>
MIME-Version: 1.0
Message-Id: <200212131844.45280.m.c.p@wolk-project.de>
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_K2K2YIU99RFMXFMIJW7Y"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_K2K2YIU99RFMXFMIJW7Y
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Marcelo,

this fixes a typo in arch/arm/config.in.

old:    source drivers/ssi/Config.in
new:=09source drivers/scsi/Config.in

 Without it, make menuconfig crashes.

ciao, Marc
--------------Boundary-00=_K2K2YIU99RFMXFMIJW7Y
Content-Type: text/x-diff;
  charset="us-ascii";
  name="218_arch-arm-fix-typo.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="218_arch-arm-fix-typo.patch"

--- linux-old/arch/arm/config.in	2002-12-13 18:42:10.000000000 +0100
+++ linux-wolk4/arch/arm/config.in	2002-12-13 18:42:32.000000000 +0100
@@ -542,7 +542,7 @@
 endmenu
 
 if [ "$CONFIG_ARCH_CLPS711X" = "y" ]; then
-   source drivers/ssi/Config.in
+   source drivers/scsi/Config.in
 fi
 
 source drivers/ieee1394/Config.in

--------------Boundary-00=_K2K2YIU99RFMXFMIJW7Y--

