Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270692AbTHAIdL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 04:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275194AbTHAIdL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 04:33:11 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:28823
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S270692AbTHAIdK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 04:33:10 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH][Trivial] documentation fix: driverfs->sysfs.
Date: Fri, 1 Aug 2003 04:35:33 -0400
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200308010050.33136.rob@landley.net>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch against -test2.

diff -u linux-old/arch/i386/Kconfig linux-2.6.0-test2/arch/i386/Kconfig
--- linux-old/arch/i386/Kconfig 2003-07-27 12:57:48.000000000 -0400
+++ linux-2.6.0-test2/arch/i386/Kconfig 2003-08-01 00:45:44.000000000 -0400
@@ -621,7 +621,7 @@
        help
          Say Y or M here if you want to enable BIOS Enhanced Disk Drive
          Services real mode BIOS calls to determine which disk
-         BIOS tries boot from.  This information is then exported via driverfs.
+         BIOS tries boot from.  This information is then exported via sysfs.

          This option is experimental, but believed to be safe,
          and most disk controller BIOS vendors do not yet implement this feature.

Rob


