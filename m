Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750742AbVJKVTd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742AbVJKVTd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 17:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750743AbVJKVTd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 17:19:33 -0400
Received: from xproxy.gmail.com ([66.249.82.202]:52122 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750742AbVJKVTc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 17:19:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=YPDniPlnZGHbXPxLKTeZz0kRfztDo6wWx8+obczwOf2fmKpy8lhLPh5xQmDEbNvmUGbv+4/78XlSSkw8nn4nDsVv95+l8BPtOTrtadFGEtcfydbmiiIm7uh6H4zXw2ikOIqyPsRLc8HJeVhLH+0cKignpySWBcwazNLsS4Kmh8w=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: [PATCH] small Kconfig help text correction for CONFIG_FRAME_POINTER
Date: Tue, 11 Oct 2005 23:22:21 +0200
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>, "Jesper Juhl" <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510112322.22004.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix-up the CONFIG_FRAME_POINTER help text language a bit.

Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 "on some architectures or you use external debuggers"
  doesn't sound too good
 "on some architectures or if you use external debuggers"
  is better.

 lib/Kconfig.debug |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.14-rc4-orig/lib/Kconfig.debug	2005-10-11 22:41:32.000000000 +0200
+++ linux-2.6.14-rc4/lib/Kconfig.debug	2005-10-11 23:16:30.000000000 +0200
@@ -174,7 +174,7 @@
 	default y if DEBUG_INFO && UML
 	help
 	  If you say Y here the resulting kernel image will be slightly larger
-	  and slower, but it might give very useful debugging information
-	  on some architectures or you use external debuggers.
+	  and slower, but it might give very useful debugging information on
+	  some architectures or if you use external debuggers.
 	  If you don't debug the kernel, you can say N.
 


