Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261162AbVAHNY6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbVAHNY6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 08:24:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261165AbVAHNY6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 08:24:58 -0500
Received: from mail.sf-mail.de ([62.27.20.61]:37845 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S261162AbVAHNYo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 08:24:44 -0500
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] s/driverfs/sysfs/ in init/do_mounts.c
Date: Fri, 7 Jan 2005 13:49:07 +0100
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200501071349.08553.eike-kernel@sf-tec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

since driverfs has been renamed to sysfs long time ago this comments should 
be fixed.

Eike

Signed-off-by: Rolf Eike Beer <eike-kernel@sf-tec.de>

--- linux-2.6.10/init/do_mounts.c	2004-12-24 22:34:31.000000000 +0100
+++ linux-2.6.10/init/do_mounts.c.fixed	2005-01-07 13:42:02.406392368 +0100
@@ -127,10 +127,10 @@ fail:
  *	   used when disk name of partitioned disk ends on a digit.
  *
  *	If name doesn't have fall into the categories above, we return 0.
- *	Driverfs is used to check if something is a disk name - it has
+ *	Sysfs is used to check if something is a disk name - it has
  *	all known disks under bus/block/devices.  If the disk name
- *	contains slashes, name of driverfs node has them replaced with
- *	bangs.  try_name() does the actual checks, assuming that driverfs
+ *	contains slashes, name of sysfs node has them replaced with
+ *	bangs.  try_name() does the actual checks, assuming that sysfs
  *	is mounted on rootfs /sys.
  */
 
