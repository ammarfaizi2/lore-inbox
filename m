Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263976AbTE0Rbr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 13:31:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263979AbTE0Rbr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 13:31:47 -0400
Received: from web40003.mail.yahoo.com ([66.218.78.21]:17997 "HELO
	web40003.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263976AbTE0Rbk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 13:31:40 -0400
Message-ID: <20030527174453.51471.qmail@web40003.mail.yahoo.com>
Date: Tue, 27 May 2003 10:44:53 -0700 (PDT)
From: Jeff Smith <whydoubt@yahoo.com>
Subject: [PATCH] KBuild documentation - make dep
To: linux-kernel@vger.kernel.org, mec@shout.net
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove references to make {dep|depend} in kbuild documentation.

- Jeff Smith

========================================================================
--- a/Documentation/kbuild/commands.txt Mon May 26 20:00:41 2003
+++ b/Documentation/kbuild/commands.txt Tue May 27 11:59:24 2003
@@ -17,7 +17,6 @@
 you need:

     make config
-    make dep
     make bzImage

 Instead of 'make config', you can run 'make menuconfig' for a full-screen
@@ -86,28 +85,5 @@

        You can run 'make checkhelp' without configuring the kernel.
        Also, 'make checkhelp' does not modify any files.
-
-    make dep, make depend
-
-       'make dep' is a synonym for the long form, 'make depend'.
-
-       This command does two things.  First, it computes dependency
-       information about which .o files depend on which .h files.
-       It records this information in a top-level file named .hdepend
-       and in one file per source directory named .depend.
-
-       Second, if you have CONFIG_MODVERSIONS enabled, 'make dep'
-       computes symbol version information for all of the files that
-       export symbols (note that both resident and modular files may
-       export symbols).
-
-       If you do not enable CONFIG_MODVERSIONS, you only have to run
-       'make dep' once, right after the first time you configure
-       the kernel.  The .hdepend files and the .depend file are
-       independent of your configuration.
-
-       If you do enable CONFIG_MODVERSIONS, you must run 'make dep'
-       every time you change your configuration, because the module
-       symbol version information depends on the configuration.

 [to be continued ...]


__________________________________
Do you Yahoo!?
The New Yahoo! Search - Faster. Easier. Bingo.
http://search.yahoo.com
