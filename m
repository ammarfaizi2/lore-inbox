Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965075AbVITSti@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965075AbVITSti (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 14:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965072AbVITSsk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 14:48:40 -0400
Received: from ppp-62-11-78-183.dialup.tiscali.it ([62.11.78.183]:14784 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S965075AbVITSsV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 14:48:21 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 4/7] README update from the stone age
Date: Tue, 20 Sep 2005 20:45:44 +0200
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Message-Id: <20050920184544.14557.15273.stgit@zion.home.lan>
In-Reply-To: <20050920184513.14557.8152.stgit@zion.home.lan>
References: <20050920184513.14557.8152.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We have no options which the user can set in the Makefile. Only the
EXTRAVERSION, which is also useful in place of the "backup modules"
suggestion.

Hey! Can anybody tell me when we last had configuration options in the top
Makefile? Please?

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 README |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/README b/README
--- a/README
+++ b/README
@@ -149,6 +149,9 @@ CONFIGURING the kernel:
 	"make gconfig"     X windows (Gtk) based configuration tool.
 	"make oldconfig"   Default all questions based on the contents of
 			   your existing ./.config file.
+	"make silentoldconfig"
+			   Like above, but avoids cluttering the screen
+			   with question already answered.
    
 	NOTES on "make config":
 	- having unnecessary drivers will make the kernel bigger, and can
@@ -169,9 +172,6 @@ CONFIGURING the kernel:
 	  should probably answer 'n' to the questions for
           "development", "experimental", or "debugging" features.
 
- - Check the top Makefile for further site-dependent configuration
-   (default SVGA mode etc). 
-
 COMPILING the kernel:
 
  - Make sure you have gcc 2.95.3 available.
@@ -199,6 +199,9 @@ COMPILING the kernel:
    are installing a new kernel with the same version number as your
    working kernel, make a backup of your modules directory before you
    do a "make modules_install".
+   In alternative, before compiling, edit your Makefile and change the
+   "EXTRAVERSION" line - its content is appended to the regular kernel
+   version.
 
  - In order to boot your new kernel, you'll need to copy the kernel
    image (e.g. .../linux/arch/i386/boot/bzImage after compilation)

