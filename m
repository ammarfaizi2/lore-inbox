Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263660AbTDTSZ7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 14:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263669AbTDTSYR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 14:24:17 -0400
Received: from hera.cwi.nl ([192.16.191.8]:36538 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S263664AbTDTSV7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 14:21:59 -0400
From: Andries.Brouwer@cwi.nl
Date: Sun, 20 Apr 2003 20:33:58 +0200 (MEST)
Message-Id: <UTC200304201833.h3KIXwO18184.aeb@smtp.cwi.nl>
To: torvalds@transmeta.com
Subject: [PATCH] remove unused declaration
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --recursive --new-file -X /linux/dontdiff a/include/linux/tty.h b/include/linux/tty.h
--- a/include/linux/tty.h	Tue Mar 18 11:48:23 2003
+++ b/include/linux/tty.h	Sun Apr 20 18:20:32 2003
@@ -342,7 +342,6 @@
 extern void tty_write_flush(struct tty_struct *);
 
 extern struct termios tty_std_termios;
-extern struct tty_struct * redirect;
 extern struct tty_ldisc ldiscs[];
 extern int fg_console, last_console, want_console;
 
