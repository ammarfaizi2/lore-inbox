Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261651AbVDJXXm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261651AbVDJXXm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 19:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261649AbVDJXW1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 19:22:27 -0400
Received: from hermes.domdv.de ([193.102.202.1]:1032 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S261644AbVDJXT3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 19:19:29 -0400
Message-ID: <4259B480.6010506@domdv.de>
Date: Mon, 11 Apr 2005 01:19:28 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: [PATCH encrypted swsusp 3/3] documentation
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------090005070406060904030602"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090005070406060904030602
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

The following patch adds some information for encrypted suspend to the
swsusp documentation.
-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de



--------------090005070406060904030602
Content-Type: text/plain;
 name="swsusp-encrypt-info.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="swsusp-encrypt-info.diff"

--- linux-2.6.11.2/Documentation/power/swsusp.txt.ast	2005-04-10 21:07:01.000000000 +0200
+++ linux-2.6.11.2/Documentation/power/swsusp.txt	2005-04-10 21:10:56.000000000 +0200
@@ -30,6 +30,13 @@
 echo platform > /sys/power/disk; echo disk > /sys/power/state
 
 
+Encrypted suspend image:
+------------------------
+If you want to store your suspend image encrypted with a temporary
+key to prevent data gathering after resume you must compile
+crypto and the aes algorithm into the kernel - modules won't work
+as they cannot be loaded at resume time.
+
 
 Article about goals and implementation of Software Suspend for Linux
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



--------------090005070406060904030602--
