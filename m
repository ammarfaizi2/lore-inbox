Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292817AbSCJJlK>; Sun, 10 Mar 2002 04:41:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292987AbSCJJkv>; Sun, 10 Mar 2002 04:40:51 -0500
Received: from 99dyn73.com21.casema.net ([62.234.30.73]:1961 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S292817AbSCJJkk>; Sun, 10 Mar 2002 04:40:40 -0500
Message-Id: <200203100940.g2A9eZu14509@abraracourcix.bitwizard.nl>
Subject: khttpd trival fix. 
To: linux-kernel@vger.kernel.org
Date: Sun, 10 Mar 2002 10:40:34 +0100 (CET)
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-notice1: This Email contains my Email address. This grants you the right
X-notice2: to communicate with me using this address, related to the subject
X-notice3: in this message. Unsollicitated mass-mailings are explictly
X-notice4: forbidden here, and by Dutch law.
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

There is a typo in khttpd/socket.c.  ("EnterFunction" instead of 
"LeaveFunction")

		Roger. 


diff -ur linux-2.4.19-pre2.clean/net/khttpd/sockets.c linux-2.4.19-pre2.khttpd_patch/net/khttpd/sockets.c
--- linux-2.4.19-pre2.clean/net/khttpd/sockets.c	Mon Mar 27 20:35:57 2000
+++ linux-2.4.19-pre2.khttpd_patch/net/khttpd/sockets.c	Sun Mar 10 10:36:10 2002
@@ -82,7 +82,7 @@
 	
 	MainSocket = sock;
 	
-	EnterFunction("StartListening");
+	LeaveFunction("StartListening");
 	return 1; 
 }	
 
-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
