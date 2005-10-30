Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932153AbVJ3Pyy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932153AbVJ3Pyy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 10:54:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932179AbVJ3PyU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 10:54:20 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:49166 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932163AbVJ3Pxk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 10:53:40 -0500
Date: Sun, 30 Oct 2005 16:53:39 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] fs/afs/callback.c should #include "cmservice.h"
Message-ID: <20051030155339.GD4180@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Every file should include the headers containing the prototypes for
it's global functions.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.14-rc5-mm1-full/fs/afs/callback.c.old	2005-10-30 16:27:50.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/fs/afs/callback.c	2005-10-30 16:28:02.000000000 +0100
@@ -19,6 +19,7 @@
 #include "server.h"
 #include "vnode.h"
 #include "internal.h"
+#include "cmservice.h"
 
 /*****************************************************************************/
 /*

