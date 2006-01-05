Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932140AbWAEUPx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932140AbWAEUPx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 15:15:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932119AbWAEUPx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 15:15:53 -0500
Received: from xproxy.gmail.com ([66.249.82.199]:37482 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932141AbWAEUPw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 15:15:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=puEuYGI+aO7hzBnrTN0bgP68RvOA3Uc1FZIzBKhG6qgKc74tWbjaAoVCofsI+kzXF/usAuJrEaOtiCFM5qA7mGCgszPStSabQsxJEBcLUb2BW525uB6fVUHvHi9/2He8IgaYfJdPX+gAdfgzdmgjHBVsWrTl9AIrZPWZ3fOp2NY=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [-mm PATCH] Small fixup of CONFIG_DEBUG_SHIRQ help text
Date: Thu, 5 Jan 2006 21:15:46 +0100
User-Agent: KMail/1.9
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601052115.47041.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jesper Juhl <jesper.juhl@gmail.com>


 Small fixup of CONFIG_DEBUG_SHIRQ help text.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 lib/Kconfig.debug |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.15-mm1-orig/lib/Kconfig.debug	2006-01-05 18:15:43.000000000 +0100
+++ linux-2.6.15-mm1/lib/Kconfig.debug	2006-01-05 21:11:28.000000000 +0100
@@ -192,7 +192,7 @@
        help
          Enable this to generate a spurious interrupt as soon as a shared interrupt
 	 handler is registered, and just before one is deregistered. Drivers ought
-	 to be able to handle interrupts coming in at those some; some don't and
+	 to be able to handle interrupts coming in at those points; some don't and
 	 need to be caught.
 
 config FRAME_POINTER


