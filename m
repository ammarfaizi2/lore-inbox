Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261181AbUKUQwD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbUKUQwD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 11:52:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261217AbUKUQwD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 11:52:03 -0500
Received: from dsl-prvgw1nf5.dial.inet.fi ([80.223.61.245]:29661 "EHLO
	dsl-prvgw1nf5.dial.inet.fi") by vger.kernel.org with ESMTP
	id S261181AbUKUQvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 11:51:47 -0500
Date: Sun, 21 Nov 2004 18:51:43 +0200 (EET)
From: "Petri T. Koistinen" <petri.koistinen@iki.fi>
To: roms@lpg.ticalc.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Clean up little bit gkc introduction text
Message-ID: <Pine.LNX.4.61.0411211825120.5894@dsl-prvgw1nf5.dial.inet.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This patch cleans up little bit gkc introduction text.

What do you think about this patch? Somebody that speaks natively english should 
probably read this thru.

Best regards,
Petri Koistinen

Signed-off-by: Petri T. Koistinen <petri.koistinen@iki.fi>

--- linux-2.6/scripts/kconfig/gconf.c.orig	2004-11-21 16:15:16.000000000 +0200
+++ linux-2.6/scripts/kconfig/gconf.c	2004-11-21 18:07:52.000000000 +0200
@@ -741,22 +741,25 @@ void on_introduction1_activate(GtkMenuIt
 {
 	GtkWidget *dialog;
 	const gchar *intro_text =
-	    "Welcome to gkc, the GTK+ graphical kernel configuration tool\n"
-	    "for Linux.\n"
-	    "For each option, a blank box indicates the feature is disabled, a\n"
-	    "check indicates it is enabled, and a dot indicates that it is to\n"
-	    "be compiled as a module.  Clicking on the box will cycle through the three states.\n"
+	    "Welcome to gkc, the graphical configuration tool for Linux "
+	    "kernel.\n"
 	    "\n"
-	    "If you do not see an option (e.g., a device driver) that you\n"
-	    "believe should be present, try turning on Show All Options\n"
-	    "under the Options menu.\n"
-	    "Although there is no cross reference yet to help you figure out\n"
-	    "what other options must be enabled to support the option you\n"
-	    "are interested in, you can still view the help of a grayed-out\n"
-	    "option.\n"
+	    "For each option, an empty box indicates the feature is disabled,\n"
+	    "a check indicates it is enabled, and a dot indicates that it "
+	    "will be compiled as a module.  Click the box to cycle through "
+	    "the possible states.\n"
 	    "\n"
-	    "Toggling Show Debug Info under the Options menu will show \n"
-	    "the dependencies, which you can then match by examining other options.";
+	    "If you do not see an option (e.g. a device driver) that you "
+	    "believe should be present, try turning on `Show all options' "
+	    "from the `Options' menu.\n"
+	    "\n"
+	    "Although there is no cross reference to help figure out what "
+	    "other options must be enabled to support the option you want, "
+	    "you can still view the help of a disabled option.\n"
+	    "\n"
+	    "Toggling `Show debug info' under the `Options' menu will show you "
+	    "the dependencies, which you can then match by examining other "
+	    "options.";
 
 	dialog = gtk_message_dialog_new(GTK_WINDOW(main_wnd),
 					GTK_DIALOG_DESTROY_WITH_PARENT,
