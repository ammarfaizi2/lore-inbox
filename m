Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265243AbTAHKig>; Wed, 8 Jan 2003 05:38:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265570AbTAHKig>; Wed, 8 Jan 2003 05:38:36 -0500
Received: from lug.gage.org ([205.179.65.215]:26121 "EHLO lug.gage.org")
	by vger.kernel.org with ESMTP id <S265243AbTAHKif>;
	Wed, 8 Jan 2003 05:38:35 -0500
Date: Wed, 8 Jan 2003 02:47:14 -0800
From: jeff gerard <jeff-lk@gerard.st>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][TRIVIAL] menuconfig color sanity
Message-ID: <20030108104714.GM268@gage.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

using yellow and green text with a "white" background in menuconfig works all
right on console, but it looks like crap under xterm, rxvt, etc. no
matter whose fault that is, the trivial patch below makes things more
readable without any major change in appearance. applies to 2.4 and 2.5.

now you can stop wondering about support for "lug and play", "mateur radio", 
and "elephony" in the linux kernel.

jeff


--- linux-2.5.52.orig/scripts/lxdialog/colors.h	2002-11-10 19:28:02.000000000 -0800
+++ linux-2.5.52/scripts/lxdialog/colors.h	2003-01-08 02:04:07.000000000 -0800
@@ -41 +41 @@
-#define TITLE_FG                     COLOR_YELLOW
+#define TITLE_FG                     COLOR_RED
@@ -93 +93 @@
-#define POSITION_INDICATOR_FG        COLOR_YELLOW
+#define POSITION_INDICATOR_FG        COLOR_RED
@@ -113 +113 @@
-#define TAG_FG                       COLOR_YELLOW
+#define TAG_FG                       COLOR_MAGENTA
@@ -121 +121 @@
-#define TAG_KEY_FG                   COLOR_YELLOW
+#define TAG_KEY_FG                   COLOR_MAGENTA
@@ -137 +137 @@
-#define UARROW_FG                    COLOR_GREEN
+#define UARROW_FG                    COLOR_RED
@@ -141 +141 @@
-#define DARROW_FG                    COLOR_GREEN
+#define DARROW_FG                    COLOR_RED

