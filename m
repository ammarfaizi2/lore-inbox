Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265278AbTLGAoZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 19:44:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265279AbTLGAoZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 19:44:25 -0500
Received: from turing.informatik.uni-halle.de ([141.48.165.110]:34259 "EHLO
	turing.informatik.uni-halle.de") by vger.kernel.org with ESMTP
	id S265278AbTLGAoY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 19:44:24 -0500
Message-ID: <3FD277E5.5000306@abeckmann.de>
Date: Sun, 07 Dec 2003 01:44:21 +0100
From: Andreas Beckmann <sparclinux@abeckmann.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.4] spelling: "Unix 98" -> "Unix98"
Content-Type: multipart/mixed;
 boundary="------------090500090608090107040603"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090500090608090107040603
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

"Unix98" is spelled as "Unix 98" at three locations: the config.in files 
for the architectures sparc64, sh and sh64.
My patch changes these to be "Unix98" like everywhere else.
The defconfig files for these architectures could be regenerated to 
match these changes.


Andreas
Please CC: me in your replies.

--------------090500090608090107040603
Content-Type: text/plain;
 name="2.4_spelling_Unix98.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4_spelling_Unix98.diff"

--- linux-2.4.23/arch/sparc64/config.in.orig	2003-11-28 19:26:19.000000000 +0100
+++ linux-2.4.23/arch/sparc64/config.in	2003-12-05 21:49:04.000000000 +0100
@@ -247,7 +247,7 @@
 
 # This one must be before the filesystem configs. -DaveM
 mainmenu_option next_comment
-comment 'Unix 98 PTY support'
+comment 'Unix98 PTY support'
 bool 'Unix98 PTY support' CONFIG_UNIX98_PTYS
 if [ "$CONFIG_UNIX98_PTYS" = "y" ]; then
    int 'Maximum number of Unix98 PTYs in use (0-2048)' CONFIG_UNIX98_PTY_COUNT 256
--- linux-2.4.23/arch/sh64/config.in.orig	2003-11-28 19:26:19.000000000 +0100
+++ linux-2.4.23/arch/sh64/config.in	2003-12-05 21:48:52.000000000 +0100
@@ -231,7 +231,7 @@
 fi
 
 
-comment 'Unix 98 PTY support'
+comment 'Unix98 PTY support'
 bool 'Unix98 PTY support' CONFIG_UNIX98_PTYS
 if [ "$CONFIG_UNIX98_PTYS" = "y" ]; then
    int 'Maximum number of Unix98 PTYs in use (0-2048)' CONFIG_UNIX98_PTY_COUNT 256
--- linux-2.4.23/arch/sh/config.in.orig	2003-11-28 19:26:19.000000000 +0100
+++ linux-2.4.23/arch/sh/config.in	2003-12-05 21:48:42.000000000 +0100
@@ -369,7 +369,7 @@
 if [ "$CONFIG_SERIAL" = "y" -o "$CONFIG_SH_SCI" = "y" ]; then
    bool '  Support for console on serial port' CONFIG_SERIAL_CONSOLE
 fi
-comment 'Unix 98 PTY support'
+comment 'Unix98 PTY support'
 bool 'Unix98 PTY support' CONFIG_UNIX98_PTYS
 if [ "$CONFIG_UNIX98_PTYS" = "y" ]; then
    int 'Maximum number of Unix98 PTYs in use (0-2048)' CONFIG_UNIX98_PTY_COUNT 256

--------------090500090608090107040603--

