Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262709AbTFGHyN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 03:54:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262763AbTFGHwT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 03:52:19 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:53005 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S262709AbTFGHvz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 03:51:55 -0400
Date: Sat, 7 Jun 2003 10:05:28 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Docbook update
Message-ID: <20030607080528.GE8943@mars.ravnborg.org>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
References: <20030607080226.GA8943@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030607080226.GA8943@mars.ravnborg.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1316.1.3 -> 1.1316.1.4
#	       kernel/kmod.c	1.27    -> 1.28   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/06/07	sam@mars.ravnborg.org	1.1316.1.4
# docbook: Move definition of MODULENAME_SIZE
# 
# The location between the comment and the prototype confused kernel-doc.
# Kernel-doc requires the prototype to follow after the comment section.
# --------------------------------------------
#
diff -Nru a/kernel/kmod.c b/kernel/kmod.c
--- a/kernel/kmod.c	Sat Jun  7 09:53:37 2003
+++ b/kernel/kmod.c	Sat Jun  7 09:53:37 2003
@@ -58,9 +58,9 @@
  * If module auto-loading support is disabled then this function
  * becomes a no-operation.
  */
-#define MODULENAME_SIZE 32
 int request_module(const char *fmt, ...)
 {
+#define MODULENAME_SIZE 32
 	va_list args;
 	char module_name[MODULENAME_SIZE];
 	unsigned int max_modprobes;
