Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154378AbQBJTNY>; Thu, 10 Feb 2000 14:13:24 -0500
Received: by vger.rutgers.edu id <S154808AbQBJSdq>; Thu, 10 Feb 2000 13:33:46 -0500
Received: from interlock2.lexmark.com ([192.146.101.10]:63070 "HELO interlock2.lexmark.com") by vger.rutgers.edu with SMTP id <S155014AbQBJSbq>; Thu, 10 Feb 2000 13:31:46 -0500
Message-Id: <200002102251.RAA14486@interlock2.lexmark.com>
From: Lee Wells <leewells@lexmark.com>
Date: Thu, 10 Feb 2000 17:51:03 -0500 (EST)
To: linux-kernel@vger.rutgers.edu
Subject: [PATCH] arch/mips/config.in
Cc: leewells@lexmark.com
X-Sun-Charset: US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu

A small patch to get the mips builds through a "make config".
Looks like a bunch of include/asm-mips changes coming too.  I'll
post those once I get the kernel to build.

--Lee Wells
leewells@lexmark.com




--- arch/mips/config.in	Wed Feb  9 21:20:23 2000
+++ ../l2342/arch/mips/config.in	Tue Dec  7 18:38:22 1999
@@ -180,8 +180,7 @@
 	    comment '    CCP compressors for PPP are only built as modules.'
 	 fi
          if [ "$CONFIG_SGI" = "y" ]; then
-	    bool '  SGI Seeq ethernet controller support' CONFIG_SGISEEQ
-	 fi
+	 bool '  SGI Seeq ethernet controller support' CONFIG_SGISEEQ
       fi
       if [ "$CONFIG_DECSTATION" = "y" ]; then
          bool '  DEC LANCE ethernet controller support' CONFIG_DECLANCE

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
