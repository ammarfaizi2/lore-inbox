Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265279AbTLGAzk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 19:55:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265280AbTLGAzk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 19:55:40 -0500
Received: from turing.informatik.Uni-Halle.DE ([141.48.9.50]:3802 "EHLO
	turing.informatik.uni-halle.de") by vger.kernel.org with ESMTP
	id S265279AbTLGAzi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 19:55:38 -0500
Message-ID: <3FD27A88.2050802@abeckmann.de>
Date: Sun, 07 Dec 2003 01:55:36 +0100
From: Andreas Beckmann <sparclinux@abeckmann.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6] spelling: "Unix 98" -> "Unix98"
Content-Type: multipart/mixed;
 boundary="------------050603090300010703050301"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050603090300010703050301
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

"Unix98" is spelled as "Unix 98" at two locations: the Kconfig files for 
the architectures sparc64 and sh.
My patch changes these to be "Unix98" like everywhere else.
The defconfig files for these architectures could be regenerated to 
match these changes.


Andreas
Please CC: me in your replies.

--------------050603090300010703050301
Content-Type: text/plain;
 name="2.6_spelling_Unix98.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.6_spelling_Unix98.diff"

--- linux-2.6.0-test11/arch/sparc64/Kconfig.orig	2003-11-26 21:45:28.000000000 +0100
+++ linux-2.6.0-test11/arch/sparc64/Kconfig	2003-12-07 01:45:01.000000000 +0100
@@ -655,7 +655,7 @@
 
 # This one must be before the filesystem configs. -DaveM
 
-menu "Unix 98 PTY support"
+menu "Unix98 PTY support"
 
 config UNIX98_PTYS
 	bool "Unix98 PTY support"
--- linux-2.6.0-test11/arch/sh/Kconfig.orig	2003-11-26 21:45:53.000000000 +0100
+++ linux-2.6.0-test11/arch/sh/Kconfig	2003-12-07 01:48:35.000000000 +0100
@@ -887,7 +887,7 @@
 
 	  If unsure, say N.
 
-comment "Unix 98 PTY support"
+comment "Unix98 PTY support"
 
 config UNIX98_PTYS
 	bool "Unix98 PTY support"

--------------050603090300010703050301--

