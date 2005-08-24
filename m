Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751412AbVHXTH2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751412AbVHXTH2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 15:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751411AbVHXTH1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 15:07:27 -0400
Received: from rproxy.gmail.com ([64.233.170.207]:38125 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751413AbVHXTH1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 15:07:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=c/LgYqBJJqzMB6phZsxnDAy4VZi9m7w8mDF5qSh1nHgn6lVpvOiNJRS+Z5netn4cr3icMZefXWHFbHTACj+kOt+44epMJdMCeB/kx78FyfHo2thFUC2RvuSoHFg/CNHZcZlS+xymCOUpOXSFh2zVaEdVzWgWq1m7EUpH5KMGEpI=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] exterminate strtok - arch/frv/kernel/frv_ksyms.c
Date: Wed, 24 Aug 2005 21:08:15 +0200
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508242108.15735.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since strtok() died in 2002 this EXPORT_SYMBOL appears meaningless.

Note: I've not been able to test this patch since I lack both hardware and 
a cross compiler, so if someone else could please check it and sign off on 
it before I send it to Andrew for inclusion in -mm I'd appreciate it.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 frv_ksyms.c |    1 -
 1 files changed, 1 deletion(-)

--- linux-2.6.13-rc6-mm2-orig/arch/frv/kernel/frv_ksyms.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-mm2/arch/frv/kernel/frv_ksyms.c	2005-08-24 18:58:14.000000000 +0200
@@ -71,7 +71,6 @@ EXPORT_SYMBOL(memset);
 EXPORT_SYMBOL(memcmp);
 EXPORT_SYMBOL(memscan);
 EXPORT_SYMBOL(memmove);
-EXPORT_SYMBOL(strtok);
 
 EXPORT_SYMBOL(get_wchan);
 


