Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262652AbUAYAfe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 19:35:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263388AbUAYAfe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 19:35:34 -0500
Received: from hera.cwi.nl ([192.16.191.8]:38385 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S262652AbUAYAf2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 19:35:28 -0500
From: Andries.Brouwer@cwi.nl
Date: Sun, 25 Jan 2004 01:35:19 +0100 (MET)
Message-Id: <UTC200401250035.i0P0ZJW13717.aeb@smtp.cwi.nl>
To: akpm@osdl.org, torvalds@osdl.org
Subject: [uPATCH] ufs.txt update
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If the previous patch is applied, the phrase "default value,"
should be deleted in ufs.txt.
In any case, the option "ufstype=hp" should be documented.

Andries

--- /linux/2.6/linux-2.6.1/linux/Documentation/filesystems/ufs.txt	2003-12-18 03:59:06.000000000 +0100
+++ ufs.txt	2004-01-25 01:33:34.000000000 +0100
@@ -15,7 +15,7 @@
 	ufs manually by mount option ufstype. Possible values are:
 
 	old	old format of ufs
-		default value, supported os read-only
+		supported os read-only
 
 	44bsd	used in FreeBSD, NetBSD, OpenBSD
 		supported os read-write
@@ -26,6 +26,9 @@
 	sunx86	used in SunOS for Intel (Solarisx86)
 		supported as read-write
 
+	hp	used in HP-UX
+		supported as read-only
+
 	nextstep
 		used in NextStep
 		supported as read-only
