Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266744AbTGFW0l (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 18:26:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266747AbTGFW03
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 18:26:29 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:59827 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S266744AbTGFW0Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 18:26:24 -0400
Date: Mon, 7 Jul 2003 00:40:55 +0200 (MEST)
Message-Id: <200307062240.h66Met8h023829@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: ak@suse.de
Subject: [PATCH][2.4.22-pre3] minor x86-64 boot-options.txt update
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Minor documentation update. If we need to tell users that
nmi_watchdog=2 claims one performance counter, we should
tell them that the local APIC LVTPC vector is claimed too.

/Mikael

--- linux-2.4.22-pre3/Documentation/x86_64/boot-options.txt.~1~	2003-07-06 18:37:42.000000000 +0200
+++ linux-2.4.22-pre3/Documentation/x86_64/boot-options.txt	2003-07-06 19:21:06.000000000 +0200
@@ -65,7 +65,8 @@
   0 don't use an NMI watchdog
   1 use the IO-APIC timer for the NMI watchdog
   2 use the local APIC for the NMI watchdog using a performance counter. Note
-  This will use one performance counter.
+  This will use one performance counter and the local APIC's performance
+  counter vector.
 
 Idle loop
 
