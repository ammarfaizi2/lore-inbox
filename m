Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261378AbULNBTk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261378AbULNBTk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 20:19:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261369AbULNBTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 20:19:40 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:55312 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261375AbULNBKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 20:10:42 -0500
Date: Tue, 14 Dec 2004 02:10:37 +0100
From: Adrian Bunk <bunk@stusta.de>
To: hpa@zytor.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] i386 cpuid.c: remove a duplicate include
Message-ID: <20041214011037.GV23151@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't see any good reason for including fs.h twice.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.9-mm1-full/arch/i386/kernel/cpuid.c.old	2004-10-22 21:37:31.000000000 +0200
+++ linux-2.6.9-mm1-full/arch/i386/kernel/cpuid.c	2004-10-22 21:41:45.000000000 +0200
@@ -35,7 +35,6 @@
 #include <linux/major.h>
 #include <linux/fs.h>
 #include <linux/smp_lock.h>
-#include <linux/fs.h>
 #include <linux/device.h>
 #include <linux/cpu.h>
 #include <linux/notifier.h>

