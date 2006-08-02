Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932130AbWHBSu6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932130AbWHBSu6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 14:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932144AbWHBSu6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 14:50:58 -0400
Received: from ik55118.ikexpress.com ([213.246.55.118]:60395 "EHLO
	ik55118.ikexpress.com") by vger.kernel.org with ESMTP
	id S932130AbWHBSu5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 14:50:57 -0400
From: Michael Opdenacker <michael-lists@free-electrons.com>
Organization: Free Electrons
To: linux-kernel@vger.kernel.org
Subject: [PATCH] reboot parameter in Documentation/kernel-parameters.txt
Date: Wed, 2 Aug 2006 20:50:16 +0200
User-Agent: KMail/1.9.1
Cc: trivial@kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608022050.16427.michael-lists@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation fix for the arm and arm26 architectures,
in which the reboot kernel parameter is set in arch/*/kernel/process.c

Signed-off-by: Michael Opdenacker <michael@free-electrons.com>

--- linux-2.6.17/Documentation/kernel-parameters.txt	2006-06-18 
03:49:35.000000000 +0200
+++ linux-2.6.17-kernel-param-doc/Documentation/kernel-parameters.txt	
2006-08-02 17:02:33.000000000 +0200
@@ -1336,7 +1336,7 @@ running once the system is up.
 
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
