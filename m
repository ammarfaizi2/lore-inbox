Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261787AbVACVAX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261787AbVACVAX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 16:00:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261817AbVACVAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 16:00:23 -0500
Received: from av3-2-sn4.m-sp.skanova.net ([81.228.10.113]:48011 "EHLO
	av3-2-sn4.m-sp.skanova.net") by vger.kernel.org with ESMTP
	id S261796AbVACU75 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 15:59:57 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] isofs: Remove useless include
References: <20050103011113.6f6c8f44.akpm@osdl.org> <m3acrqutwe.fsf@telia.com>
	<m3652eutqw.fsf_-_@telia.com> <m31xd2utno.fsf_-_@telia.com>
From: Peter Osterlund <petero2@telia.com>
Date: 03 Jan 2005 21:53:37 +0100
In-Reply-To: <m31xd2utno.fsf_-_@telia.com>
Message-ID: <m3wtuutesu.fsf_-_@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I was editing cdrom.h, I noticed that fs/isofs/compress.c was
recompiled. This patch removes the useless #include that caused the
unnecessary recompilation.

Signed-off-by: Peter Osterlund <petero2@telia.com>

---

 linux-petero/fs/isofs/compress.c |    1 -
 1 files changed, 1 deletion(-)

diff -puN fs/isofs/compress.c~isofs-useless-include fs/isofs/compress.c
--- linux/fs/isofs/compress.c~isofs-useless-include	2005-01-02 22:27:41.290407816 +0100
+++ linux-petero/fs/isofs/compress.c	2005-01-02 22:27:41.292407512 +0100
@@ -28,7 +28,6 @@
 #include <linux/string.h>
 #include <linux/slab.h>
 #include <linux/errno.h>
-#include <linux/cdrom.h>
 #include <linux/init.h>
 #include <linux/nls.h>
 #include <linux/ctype.h>
_

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
