Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277382AbRJVA5Q>; Sun, 21 Oct 2001 20:57:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277385AbRJVA5G>; Sun, 21 Oct 2001 20:57:06 -0400
Received: from noodles.codemonkey.org.uk ([62.49.180.5]:33220 "EHLO
	noodles.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id <S277382AbRJVA44>; Sun, 21 Oct 2001 20:56:56 -0400
Date: Mon, 22 Oct 2001 01:58:41 +0100
From: Dave Jones <davej@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [patch] mangled include in ac5
Message-ID: <20011022015841.A13543@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mindnumbingly boring compile fix...

regards,

Dave.

diff -urN --exclude-from=/home/davej/.exclude linux/net/ipv4/ipconfig.c linux-dj/net/ipv4/ipconfig.c
--- linux/net/ipv4/ipconfig.c	Mon Oct 22 00:27:20 2001
+++ linux-dj/net/ipv4/ipconfig.c	Mon Oct 22 00:22:03 2001
@@ -53,7 +53,7 @@
 
 #include <asm/uaccess.h>
 #include <asm/checksum.h>
-#inclued <asm/processor.h>
+#include <asm/processor.h>
 
 /* Define this to allow debugging output */
 #undef IPCONFIG_DEBUG

-- 
| Dave Jones.                    http://www.codemonkey.org.uk
| SuSE Labs .
