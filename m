Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261607AbUKISXf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261607AbUKISXf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 13:23:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261609AbUKISXf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 13:23:35 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:23549 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261607AbUKISX1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 13:23:27 -0500
Message-ID: <41910B1B.2040707@mvista.com>
Date: Tue, 09 Nov 2004 11:23:23 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: akpm <akpm@osdl.org>
CC: lkml <linux-kernel@vger.kernel.org>, linuxppc-embedded@ozlabs.org
Subject: [PATCH][PPC32] Remove CONFIG_SERIAL_CONSOLE_BAUD
Content-Type: multipart/mixed;
 boundary="------------010909070104020104080700"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.
--------------010909070104020104080700
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

No longer needed.

Signed-off-by: Mark Greer <mgreer@mvista.com>

--------------010909070104020104080700
Content-Type: text/plain;
 name="Kconfig.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Kconfig.patch"

diff -Nru a/arch/ppc/Kconfig b/arch/ppc/Kconfig
--- a/arch/ppc/Kconfig	2004-11-09 11:20:59 -07:00
+++ b/arch/ppc/Kconfig	2004-11-09 11:20:59 -07:00
@@ -757,11 +757,6 @@
 	bool "PC PS/2 style Keyboard"
 	depends on 4xx || CPM2
 
-config SERIAL_CONSOLE_BAUD
-	int
-	depends on EV64260
-	default "115200"
-
 config PPCBUG_NVRAM
 	bool "Enable reading PPCBUG NVRAM during boot" if PPLUS || LOPEC
 	default y if PPC_PREP

--------------010909070104020104080700--

