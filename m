Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131560AbRCNVz3>; Wed, 14 Mar 2001 16:55:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131561AbRCNVzT>; Wed, 14 Mar 2001 16:55:19 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:7684 "HELO
	postfix.conectiva.com.br") by vger.kernel.org with SMTP
	id <S131560AbRCNVzH>; Wed, 14 Mar 2001 16:55:07 -0500
Date: Thu, 15 Mar 2001 02:07:10 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] found small type in Documentation/sysctl/vm.txt (fwd)
Message-ID: <Pine.LNX.4.33.0103150206330.21132-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan, Linus,

could you please apply Marty's patch for the next pre-kernel ?

thanks,

Rik
---------- Forwarded message ----------
Date: Wed, 14 Mar 2001 15:17:05 -0500
From: Marty Leisner <mleisner@eng.mc.xerox.com>
To: riel@nl.linux.org
Subject: found small type in Documentation/sysctl/vm.txt


I was looking through the documentation to understand the /proc
stuff...

Looked in the wrong place...

Mistake is also in 2.4.2..

:1 leisner@thingy; rcsdiff -u vm.txt
===================================================================
RCS file: vm.txt,v
retrieving revision 1.1
diff -u -r1.1 vm.txt
--- vm.txt      2001/03/14 20:11:27     1.1
+++ vm.txt      2001/03/14 20:11:43
@@ -32,7 +32,7 @@

 This file controls the operation of the bdflush kernel
 daemon. The source code to this struct can be found in
-linux/mm/buffer.c. It currently contains 9 integer values,
+linux/fs/buffer.c. It currently contains 9 integer values,
 of which 6 are actually used by the kernel.

 From linux/fs/buffer.c:


marty		mleisner@eng.mc.xerox.com
Don't  confuse education with schooling.
	Milton Friedman to Yogi Berra

