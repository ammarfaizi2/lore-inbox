Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265301AbTLMTfx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 14:35:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265300AbTLMTfx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 14:35:53 -0500
Received: from smtp-106-saturday.noc.nerim.net ([62.4.17.106]:1286 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S265301AbTLMTfq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 14:35:46 -0500
Date: Sat, 13 Dec 2003 20:36:14 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <sensors@stimpy.netroedge.com>
Subject: [PATCH 2.4] i2c cleanups (4/4)
Message-Id: <20031213203614.2fc6dd05.khali@linux-fr.org>
In-Reply-To: <20031213191258.2d78a9f7.khali@linux-fr.org>
References: <20031213191258.2d78a9f7.khali@linux-fr.org>
Reply-To: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <sensors@stimpy.netroedge.com>
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This small patch fixes the pcmcia sa1100 driver including the i2c.h
header, while it doesn't make any use of it. I found that while working
on my various i2c patches.

Please apply.

--- linux-2.4.24-pre1/drivers/pcmcia/sa1100_stork.c.orig	Tue Jul 15 12:23:03 2003
+++ linux-2.4.24-pre1/drivers/pcmcia/sa1100_stork.c	Sat Dec 13 18:57:40 2003
@@ -24,7 +24,6 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
-#include <linux/i2c.h>
 
 #include <asm/hardware.h>
 #include <asm/irq.h>

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
