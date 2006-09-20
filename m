Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750783AbWITUuw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbWITUuw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 16:50:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750786AbWITUuv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 16:50:51 -0400
Received: from free-electrons.com ([88.191.23.47]:31398 "EHLO
	sd-2511.dedibox.fr") by vger.kernel.org with ESMTP id S1750783AbWITUuu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 16:50:50 -0400
From: Michael Opdenacker <michael-lists@free-electrons.com>
Organization: Free Electrons
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.18] reboot parameter in Documentation/kernel-parameters.txt
Date: Wed, 20 Sep 2006 22:49:40 +0200
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609202249.40454.michael-lists@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation fix for the arm and arm26 architectures,
in which the reboot kernel parameter is set in arch/*/kernel/process.c

Signed-off-by: Michael Opdenacker <michael@free-electrons.com>

--- linux-2.6.18/Documentation/kernel-parameters.txt	2006-09-20 
05:42:06.000000000 +0200
+++ linux-2.6.18-kernel-param-doc/Documentation/kernel-parameters.txt	
2006-09-20 22:41:42.000000000 +0200
@@ -1359,7 +1359,7 @@ running once the system is up.
 
 	reboot=		[BUGS=IA-32,BUGS=ARM,BUGS=IA-64] Rebooting mode
 			Format: <reboot_mode>[,<reboot_mode2>[,...]]
-			See arch/*/kernel/reboot.c.
+			See arch/*/kernel/reboot.c or arch/*/kernel/process.c			
 
 	reserve=	[KNL,BUGS] Force the kernel to ignore some iomem area
 

-- 
Michael Opdenacker, Free Electrons
Free Embedded Linux Training Materials
on http://free-electrons.com/training
(More than 1000 pages!)
