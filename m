Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932215AbVL0EjL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932215AbVL0EjL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 23:39:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932217AbVL0EjL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 23:39:11 -0500
Received: from xenotime.net ([66.160.160.81]:38816 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932215AbVL0EjK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 23:39:10 -0500
Date: Mon, 26 Dec 2005 20:39:48 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [PATCH] SubmittingPatches: diffstat options
Message-Id: <20051226203948.3d46594f.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Add desired 'diffstat' options to use for kernel patches.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 Documentation/SubmittingPatches |    3 +++
 1 files changed, 3 insertions(+)

--- linux-2615-rc7.orig/Documentation/SubmittingPatches
+++ linux-2615-rc7/Documentation/SubmittingPatches
@@ -373,6 +373,9 @@ a diffstat, to show what files have chan
 and deleted lines per file.  A diffstat is especially useful on bigger
 patches.  Other comments relevant only to the moment or the maintainer,
 not suitable for the permanent changelog, should also go here.
+Use diffstat options "-p 1 -w 70" so that filenames are listed from the
+top of the kernel source tree and don't use too much horizontal space
+(easily fit in 80 columns, maybe with some indentation).
 
 See more details on the proper patch format in the following
 references.


---
