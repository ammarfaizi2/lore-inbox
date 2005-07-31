Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261737AbVGaHQE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261737AbVGaHQE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 03:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261738AbVGaHQD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 03:16:03 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:7100 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261737AbVGaHQC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 03:16:02 -0400
Date: Sun, 31 Jul 2005 00:15:56 -0700 (PDT)
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Michael Kerrisk <mtk-manpages@gmx.net>, Paul Jackson <pj@sgi.com>,
       linux-kernel@vger.kernel.org
Message-Id: <20050731071556.19102.2901.sendpatchset@sam.engr.sgi.com>
Subject: [PATCH] plug MAN-PAGES maintainer in Documentation/SubmittingPatches
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Improve the likelihood that someone submitting a patch will
notify the MAN-PAGES maintainer.

This is a follow-up to comments on the July 29 lkml email
thread: "Broke nice range for RLIMIT NICE"

Signed-off-by: Paul Jackson <pj@sgi.com>

Index: 2.6.12-rc5-mm1/Documentation/SubmittingPatches
===================================================================
--- 2.6.12-rc5-mm1.orig/Documentation/SubmittingPatches
+++ 2.6.12-rc5-mm1/Documentation/SubmittingPatches
@@ -161,6 +161,11 @@ USB, framebuffer devices, the VFS, the S
 MAINTAINERS file for a mailing list that relates specifically to
 your change.
 
+If changes affect userland-kernel interfaces, please send
+the MAN-PAGES maintainer (as listed in the MAINTAINERS file)
+a man-pages patch, or at least a notification of the change,
+so that some information makes its way into the manual pages.
+
 Even if the maintainer did not respond in step #4, make sure to ALWAYS
 copy the maintainer when you change their code.
 

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.650.933.1373, 1.925.600.0401
