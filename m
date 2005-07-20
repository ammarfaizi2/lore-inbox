Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261495AbVGTDZa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261495AbVGTDZa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 23:25:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261555AbVGTDZ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 23:25:29 -0400
Received: from wproxy.gmail.com ([64.233.184.205]:20631 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261495AbVGTDZ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 23:25:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=PDK/KkhSHWmwEPqpZ4IGOc5RdtnNMlU8YiaK5QAcWCW3ezlGUYjsvco0oep6KD3owFDUSmrFuy/egdnkdh79HF9DObdLAwW+TLkF+tSjCfGjrnGTY52PLtCU0QE6k7Rj+7eFKi1fBEmM0Gp7NJgqopNomQGdOrx71V+YO+HUA6Y=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] clarify KALLSYMS_ALL help text
Date: Wed, 20 Jul 2005 05:43:05 +0200
User-Agent: KMail/1.8.1
Cc: Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507200543.05965.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clarify the KALLSYMS_ALL help text slightly.

Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 init/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.13-rc3-mm1-orig/init/Kconfig	2005-07-17 04:40:00.000000000 +0200
+++ linux-2.6.13-rc3-mm1/init/Kconfig	2005-07-20 05:39:20.000000000 +0200
@@ -366,8 +366,8 @@
 	help
 	   Normally kallsyms only contains the symbols of functions, for nicer
 	   OOPS messages.  Some debuggers can use kallsyms for other
-	   symbols too: say Y here to include all symbols, and you
-	   don't care about adding 300k to the size of your kernel.
+	   symbols too: say Y here to include all symbols, if you need them 
+	   and you don't care about adding 300k to the size of your kernel.
 
 	   Say N.
 

