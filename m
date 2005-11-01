Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751187AbVKAUot@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbVKAUot (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 15:44:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751204AbVKAUot
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 15:44:49 -0500
Received: from host175-37.pool8253.interbusiness.it ([82.53.37.175]:53710 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S1751187AbVKAUot
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 15:44:49 -0500
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 2/2] uml: add missing header
Date: Tue, 01 Nov 2005 21:48:47 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20051101204846.27258.64264.stgit@zion.home.lan>
In-Reply-To: <20051101204836.27258.46611.stgit@zion.home.lan>
References: <20051101204836.27258.46611.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

We now need to include the new <linux/platform_device.h> explicitly, due to
headers changes.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/include/net_kern.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/um/include/net_kern.h b/arch/um/include/net_kern.h
--- a/arch/um/include/net_kern.h
+++ b/arch/um/include/net_kern.h
@@ -10,6 +10,7 @@
 #include "linux/skbuff.h"
 #include "linux/socket.h"
 #include "linux/list.h"
+#include "linux/platform_device.h"
 
 struct uml_net {
 	struct list_head list;

