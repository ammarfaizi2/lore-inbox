Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261451AbVCGUnm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbVCGUnm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 15:43:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261388AbVCGUnf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 15:43:35 -0500
Received: from mailer.campus.mipt.ru ([194.85.82.4]:27057 "EHLO
	mailer.campus.mipt.ru") by vger.kernel.org with ESMTP
	id S261788AbVCGUMw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 15:12:52 -0500
Cc: Fruhwirth Clemens <clemens@endorphin.org>,
       Herbert Xu <herbert@gondor.apana.org.au>, cryptoapi@lists.logix.cz,
       James Morris <jmorris@redhat.com>, David Miller <davem@davemloft.net>,
       Andrew Morton <akpm@osdl.org>, Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Subject: [14/many] acrypto: crypto_stat.h
In-Reply-To: <1110227854784@2ka.mipt.ru>
X-Mailer: gregkh_patchbomb
Date: Mon, 7 Mar 2005 23:37:35 +0300
Message-Id: <1110227855676@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (mailer.campus.mipt.ru [194.85.82.4]); Mon, 07 Mar 2005 23:11:25 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- /tmp/empty/crypto_stat.h	1970-01-01 03:00:00.000000000 +0300
+++ ./acrypto/crypto_stat.h	2005-03-07 20:35:36.000000000 +0300
@@ -0,0 +1,32 @@
+/*
+ * 	crypto_stat.h
+ *
+ * Copyright (c) 2004 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
+ * 
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#ifndef __CRYPTO_STAT_H
+#define __CRYPTO_STAT_H
+
+#include "acrypto.h"
+
+void crypto_stat_start_inc(struct crypto_session *s);
+void crypto_stat_finish_inc(struct crypto_session *s);
+void crypto_stat_complete_inc(struct crypto_session *s);
+void crypto_stat_ptime_inc(struct crypto_session *s);
+
+#endif				/* __CRYPTO_STAT_H */

