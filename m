Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264604AbTIDDa2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 23:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264627AbTIDDa2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 23:30:28 -0400
Received: from dp.samba.org ([66.70.73.150]:8640 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264604AbTIDDaP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 23:30:15 -0400
From: Rusty Trivial Russell <trivial@rustcorp.com.au>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [TRIVIAL] Add hint on sysrq on some keyboards
Date: Thu, 04 Sep 2003 13:23:20 +1000
Message-Id: <20030904033015.483D02C0DA@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From:  Pavel Machek <pavel@suse.cz>

  Hi!
  
  This trick is maybe nontrivial... and it is needed on many
  machines. Please apply,
  							Pavel
  

--- trivial-2.6.0-test4-bk5/Documentation/sysrq.txt.orig	2003-09-04 13:01:55.000000000 +1000
+++ trivial-2.6.0-test4-bk5/Documentation/sysrq.txt	2003-09-04 13:01:55.000000000 +1000
@@ -22,7 +22,10 @@
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 On x86   - You press the key combo 'ALT-SysRq-<command key>'. Note - Some
            keyboards may not have a key labeled 'SysRq'. The 'SysRq' key is
-           also known as the 'Print Screen' key.
+           also known as the 'Print Screen' key. Also some keyboards can not
+	   handle so many keys being pressed at the same time, so you might
+	   have better luck with "press Alt", "press SysRq", "release Alt",
+	   "press <command key>", release everything.
 
 On SPARC - You press 'ALT-STOP-<command key>', I believe.
 
-- 
  What is this? http://www.kernel.org/pub/linux/kernel/people/rusty/trivial/
  Don't blame me: the Monkey is driving
  File: Pavel Machek <pavel@suse.cz>: Add hint on sysrq on some keyboards
