Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129663AbQLRTCM>; Mon, 18 Dec 2000 14:02:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129927AbQLRTBy>; Mon, 18 Dec 2000 14:01:54 -0500
Received: from artoo.hitchcock.org ([130.189.184.185]:46093 "EHLO
	artoo.hitchcock.org") by vger.kernel.org with ESMTP
	id <S129663AbQLRTBv>; Mon, 18 Dec 2000 14:01:51 -0500
Message-id: <177455@anoat.hitchcock.org.artoo.hitchcock.org>
Date: 18 Dec 2000 13:30:19 EST
From: William.P.McGonigle@artoo.hitchcock.org (William P. McGonigle)
Reply-To: Bill.McGonigle@hitchcock.org
Subject: [PATCH] Configure.help (CONFIG_ATALK/appletalk.o)
To: axel@uni-paderborn.de
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Axel,

	The following patch to the help section for appletalk.o:

  * Updates a reference URL to a permanent (non-employer dependent) location. 
The old URL has been redirecting here for a while.
  * Explains why you'd be crazy to not compile appletalk as a module.
 
  I attempted to align the word wrapping to account for the difference in text
size.

-Bill


--- linux-2.4.0-test12/Documentation/Configure.help	Mon Dec 18 12:56:47 2000
+++ linux/Documentation/Configure.help	Mon Dec 18 13:05:49 2000
@@ -4138,11 +4138,10 @@
   want to join the conversation, say Y. You will need to use the
   netatalk package so that your Linux box can act as a print and file
   server for Macs as well as access AppleTalk printers. Check out
-  http://threepio.hitchcock.org/cgi-bin/faq/netatalk/faq.pl on the WWW
-  for details. EtherTalk is the name used for AppleTalk over Ethernet
-  and the cheaper and slower LocalTalk is AppleTalk over a proprietary
-  Apple network using serial links. EtherTalk and LocalTalk are fully
-  supported by Linux.
+  http://www.zettabyte.net/netatalk/ on the WWW for details. EtherTalk 
+  is the name used for AppleTalk over Ethernet and the cheaper and 
+  slower LocalTalk is AppleTalk over a proprietary Apple network using
+  serial links. EtherTalk and LocalTalk are fully supported by Linux.
 
   General information about how to connect Linux, Windows machines and
   Macs is on the WWW at http://www.eats.com/linux_mac_win.html . The
@@ -4153,8 +4152,10 @@
   This driver is also available as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want).
   The module is called appletalk.o. If you want to compile it as a
-  module, say M here and read Documentation/modules.txt. I hear that
-  the GNU boycott of Apple is over, so even politically correct people
+  module, say M here and read Documentation/modules.txt.  You almost
+  certainly want to compile it as a module so you can restart your 
+  AppleTalk stack without rebooting your machine.  I hear that the 
+  GNU boycott of Apple is over, so even politically correct people
   are allowed to say Y here.
 
 AppleTalk-IP driver support
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
