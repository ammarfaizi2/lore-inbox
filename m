Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264884AbUHQKjI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264884AbUHQKjI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 06:39:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264919AbUHQKjI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 06:39:08 -0400
Received: from gprs214-155.eurotel.cz ([160.218.214.155]:14472 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S264884AbUHQKjF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 06:39:05 -0400
Date: Tue, 17 Aug 2004 12:38:52 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: Coding style: do_this(a,b) vs. do_this(a, b)
Message-ID: <20040817103852.GA18758@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Coding style document is not consistent with itself on whether there
should be space after ","... This makes it standartize on ", " option.

								Pavel

--- tmp/linux/Documentation/CodingStyle	2004-05-20 23:08:01.000000000 +0200
+++ linux/Documentation/CodingStyle	2004-06-06 00:27:11.000000000 +0200
@@ -356,11 +356,11 @@
 
 Macros with multiple statements should be enclosed in a do - while block:
 
-#define macrofun(a,b,c) 			\
+#define macrofun(a, b, c) 			\
 	do {					\
 		if (a == 5)			\
-			do_this(b,c);		\
-	} while (0)
+			do_this(b, c);		\
+	} while(0)
 
 Things to avoid when using macros:
 

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
