Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262551AbVBBMU2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262551AbVBBMU2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 07:20:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262362AbVBBMU1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 07:20:27 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:43207 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S262551AbVBBMTq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 07:19:46 -0500
Date: Wed, 2 Feb 2005 13:19:12 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: trivial@rustcorp.com.au
Subject: [TRIVIAL 2.6] Update panic() comment.
Message-ID: <20050202121912.GA4536@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[TRIVIAL 2.6] Update panic() comment.

panic() doesn't flush the filesystem cache anymore. The comment above the
function still claims it does.

Thanks,
Heiko

===== panic.c 1.22 vs edited =====
--- 1.22/kernel/panic.c	2004-11-08 03:16:06 +01:00
+++ edited/panic.c	2005-02-02 12:25:21 +01:00
@@ -49,8 +49,7 @@
  *	panic - halt the system
  *	@fmt: The text string to print
  *
- *	Display a message, then perform cleanups. Functions in the panic
- *	notifier list are called after the filesystem cache is flushed (when possible).
+ *	Display a message, then perform cleanups.
  *
  *	This function never returns.
  */
