Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262637AbSJBVny>; Wed, 2 Oct 2002 17:43:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262638AbSJBVny>; Wed, 2 Oct 2002 17:43:54 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:26877 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262637AbSJBVnt>; Wed, 2 Oct 2002 17:43:49 -0400
Subject: PATCH: 2.5 PC110 pad docs are wrong
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 02 Oct 2002 22:56:47 +0100
Message-Id: <1033595807.25240.4.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Someone tweaked the PC110 documents changing touchpad to touchscreen,
this changes it back because it is a touchpad and _not_ a touchscreen

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.2.5.40/drivers/input/mouse/Config.help linux.2.5.40-ac1/drivers/input/mouse/Config.help
--- linux.2.5.40/drivers/input/mouse/Config.help	2002-07-20 20:11:33.000000000 +0100
+++ linux.2.5.40-ac1/drivers/input/mouse/Config.help	2002-10-02 22:18:49.000000000 +0100
@@ -52,7 +52,7 @@
 
 CONFIG_MOUSE_PC110PAD
   Say Y if you have the IBM PC-110 micro-notebook and want its
-  touchscreen supported.
+  touchpad supported.
 
   This driver is also available as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want).


