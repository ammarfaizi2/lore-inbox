Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275891AbTHOKFw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 06:05:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275892AbTHOKFw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 06:05:52 -0400
Received: from hal-4.inet.it ([213.92.5.23]:2992 "EHLO hal-4.inet.it")
	by vger.kernel.org with ESMTP id S275891AbTHOKFv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 06:05:51 -0400
From: Paolo Ornati <javaman@katamail.com>
To: torvalds@osdl.org
Subject: [PATCH 2.6.x] stupid fix for Documentation
Date: Fri, 15 Aug 2003 12:05:15 +0200
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308151205.15582.javaman@katamail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
this is a stupid fix for Documentation/kbuild/makefiles.txt :-)

--- linux/Documentation/kbuild/makefiles.txt.orig	2003-08-15 11:47:30.000000000 +0200
+++ linux/Documentation/kbuild/makefiles.txt	2003-08-15 11:47:53.000000000 +0200
@@ -256,7 +256,7 @@
 
 	Example:
 		#fs/Makefile
-		obj-$(CONfIG_EXT2_FS) += ext2/
+		obj-$(CONFIG_EXT2_FS) += ext2/
 
 	If CONFIG_EXT2_FS is set to either 'y' (built-in) or 'm' (modular)
 	the corresponding obj- variable will be set, and kbuild will descend

