Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262931AbTFOWZv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 18:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262934AbTFOWZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 18:25:51 -0400
Received: from chello062178008192.3.11.tuwien.teleweb.at ([62.178.8.192]:128
	"EHLO flatline.ath.cx") by vger.kernel.org with ESMTP
	id S262931AbTFOWZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 18:25:50 -0400
Date: Mon, 16 Jun 2003 00:44:33 +0200
From: Andreas Happe <andreashappe@gmx.net>
To: mochel@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: export sysdev_(create|remove)_file
Message-ID: <20030615224433.GA474@flatline.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
X-Hangover: none
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

just export sysdev_(create|remove)_file like the other sysdev_*
functions.

	--Andreas

--- drivers/base/sys_alt.c	2003-06-16 00:03:53.000000000 +0200
+++ drivers/base/sys.c	2003-06-16 00:02:53.000000000 +0200
@@ -74,6 +74,9 @@
 	sysfs_remove_file(&s->kobj,&a->attr);
 }
 
+EXPORT_SYMBOL(sysdev_create_file);
+EXPORT_SYMBOL(sysdev_remove_file);
+
 /* 
  * declare system_subsys 
  */
