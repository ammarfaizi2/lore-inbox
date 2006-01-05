Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752121AbWAETQd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752121AbWAETQd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 14:16:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752155AbWAETQd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 14:16:33 -0500
Received: from xproxy.gmail.com ([66.249.82.202]:57255 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752121AbWAETQb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 14:16:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=H+eU+FDnfrc96LIJKyM5J3wMwFNvJ3J+DBBo3TDSoA7xxpW6QSgFt7BXAYUvlfrAdJfY1UR/7xX0ZIHlotCHQarlvhB62LKX5M3H2XJwoQtKitNakTzqgAXGLj/HaMQs9NcqYte/XrfZcEQZMoZRKPnYO6ZJwlsa/ox7ZTg/Jig=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/5] Docs update: remove obsolete patch from locks.txt
Date: Thu, 5 Jan 2006 20:16:23 +0100
User-Agent: KMail/1.9
Cc: Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200601052016.23746.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jesper Juhl <jesper.juhl@gmail.com>

  Remove obsolete patch from Documentation/locks.txt

Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 Documentation/locks.txt |   17 -----------------
 1 files changed, 17 deletions(-)

--- linux-2.6.15-mm1-orig/Documentation/locks.txt	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.15-mm1/Documentation/locks.txt	2006-01-05 20:04:25.000000000 +0100
@@ -65,20 +65,3 @@
 mandatory locking only be enabled on a local filesystem as the specific need
 arises.
 
-Until an updated version of mount(8) becomes available you may have to apply
-this patch to the mount sources (based on the version distributed with Rick
-Faith's util-linux-2.5 package):
-
-*** mount.c.orig	Sat Jun  8 09:14:31 1996
---- mount.c	Sat Jun  8 09:13:02 1996
-***************
-*** 100,105 ****
---- 100,107 ----
-    { "noauto",	0, MS_NOAUTO	},	/* Can  only be mounted explicitly */
-    { "user",	0, MS_USER	},	/* Allow ordinary user to mount */
-    { "nouser",	1, MS_USER	},	/* Forbid ordinary user to mount */
-+   { "mand",	0, MS_MANDLOCK	},	/* Allow mandatory locks on this FS */
-+   { "nomand",	1, MS_MANDLOCK	},	/* Forbid mandatory locks on this FS */
-    /* add new options here */
-  #ifdef MS_NOSUB
-    { "sub",	1, MS_NOSUB	},	/* allow submounts */


