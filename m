Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261279AbVBMRL4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261279AbVBMRL4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Feb 2005 12:11:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261286AbVBMRL4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Feb 2005 12:11:56 -0500
Received: from cantor.suse.de ([195.135.220.2]:59304 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261279AbVBMRLz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Feb 2005 12:11:55 -0500
Date: Sun, 13 Feb 2005 18:11:53 +0100
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH] typos in toplevel Makefile
Message-ID: <20050213171153.GA24061@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


fix two typos.

Signed-off-by: Olaf Hering <olh@suse.de>

diff -purNx tags ../linux-2.6.11-rc4.orig/Makefile ./Makefile
--- ../linux-2.6.11-rc4.orig/Makefile	2005-02-13 04:06:56.000000000 +0100
+++ ./Makefile	2005-02-13 16:48:22.000000000 +0100
@@ -539,7 +539,7 @@ CFLAGS += $(call cc-option,-Wno-pointer-
 # Default kernel image to build when no specific target is given.
 # KBUILD_IMAGE may be overruled on the commandline or
 # set in the environment
-# Also any assingments in arch/$(ARCH)/Makefiel take precedence over
+# Also any assignments in arch/$(ARCH)/Makefile take precedence over
 # this default value
 export KBUILD_IMAGE ?= vmlinux
 
