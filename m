Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268861AbUIZKee@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268861AbUIZKee (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Sep 2004 06:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269503AbUIZKeC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Sep 2004 06:34:02 -0400
Received: from bhhdoa.org.au ([216.17.101.199]:12548 "EHLO bhhdoa.org.au")
	by vger.kernel.org with ESMTP id S268861AbUIZKd7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Sep 2004 06:33:59 -0400
Date: Sun, 26 Sep 2004 13:32:54 +0300 (EAT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Update 'noapic' description
Message-ID: <Pine.LNX.4.53.0409260354020.2849@musoma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The 'noapic' kernel parameter only disables IOAPIC use and not all the 
APICs (which would include local APICs) in the system.

Signed-off-by: Zwane Mwaikambo <zwane@fsmlabs.com>

Index: linux-2.6.9-rc2-mm3/Documentation/kernel-parameters.txt
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc2-mm3/Documentation/kernel-parameters.txt,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 kernel-parameters.txt
--- linux-2.6.9-rc2-mm3/Documentation/kernel-parameters.txt	24 Sep 2004 14:26:39 -0000	1.1.1.1
+++ linux-2.6.9-rc2-mm3/Documentation/kernel-parameters.txt	26 Sep 2004 00:53:36 -0000
@@ -758,8 +758,8 @@ running once the system is up.
 
 	noalign		[KNL,ARM] 
  
-	noapic		[SMP,APIC] Tells the kernel not to make use of any
-			APIC that may be present on the system.
+	noapic		[SMP,APIC] Tells the kernel to not make use of any
+			IOAPICs that may be present in the system.
 
 	noasync		[HW,M68K] Disables async and sync negotiation for
 			all devices.
