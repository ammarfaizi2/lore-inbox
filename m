Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268787AbTBZPvP>; Wed, 26 Feb 2003 10:51:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268790AbTBZPvP>; Wed, 26 Feb 2003 10:51:15 -0500
Received: from bilbo.math.uni-mannheim.de ([134.155.88.153]:32441 "HELO
	bilbo.math.uni-mannheim.de") by vger.kernel.org with SMTP
	id <S268787AbTBZPvP>; Wed, 26 Feb 2003 10:51:15 -0500
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.5.63] typo in Makefile
Date: Wed, 26 Feb 2003 17:02:29 +0100
User-Agent: KMail/1.5
Cc: Linus Torvalds <torvalds@transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200302261702.29970@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's typo time. Looks like an "off by one" on the keyboard.

Please apply,

Eike

--- linux-2.5.63/Makefile	Mon Feb 24 20:05:08 2003
+++ linux-2.5.63-eike/Makefile	Wed Feb 26 16:58:13 2003
@@ -580,7 +580,7 @@
 	. scripts/mkspec >kernel.spec
 
 #	Build a tar ball, generate an rpm from it and pack the result
-#	There arw two bits of magic here
+#	There are two bits of magic here
 #	1) The use of /. to avoid tar packing just the symlink
 #	2) Removing the .dep files as they have source paths in them that
 #	   will become invalid
