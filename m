Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262790AbTJTW6o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 18:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262802AbTJTW6o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 18:58:44 -0400
Received: from cable98.usuarios.retecal.es ([212.22.32.98]:40675 "EHLO
	hell.lnx.es") by vger.kernel.org with ESMTP id S262790AbTJTW6l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 18:58:41 -0400
Date: Tue, 21 Oct 2003 00:58:23 +0200
From: Manuel Estrada Sainz <ranty@debian.org>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] remove device.name usage from firmware_sample_driver.c
Message-ID: <20031020225823.GA1807@ranty.pantax.net>
Reply-To: ranty@debian.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Please apply.

 I guess that even sample code should be correct :).

 ChangeLog:
	
	 Remove "struct device->name" usage
	 Documentation/firmware_class/firmware_sample_driver.c


 firmware_sample_driver.c |    1 -
 1 files changed, 1 deletion(-)


Index: Documentation/firmware_class/firmware_sample_driver.c
===================================================================
--- Documentation/firmware_class/firmware_sample_driver.c	(revision 14117)
+++ Documentation/firmware_class/firmware_sample_driver.c	(working copy)
@@ -22,7 +22,6 @@
 #endif
 
 static struct device ghost_device = {
-	.name      = "Ghost Device",
 	.bus_id    = "ghost0",
 };
 

-- 
--- Manuel Estrada Sainz <ranty@debian.org>
                         <ranty@bigfoot.com>
			 <ranty@users.sourceforge.net>
------------------------ <manuel.estrada@hispalinux.es> -------------------
Let us have the serenity to accept the things we cannot change, courage to
change the things we can, and wisdom to know the difference.
