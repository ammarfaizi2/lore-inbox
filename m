Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261342AbVAGLTa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261342AbVAGLTa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 06:19:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261343AbVAGLTa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 06:19:30 -0500
Received: from pD9FFBFC9.dip.t-dialin.net ([217.255.191.201]:56480 "EHLO
	oscar.local.net") by vger.kernel.org with ESMTP id S261342AbVAGLTZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 06:19:25 -0500
Date: Fri, 7 Jan 2005 12:19:21 +0100
From: Patrick Mau <mau@oscar.ping.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Compile fix for kernel/sys.c
Message-ID: <20050107111921.GA5961@oscar.prima.de>
Reply-To: Patrick Mau <mau@oscar.ping.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo everyone,

I need the following patch to compile BK snapshots of today.
"tty_sem" needs to be declared.

Regards,
Patrick

--- ./kernel/sys.c	2005-01-07 12:16:04.000000000 +0100
+++ ./kernel/sys.c.new	2005-01-07 12:06:23.000000000 +0100
@@ -23,6 +23,7 @@
 #include <linux/security.h>
 #include <linux/dcookies.h>
 #include <linux/suspend.h>
+#include <linux/tty.h>
 
 #include <linux/compat.h>
 #include <linux/syscalls.h>
