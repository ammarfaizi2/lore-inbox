Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267281AbSLEKqE>; Thu, 5 Dec 2002 05:46:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267279AbSLEKqD>; Thu, 5 Dec 2002 05:46:03 -0500
Received: from holomorphy.com ([66.224.33.161]:42377 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267268AbSLEKqC>;
	Thu, 5 Dec 2002 05:46:02 -0500
Date: Thu, 05 Dec 2002 02:52:59 -0800
From: wli@holomorphy.com
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, kernel-janitor-discuss@lists.sourceforge.net,
       rmk@arm.linux.org.uk, jgarzik@pobox.com, miura@da-cha.org,
       alan@lxorguk.ukuu.org.uk, viro@math.psu.edu, pavel@ucw.cz
Subject: [warnings] [1/8] fix hugetlbfs security.h problem
Message-ID: <0212050252.hdcd1a.b3aUbzb5bCbGc3dkcCd8a1atc20143@holomorphy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <0212050252.ZakdfbOcNbscMdIa~a.cRahaUambTcPa20143@holomorphy.com>
X-Mailer: patchbomb 0.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Include <linux/security.h.> to get a definition of
security_inode_setattr() etc. I guess I ack this myself.

===== fs/hugetlbfs/inode.c 1.5 vs edited =====
--- 1.5/fs/hugetlbfs/inode.c	Wed Nov 27 15:09:41 2002
+++ edited/fs/hugetlbfs/inode.c	Thu Dec  5 00:46:58 2002
@@ -23,7 +23,7 @@
 #include <linux/pagevec.h>
 #include <linux/quotaops.h>
 #include <linux/dnotify.h>
-
+#include <linux/security.h>
 #include <asm/uaccess.h>
 
 /* some random number */
