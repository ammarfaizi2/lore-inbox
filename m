Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268685AbUILMJU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268685AbUILMJU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 08:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268690AbUILMJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 08:09:20 -0400
Received: from canuck.infradead.org ([205.233.218.70]:51466 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S268685AbUILMJN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 08:09:13 -0400
Subject: Re: [PATCH][2.4.28-pre3] MTD drivers gcc-3.4 fixes
From: David Woodhouse <dwmw2@infradead.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org
In-Reply-To: <200409121130.i8CBU3pq015236@harpo.it.uu.se>
References: <200409121130.i8CBU3pq015236@harpo.it.uu.se>
Content-Type: text/plain
Date: Sun, 12 Sep 2004 13:04:31 +0100
Message-Id: <1094990671.4995.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.94.1 (1.5.94.1-1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-09-12 at 13:30 +0200, Mikael Pettersson wrote:
> This patch fixes gcc-3.4 cast-as-lvalue warnings in the 2.4.28-pre3
> kernel's MTD drivers. The elan-104nc.c and sbc_gxx.c changes are
> backports from the 2.6 kernel. The cfi_cmdset_0001.c and cfi_cmdset_0020.c
> changes are new since the 2.6 code is different.

Looks good; thanks.

Signed-Off-By: David Woodhouse <dwmw2@infradead.org>

Btw, please don't use that other email address for me unless it's ultra-
secret company business which really has to be sent unencrypted via
their STARTTLS-incapable mail servers instead of via my secure ones. I
suppose I should fix MAINTAINERS accordingly...

===== MAINTAINERS 1.145 vs edited =====
--- 1.145/MAINTAINERS	2004-08-28 10:18:52 +01:00
+++ edited/MAINTAINERS	2004-09-12 12:54:35 +01:00
@@ -1200,9 +1200,9 @@
 
 MEMORY TECHNOLOGY DEVICES
 P:	David Woodhouse
-M:	dwmw2@redhat.com
+M:	dwmw2@infradead.org
 W:	http://www.linux-mtd.infradead.org/
-L:	mtd@infradead.org
+L:	linux-mtd@lists.infradead.org
 S:	Maintained
 
 MICROTEK X6 SCANNER


-- 
dwmw2

