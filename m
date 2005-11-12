Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750800AbVKLAi7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750800AbVKLAi7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 19:38:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750802AbVKLAi7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 19:38:59 -0500
Received: from xproxy.gmail.com ([66.249.82.200]:1147 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750800AbVKLAi6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 19:38:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=sw5JCs8szXrL3qikxjCqH+ckaFfEnDETRIlvAnBpyeQBmWuQfAbsIlKoR3koZ3cNhG8bU4afs1FQVDj50KKYmeEwWC2FYtcOye2ddly0+HA8e/CNvQJTbkkmlPk05AF/o/ZU1BQFrF5b+cmKG8NCkZdbVnWhM+wliRViyDccaQo=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: [PATCH] Info about -stable to README and point at applying-patches.txt
Date: Sat, 12 Nov 2005 01:43:16 +0100
User-Agent: KMail/1.8.92
Cc: Andrew Morton <akpm@osdl.org>,
       "Miro Dietiker, MD Systems" <info@md-systems.ch>,
       Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511120143.16602.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Small patch that adds some info about the 2.6.x.y (-stable) kernel
to the README and also tells people to look at 
Documentation/applying-patches.txt for more information.

Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 README |    5 +++++
 1 files changed, 5 insertions(+)

--- linux-2.6.14-git14-orig/README	2005-11-12 01:19:39.000000000 +0100
+++ linux-2.6.14-git14/README	2005-11-12 01:27:17.000000000 +0100
@@ -81,6 +81,11 @@
    failed patches (xxx# or xxx.rej). If there are, either you or me has
    made a mistake.
 
+   Contrary to the patches for the 2.6.x kernels, patches for the 2.6.x.y
+   kernels (also known as the -stable kernels) are not incremental but
+   instead apply directly to the base 2.6.x kernel.
+   Please read Documentation/applying-patches.txt for more information.
+
    Alternatively, the script patch-kernel can be used to automate this
    process.  It determines the current kernel version and applies any
    patches found.
