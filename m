Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266141AbTGROAw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 10:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271762AbTGRNzA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 09:55:00 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:13189
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S271754AbTGRNwy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 09:52:54 -0400
Date: Fri, 18 Jul 2003 15:07:15 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307181407.h6IE7FGM017678@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: pnp layer seems to document wrong file name
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Jochen Hein)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test1/Documentation/pnp.txt linux-2.6.0-test1-ac2/Documentation/pnp.txt
--- linux-2.6.0-test1/Documentation/pnp.txt	2003-07-10 21:05:27.000000000 +0100
+++ linux-2.6.0-test1-ac2/Documentation/pnp.txt	2003-07-15 17:28:31.000000000 +0100
@@ -22,7 +22,7 @@
 In addition to the standard driverfs file the following are created in each 
 device's directory:
 id - displays a list of support EISA IDs
-possible - displays possible resource configurations
+options - displays possible resource configurations
 resources - displays currently allocated resources and allows resource changes
 
 -activating a device
@@ -60,7 +60,7 @@
 - Notice the string "DISABLED".  THis means the device is not active.
 
 3.) check the device's possible configurations (optional)
-# cat possible
+# cat options
 Dependent: 01 - Priority acceptable
     port 0x3f0-0x3f0, align 0x7, size 0x6, 16-bit address decoding
     port 0x3f7-0x3f7, align 0x0, size 0x1, 16-bit address decoding
