Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262550AbUCWNXL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 08:23:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262556AbUCWNXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 08:23:11 -0500
Received: from skunk.physik.uni-erlangen.de ([131.188.163.240]:55516 "EHLO
	skunk.physik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S262550AbUCWNXK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 08:23:10 -0500
From: Christian Vogel <vogel@skunk.physik.uni-erlangen.de>
Date: Tue, 23 Mar 2004 14:23:08 +0100
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: [PATCH] tgafb: missing include (Linux 2.6.4)
Message-ID: <20040323142308.A22635@skunk.physik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, in 2.6.4 drivers/video/tgafb.c is missing a include, complaining about
color_table[] and others not being defined.

--- drivers/video/tgafb.c       2004/03/22 16:09:55     1.1
+++ drivers/video/tgafb.c       2004/03/22 16:15:38
@@ -25,6 +25,7 @@
 #include <linux/pci.h>
 #include <asm/io.h>
 #include <video/tgafb.h>
+#include <linux/selection.h>
 
 /*
  * Local functions.

