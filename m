Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261683AbULFWf7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261683AbULFWf7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 17:35:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261685AbULFWf7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 17:35:59 -0500
Received: from mail.dif.dk ([193.138.115.101]:715 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261683AbULFWfv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 17:35:51 -0500
Date: Mon, 6 Dec 2004 23:45:57 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Bart Samwel <bart@samwel.tk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Tiny esthetic changes to Documentation/laptop-mode.txt
Message-ID: <Pine.LNX.4.61.0412062340560.3390@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Here's a tiny patch making a few esthetic changes to 
Documentation/laptop-mode.txt
To me this patch makes sense, but feel free to disagree, I don't feel 
strongly about it at all.

It changes a single URL to its strictly correct form (directories should 
end in /), and it makes the arguments to main in an included example 
program follow convention and be named argc and argv.

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -u linux-2.6.10-rc3-bk2-orig/Documentation/laptop-mode.txt linux-2.6.10-rc3-bk2/Documentation/laptop-mode.txt
--- linux-2.6.10-rc3-bk2-orig/Documentation/laptop-mode.txt	2004-10-18 23:54:55.000000000 +0200
+++ linux-2.6.10-rc3-bk2/Documentation/laptop-mode.txt	2004-12-06 23:40:25.000000000 +0100
@@ -3,7 +3,7 @@
 
 Document Author: Bart Samwel (bart@samwel.tk)
 Date created: January 2, 2004
-Last modified: July 10, 2004
+Last modified: December 06, 2004
 
 Introduction
 ------------
@@ -33,7 +33,7 @@
 laptop mode will automatically be started when you're on battery. For
 your convenience, a tarball containing an installer can be downloaded at:
 
-http://www.xs4all.nl/~bsamwel/laptop_mode/tools
+http://www.xs4all.nl/~bsamwel/laptop_mode/tools/
 
 To configure laptop mode, you need to edit the configuration file, which is
 located in /etc/default/laptop-mode on Debian-based systems, or in
@@ -912,7 +912,7 @@
     exit(0);
 }
 
-int main(int ac, char **av)
+int main(int argc, char **argv)
 {
     int fd;
     char *disk = 0;


