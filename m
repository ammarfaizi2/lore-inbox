Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264915AbSLLXxM>; Thu, 12 Dec 2002 18:53:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267544AbSLLXxM>; Thu, 12 Dec 2002 18:53:12 -0500
Received: from gandalf.math.uni-mannheim.de ([134.155.88.152]:23813 "EHLO
	gandalf.math.uni-mannheim.de") by vger.kernel.org with ESMTP
	id <S264915AbSLLXxL>; Thu, 12 Dec 2002 18:53:11 -0500
Content-Type: text/plain; charset=US-ASCII
From: Matthias Juchem <lists@konfido.de>
Reply-To: lists@konfido.de
To: torvalds@transmeta.com
Subject: [PATCHlet] Documentation/SubmittingPatches
Date: Fri, 13 Dec 2002 01:00:55 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E18MdGB-0002Qp-00@gandalf.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

This little patch shall reflect that the kernel tree is now extracted to 
linux-x.y.z instead of linux.
Besides, it updates the version number in the examples.

Diff is against 2.5.51.

Regards,
 Matthias

diff -urN linux-2.5.51/Documentation/SubmittingPatches 
linux-2.5.51-mj/Documentation/SubmittingPatches
--- linux-2.5.51/Documentation/SubmittingPatches	Tue Dec 10 03:45:42 2002
+++ linux-2.5.51-mj/Documentation/SubmittingPatches	Fri Dec 13 00:44:16 2002
@@ -33,7 +33,7 @@
 
 To create a patch for a single file, it is often sufficient to do:
 
-	SRCTREE= /devel/linux-2.4
+	SRCTREE= /devel/linux-2.5
 	MYFILE=  drivers/net/mydriver.c
 
 	cd $SRCTREE
@@ -45,10 +45,10 @@
 or unmodified kernel source tree, and generate a diff against your
 own source tree.  For example:
 
-	MYSRC= /devel/linux-2.4
+	MYSRC= /devel/linux-2.5
 
-	tar xvfz linux-2.4.0-test11.tar.gz
-	mv linux linux-vanilla
+	tar xvfz linux-2.5.51.tar.gz
+	mv linux-2.5.51 linux-vanilla
 	wget http://www.moses.uklinux.net/patches/dontdiff
 	diff -urN -X dontdiff linux-vanilla $MYSRC > /tmp/patch
 	rm -f dontdiff
