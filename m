Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262658AbUKLXEE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262658AbUKLXEE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 18:04:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262653AbUKLXDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 18:03:38 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:1945 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262658AbUKLXAl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 18:00:41 -0500
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] More Driver Core patches for 2.6.10-rc1
In-Reply-To: <1100300407123@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Fri, 12 Nov 2004 15:00:07 -0800
Message-Id: <110030040797@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2101, 2004/11/12 12:46:17-08:00, greg@kroah.com

sysfs: fix odd patch error

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 fs/sysfs/dir.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/fs/sysfs/dir.c b/fs/sysfs/dir.c
--- a/fs/sysfs/dir.c	2004-11-12 14:52:41 -08:00
+++ b/fs/sysfs/dir.c	2004-11-12 14:52:41 -08:00
@@ -56,7 +56,7 @@
 
 	sd = sysfs_new_dirent(parent_sd, element);
 	if (!sd)
-		return -ENOMEMurn -ENOMEM;
+		return -ENOMEM;
 
 	sd->s_mode = mode;
 	sd->s_type = type;

