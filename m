Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261454AbVG1NwU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261454AbVG1NwU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 09:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261453AbVG1NwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 09:52:12 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:59016 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261437AbVG1Nu0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 09:50:26 -0400
Message-ID: <42E8E29E.5030205@gmail.com>
Date: Thu, 28 Jul 2005 15:50:22 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Jiri Slaby <jirislaby@gmail.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] New include file for marking old style api files
References: <42E8E0C2.5010302@gmail.com>
In-Reply-To: <42E8E0C2.5010302@gmail.com>
Content-Type: multipart/mixed;
 boundary="------------010609010507070201030903"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010609010507070201030903
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit

Jiri Slaby napsal(a):

> Hi.
> Do you think, that this would be useful in the kernel tree?
> I have an idea to mark old drivers, which should I or somebody rewrite.
> For example drivers/isdn/hisax/gazel.c.
>
>------------------------------------------------------------------------
>
>diff --git a/include/linux/oldapi.h b/include/linux/oldapi.h
>new file mode 100644
>--- /dev/null
>+++ b/include/linux/oldapi.h
>@@ -0,0 +1,2 @@
>+#warning This driver uses old style API and needs to be rewritten or removed \
>+	from kernel
>  
>
Maybe this would be better (license and comments added).

-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
241B347EC88228DE51EE A49C4A73A25004CB2A10


--------------010609010507070201030903
Content-Type: text/plain;
 name="lnx-oldapi-6.13r3m3_1.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lnx-oldapi-6.13r3m3_1.txt"

diff --git a/include/linux/oldapi.h b/include/linux/oldapi.h
new file mode 100644
--- /dev/null
+++ b/include/linux/oldapi.h
@@ -0,0 +1,13 @@
+/**
+  * Include this file, if you think that the driver is old API styled
+  *
+  * Version:	1.0		28 Jul 2005	Initial version
+  *
+  * Author		Jiri Slaby <xslaby@fi.muni.cz>
+  *
+  * This software may be used and distributed according to the terms
+  * of the GNU General Public License, incorporated herein by reference.
+  */
+
+#warning This driver uses old style API and needs to be rewritten or removed \
+	from kernel

--------------010609010507070201030903--
