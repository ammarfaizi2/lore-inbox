Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261312AbTCOHg6>; Sat, 15 Mar 2003 02:36:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261313AbTCOHg5>; Sat, 15 Mar 2003 02:36:57 -0500
Received: from pop018pub.verizon.net ([206.46.170.212]:48863 "EHLO
	pop018.verizon.net") by vger.kernel.org with ESMTP
	id <S261312AbTCOHgz>; Sat, 15 Mar 2003 02:36:55 -0500
Message-ID: <3E72DA14.6F6C41BD@verizon.net>
Date: Fri, 14 Mar 2003 23:45:24 -0800
From: "Randy.Dunlap" <randy.dunlap@verizon.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.59 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
CC: viro@math.psu.edu
Subject: [PATCH] typos only
Content-Type: multipart/mixed;
 boundary="------------BBA076EEB25DAB265D117505"
X-Authentication-Info: Submitted using SMTP AUTH at pop018.verizon.net from [4.64.238.61] at Sat, 15 Mar 2003 01:47:39 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------BBA076EEB25DAB265D117505
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

Please apply to 2.5.64-current.
No code changes; still builds OK.

Thanks,
~Randy
--------------BBA076EEB25DAB265D117505
Content-Type: text/plain; charset=us-ascii;
 name="seqfile_typos.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="seqfile_typos.patch"

patch_name:	seqfile_typos.patch
patch_version:	2003-03-14.23:25:36
author:		Randy.Dunlap <rddunlap@osdl.org>
description:	correct typos only;
		(discovered during code review for seq_file_howto)
product:	Linux
product_versions: linux-2.5.64
maintainer:	viro@math.psu.edu
diffstat:	=
 fs/seq_file.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff -Naur ./fs/seq_file.c%SEQ ./fs/seq_file.c
--- ./fs/seq_file.c%SEQ	Tue Mar  4 19:29:31 2003
+++ ./fs/seq_file.c	Fri Mar 14 23:22:12 2003
@@ -1,7 +1,7 @@
 /*
  * linux/fs/seq_file.c
  *
- * helper functions for making syntetic files from sequences of records.
+ * helper functions for making synthetic files from sequences of records.
  * initial implementation -- AV, Oct 2001.
  */
 
@@ -215,7 +215,7 @@
 				while ((retval=traverse(m, offset)) == -EAGAIN)
 					;
 				if (retval) {
-					/* with extreme perjudice... */
+					/* with extreme prejudice... */
 					file->f_pos = 0;
 					m->index = 0;
 					m->count = 0;

--------------BBA076EEB25DAB265D117505--

