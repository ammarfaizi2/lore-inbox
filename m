Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272250AbTG3U7y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 16:59:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272249AbTG3U7y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 16:59:54 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:22223 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S272247AbTG3U7v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 16:59:51 -0400
Date: Wed, 30 Jul 2003 22:59:35 +0200
From: Pavel Machek <pavel@ucw.cz>
To: alan@redhat.com, kernel list <linux-kernel@vger.kernel.org>
Subject: Warn about taskfile?
Message-ID: <20030730205935.GA238@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I had some strange fs corruption, and andi suggested that it probably
is TASKFILE-related. Perhaps this is good idea?

								Pavel

--- clean/drivers/ide/Kconfig	2003-07-27 22:31:13.000000000 +0200
+++ linux/drivers/ide/Kconfig	2003-07-30 22:56:50.000000000 +0200
@@ -283,7 +283,8 @@
 	---help---
 	  Use new taskfile IO code.
 
-	  It is safe to say Y to this question, in most cases.
+	  It is safe to say Y to this question, but you should attach
+	  scratch monkey, first.
 
 comment "IDE chipset support/bugfixes"
 	depends on BLK_DEV_IDE

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
