Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264095AbTKJTd5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 14:33:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264066AbTKJTd5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 14:33:57 -0500
Received: from smtp-101-monday.nerim.net ([62.4.16.101]:1036 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S264095AbTKJTcx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 14:32:53 -0500
Date: Mon, 10 Nov 2003 20:31:47 +0100
From: Jean Delvare <khali@linux-fr.org>
To: David Hinds <dahinds@users.sourceforge.net>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6] pcmcia/sa1100_stork.c doesn't need i2c
Message-Id: <20031110203147.4ddbe9f2.khali@linux-fr.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David, hi all,

The 2.6 version of the 2.4 patch I just posted (very similar).

--- linux-2.6.0-test9/drivers/pcmcia/sa1100_stork.c.orig	Mon May  5 01:53:31 2003
+++ linux-2.6.0-test9/drivers/pcmcia/sa1100_stork.c	Mon Nov 10 20:02:37 2003
@@ -23,7 +23,6 @@
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/device.h>
-#include <linux/i2c.h>
 
 #include <asm/hardware.h>
 #include <asm/mach-types.h>

Please apply.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
