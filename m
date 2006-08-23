Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965303AbWHWXTN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965303AbWHWXTN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 19:19:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965302AbWHWXTN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 19:19:13 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:5315 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S965300AbWHWXTM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 19:19:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=A41P4caffPdaQ4TtnjBzrjd/F0xibXM42mDEe8zILd9NMNj0K6A4ysLa/pYlvhGXpdjAITxVtlkozF3NoqvqjD23lx2VGUFkMboAv0jrUqhPTc3+P05vLLR/FlATUq7PqSqFVMqvrGEaG4vfgnijgr+UELDr+r9X4XEeOekA4kM=
Date: Thu, 24 Aug 2006 03:19:02 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Warn about config.h inclusion
Message-ID: <20060823231902.GC5203@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Otherwise feature adders won't feel it's unneeded..

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 include/linux/config.h |    1 +
 1 file changed, 1 insertion(+)

--- a/include/linux/config.h
+++ b/include/linux/config.h
@@ -3,6 +3,7 @@ #define _LINUX_CONFIG_H
 /* This file is no longer in use and kept only for backward compatibility.
  * autoconf.h is now included via -imacros on the commandline
  */
+#warning Don't include me. I'm already in via -imacros. I'll dissappear. You have been warned.
 #include <linux/autoconf.h>
 
 #endif

