Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271240AbTHLX7f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 19:59:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271239AbTHLX7f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 19:59:35 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:41862 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S271245AbTHLX7d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 19:59:33 -0400
Date: Wed, 13 Aug 2003 01:58:54 +0200
From: Pavel Machek <pavel@suse.cz>
To: Rusty trivial patch monkey Russell <trivial@rustcorp.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Add hint on sysrq on some keyboards
Message-ID: <20030812235848.GD306@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This trick is maybe nontrivial... and it is needed on many
machines. Please apply,
							Pavel

--- /usr/src/tmp/linux/Documentation/sysrq.txt	2003-03-27 10:39:46.000000000 +0100
+++ /usr/src/linux/Documentation/sysrq.txt	2003-08-13 00:55:53.000000000 +0200
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
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
