Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265277AbUAJRce (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 12:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265278AbUAJRce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 12:32:34 -0500
Received: from mailgate5.cinetic.de ([217.72.192.165]:62156 "EHLO
	mailgate5.cinetic.de") by vger.kernel.org with ESMTP
	id S265277AbUAJRcI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 12:32:08 -0500
Date: Sat, 10 Jan 2004 18:32:07 +0100
Message-Id: <200401101732.i0AHW7Q18932@mailgate5.cinetic.de>
MIME-Version: 1.0
Organization: http://freemail.web.de/
From: <davidjoerg@web.de>
To: linux-kernel@vger.kernel.org
Subject: Mistake in Documentation/cdrom/ide-cd
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have found some mistakes in the documentation.
Here's a diff to fix it. It applies for 2.6.1 as well as 2.4.24.


--- Documentation/cdrom/ide-cd	2003-12-31 05:48:00.000000000 +0100
+++ Documentation/myfile.txt	2004-01-10 17:18:54.000000000 +0100
@@ -74,7 +74,7 @@
 3. The CDROM drive should be connected to the host on an IDE
    interface.  Each interface on a system is defined by an I/O port
    address and an IRQ number, the standard assignments being
-   0x170 and 14 for the primary interface and 0x1f0 and 15 for the
+   0x1f0 and 14 for the primary interface and 0x170 and 15 for the
    secondary interface.  Each interface can control up to two devices,
    where each device can be a hard drive, a CDROM drive, a floppy drive, 
    or a tape drive.  The two devices on an interface are called `master'
@@ -268,8 +268,8 @@
 
   - Double-check your hardware configuration to make sure that the IRQ
     number of your IDE interface matches what the driver expects.
-    (The usual assignments are 14 for the primary (0x170) interface
-    and 15 for the secondary (0x1f0) interface.)  Also be sure that
+    (The usual assignments are 14 for the primary (0x1f0) interface
+    and 15 for the secondary (0x170) interface.)  Also be sure that
     you don't have some other hardware which might be conflicting with
     the IRQ you're using.  Also check the BIOS setup for your system;
     some have the ability to disable individual IRQ levels, and I've



Regards, David
-- 

www.gnu.org | http://waste.informatik.hu-berlin.de/Grassmuck/Texts/drm-fiffko.html
www.againsttcpa.com | www.debian.org | www.mozilla.org | www.xiph.org
______________________________________________________________________________
Erdbeben im Iran: Zehntausende Kinder brauchen Hilfe. UNICEF hilft den
Kindern - helfen Sie mit! https://www.unicef.de/spe/spe_03.php

