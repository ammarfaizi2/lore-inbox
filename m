Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263640AbUHGQ2V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263640AbUHGQ2V (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 12:28:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263664AbUHGQ2U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 12:28:20 -0400
Received: from delta.ds3.agh.edu.pl ([149.156.124.3]:28179 "EHLO
	pluto.ds14.agh.edu.pl") by vger.kernel.org with ESMTP
	id S263640AbUHGQ2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 12:28:19 -0400
From: =?iso-8859-2?q?Pawe=B3_Sikora?= <pluto@pld-linux.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] omnibook / CONFIG_ACPI is not set / missing -Exxxx defs.
Date: Sat, 7 Aug 2004 18:28:18 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_iMQFBWiGWFh42rt"
Message-Id: <200408071828.18174.pluto@pld-linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_iMQFBWiGWFh42rt
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline



--Boundary-00=_iMQFBWiGWFh42rt
Content-Type: text/x-diff;
  charset="iso-8859-2";
  name="omnibook.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="omnibook.patch"

--- linux-2.6.8-rc3/drivers/char/omnibook/ec.c.orig	2004-08-07 15:32:19.000000000 +0200
+++ linux-2.6.8-rc3/drivers/char/omnibook/ec.c	2004-08-07 18:25:18.604913976 +0200
@@ -30,6 +30,7 @@
 #endif
 #endif
 
+#include <linux/errno.h>
 #include <asm/io.h>
 
 #include "ec.h"

--Boundary-00=_iMQFBWiGWFh42rt--
