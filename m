Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263930AbTE3Tn7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 15:43:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263936AbTE3Tn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 15:43:59 -0400
Received: from mailrelay2.lanl.gov ([128.165.4.103]:53739 "EHLO
	mailrelay2.lanl.gov") by vger.kernel.org with ESMTP id S263930AbTE3Tn6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 15:43:58 -0400
Subject: [PATCH] 2.5 Documentation/CodingStyle ANSI C function declarations.
From: Steven Cole <elenstev@mesatop.com>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Content-Type: text/plain
Organization: 
Message-Id: <1054324633.3754.119.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 30 May 2003 13:57:13 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maybe the following should be unnecessary after all these years since
the ANSI C standard was introduced, but several files associated with
zlib were using the old-style function declaration.

So, here is a proposed addition to CodingStyle, just to make it clear.

Steven


--- bk-current/Documentation/CodingStyle	Fri May 30 09:20:33 2003
+++ linux/Documentation/CodingStyle	Fri May 30 13:16:30 2003
@@ -149,6 +149,21 @@
 and it gets confused.  You know you're brilliant, but maybe you'd like
 to understand what you did 2 weeks from now. 
 
+Function declarations should be new-style:
+
+int foo(long bar, long day, struct magic *xyzzy)
+or
+int foo(
+	long bar,
+	long day,
+	struct magic *xyzzy
+)
+
+Old-style function declarations are deprecated:
+
+int foo(bar, day, xyzzy)
+long bar, day;
+struct magic *xyzzy;
 
 		Chapter 5: Commenting
 



