Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751398AbVHRAPH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751398AbVHRAPH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 20:15:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751396AbVHRAPB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 20:15:01 -0400
Received: from rproxy.gmail.com ([64.233.170.196]:4464 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751394AbVHRAOs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 20:14:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=CVD2LmGRzzX+uMSZjyItEyoAl80yrw9o5TK3AiCPxVzKu5xR7nlcZA+1FTWT0mhfv7C2K1TQwGRYNwsIQaCtaDmghTVk5zyX45kzk/tRxgyKfw4aGbLGJnG6VTyMQbgql3G2q//sDeCtm0F7X7TTW9kdIgn93thSoaJteRhYKJ0=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: [PATCH 7/7] rename locking functions - add entry to feature-removal-schedule.txt
Date: Thu, 18 Aug 2005 02:14:19 +0200
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>, jesper.juhl@gmail.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508180214.19550.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Document sema_init, init_MUTEX & init_MUTEX_LOCKED as being deprecated and
going away in early 2006.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 Documentation/feature-removal-schedule.txt |    9 +++++++++
 1 files changed, 9 insertions(+)

--- linux-2.6.13-rc6-git9-orig/Documentation/feature-removal-schedule.txt	2005-08-17 21:51:19.000000000 +0200
+++ linux-2.6.13-rc6-git9/Documentation/feature-removal-schedule.txt	2005-08-18 01:04:15.000000000 +0200
@@ -135,3 +135,12 @@
 	pcmciautils package available at
 	http://kernel.org/pub/linux/utils/kernel/pcmcia/
 Who:	Dominik Brodowski <linux@brodo.de>
+
+---------------------------
+
+What:	sema_init, init_MUTEX & init_MUTEX_LOCKED
+When:	January 2006
+Why:	The functions have been renamed. The new names are:
+	init_sema, init_mutex & init_mutex_locked.
+	Deprecated wrappers with the old names exist and should be removed.
+Who:	Jesper Juhl <jesper.juhl@gmail.com>


