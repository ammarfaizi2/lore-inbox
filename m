Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263805AbTCUSvn>; Fri, 21 Mar 2003 13:51:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263808AbTCUSul>; Fri, 21 Mar 2003 13:50:41 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:25732
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263799AbTCUStq>; Fri, 21 Mar 2003 13:49:46 -0500
Date: Fri, 21 Mar 2003 20:05:02 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303212005.h2LK52vr026230@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: fix typo in oom_kill
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/mm/oom_kill.c linux-2.5.65-ac2/mm/oom_kill.c
--- linux-2.5.65/mm/oom_kill.c	2003-03-06 17:04:37.000000000 +0000
+++ linux-2.5.65-ac2/mm/oom_kill.c	2003-03-20 18:43:25.000000000 +0000
@@ -51,7 +51,7 @@
  * 3) we don't kill anything innocent of eating tons of memory
  * 4) we want to kill the minimum amount of processes (one)
  * 5) we try to kill the process the user expects us to kill, this
- *    algorithm has been meticulously tuned to meet the priniciple
+ *    algorithm has been meticulously tuned to meet the principle
  *    of least surprise ... (be careful when you change it)
  */
 
