Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265776AbUGVNhs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265776AbUGVNhs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 09:37:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265795AbUGVNhs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 09:37:48 -0400
Received: from math.ut.ee ([193.40.5.125]:15314 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S265776AbUGVNhr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 09:37:47 -0400
Date: Thu, 22 Jul 2004 16:37:31 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: James Morris <jmorris@redhat.com>
cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: [PATCH] Re: TEA crypto in 2.4: undefined MODULE_ALIAS
In-Reply-To: <Pine.LNX.4.58.0407191931390.1972@devserv.devel.redhat.com>
Message-ID: <Pine.GSO.4.44.0407221636420.14726-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Probably remove the line from the 2.4 version.

This patch removes the MODULE_ALIAS line from 2.4.

===== crypto/tea.c 1.1 vs edited =====
--- 1.1/crypto/tea.c	2004-06-30 08:29:33 +03:00
+++ edited/crypto/tea.c	2004-07-22 16:32:55 +03:00
@@ -239,8 +239,6 @@
 	crypto_unregister_alg(&xtea_alg);
 }

-MODULE_ALIAS("xtea");
-
 module_init(init);
 module_exit(fini);


-- 
Meelis Roos (mroos@linux.ee)

