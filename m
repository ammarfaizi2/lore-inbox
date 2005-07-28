Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261426AbVG1NpS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbVG1NpS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 09:45:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261430AbVG1NnG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 09:43:06 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:16001 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261426AbVG1Nma (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 09:42:30 -0400
Message-ID: <42E8E0C2.5010302@gmail.com>
Date: Thu, 28 Jul 2005 15:42:26 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] New include file for marking old style api files
Content-Type: multipart/mixed;
 boundary="------------030004000104000903000409"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030004000104000903000409
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit

Hi.
Do you think, that this would be useful in the kernel tree?
I have an idea to mark old drivers, which should I or somebody rewrite.
For example drivers/isdn/hisax/gazel.c.

-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
241B347EC88228DE51EE A49C4A73A25004CB2A10


--------------030004000104000903000409
Content-Type: text/plain;
 name="lnx-oldapi-6.13r3m3.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lnx-oldapi-6.13r3m3.txt"

diff --git a/include/linux/oldapi.h b/include/linux/oldapi.h
new file mode 100644
--- /dev/null
+++ b/include/linux/oldapi.h
@@ -0,0 +1,2 @@
+#warning This driver uses old style API and needs to be rewritten or removed \
+	from kernel

--------------030004000104000903000409--
