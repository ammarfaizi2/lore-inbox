Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964945AbVL2AjL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964945AbVL2AjL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 19:39:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964943AbVL2AjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 19:39:10 -0500
Received: from mx.pathscale.com ([64.160.42.68]:43496 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932568AbVL2AjI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 19:39:08 -0500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 4 of 20] Define BITS_PER_BYTE
X-Mercurial-Node: a3a00f637da623feb1d28edae43e59cfd54045fc
Message-Id: <a3a00f637da623feb1d2.1135816283@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1135816279@eng-12.pathscale.com>
Date: Wed, 28 Dec 2005 16:31:23 -0800
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: linux-kernel@vger.kernel.org, openib-general@openib.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This can make some arithmetic expressions clearer.

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r b792638cc4bc -r a3a00f637da6 include/linux/types.h
--- a/include/linux/types.h	Wed Dec 28 14:19:42 2005 -0800
+++ b/include/linux/types.h	Wed Dec 28 14:19:42 2005 -0800
@@ -8,6 +8,8 @@
 	(((bits)+BITS_PER_LONG-1)/BITS_PER_LONG)
 #define DECLARE_BITMAP(name,bits) \
 	unsigned long name[BITS_TO_LONGS(bits)]
+
+#define BITS_PER_BYTE 8
 #endif
 
 #include <linux/posix_types.h>
