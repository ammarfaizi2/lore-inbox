Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262645AbSI3Q3B>; Mon, 30 Sep 2002 12:29:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262541AbSI3Q2f>; Mon, 30 Sep 2002 12:28:35 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:8133 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S262492AbSI3Q1S>; Mon, 30 Sep 2002 12:27:18 -0400
Date: Mon, 30 Sep 2002 18:32:37 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Linus Torvalds <torvalds@transmeta.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [patch] update SubmittingDrivers
Message-ID: <Pine.NEB.4.44.0209301823020.12605-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The patch below makes the following changes to SubmittingDrivers:

- document that not only 2.2 and 2.4 are covered by it
- update the information for 2.4
- include information for 2.5
- fix a very long line in Licensing
- Portability: add "not all computers are little endian"


cu
Adrian


--- linux-2.4.19/Documentation/SubmittingDrivers.old	2002-09-30 18:14:51.000000000 +0200
+++ linux-2.4.19/Documentation/SubmittingDrivers	2002-09-30 18:31:33.000000000 +0200
@@ -2,9 +2,8 @@
 ---------------------------------------

 This document is intended to explain how to submit device drivers to the
-Linux 2.2 and 2.4 kernel trees. Note that if you are interested in video
-card drivers you should probably talk to XFree86 (http://www.xfree86.org)
-instead.
+various kernel trees. Note that if you are interested in video card drivers
+you should probably talk to XFree86 (http://www.xfree86.org) instead.

 Also read the Documentation/SubmittingPatches document.

@@ -35,21 +34,23 @@
 	maintainer then please contact Alan Cox <alan@lxorguk.ukuu.org.uk>

 Linux 2.4:
-	This kernel tree is under active development. The same rules apply
-	as 2.2 but you may wish to submit your driver via linux-kernel (see
-	resources) and follow that list to track changes in API's. These
-	should no longer be occuring as we are now in a code freeze.
-	The final contact point for Linux 2.4 submissions is
-	<torvalds@transmeta.com>.
+	The same rules apply as 2.2 but this kernel tree is under active
+	development. The final contact point for Linux 2.4 submissions is
+	Marcelo Tosatti <marcelo@conectiva.com.br>.
+
+Linux 2.5:
+	The same rules apply as 2.4 but you should follow linux-kernel
+	to track changes in API's. The final contact point for Linux 2.5
+	submissions is Linus Torvalds <torvalds@transmeta.com>.

 What Criteria Determine Acceptance
 ----------------------------------

-Licensing:	The code must be released to us under the GNU General Public License.
-		We don't insist on any kind of exclusively GPL licensing,
-		and if you wish the driver to be useful to other communities
-		such as BSD you may well wish to release under multiple
-		licenses.
+Licensing:	The code must be released to us under the
+		GNU General Public License. We don't insist on any kind
+		of exclusively GPL licensing, and if you wish the driver
+		to be useful to other communities such as BSD you may well
+		wish to release under multiple licenses.

 Interfaces:	If your driver uses existing interfaces and behaves like
 		other drivers in the same class it will be much more likely
@@ -64,12 +65,13 @@
 		maintain them just once seperate them out nicely and note
 		this fact.

-Portability:	Pointers are not always 32bits, people do not all have
-		floating point and you shouldn't use inline x86 assembler in
-		your driver without careful thought. Pure x86 drivers
-		generally are not popular. If you only have x86 hardware it
-		is hard to test portability but it is easy to make sure the
-		code can easily be made portable.
+Portability:	Pointers are not always 32bits, not all computers are little
+		endian, people do not all have floating point and you
+		shouldn't use inline x86 assembler in your driver without
+		careful thought. Pure x86 drivers generally are not popular.
+		If you only have x86 hardware it is hard to test portability
+		but it is easy to make sure the code can easily be made
+		portable.

 Clarity:	It helps if anyone can see how to fix the driver. It helps
 		you because you get patches not bug reports. If you submit a

