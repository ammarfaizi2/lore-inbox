Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313898AbSGYNcj>; Thu, 25 Jul 2002 09:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314459AbSGYNbL>; Thu, 25 Jul 2002 09:31:11 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:3325 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S314451AbSGYNa1>; Thu, 25 Jul 2002 09:30:27 -0400
From: Alan Cox <alan@irongate.swansea.linux.org.uk>
Message-Id: <200207251447.g6PEldNP010447@irongate.swansea.linux.org.uk>
Subject: PATCH: 2.5.28 (resend #1) ad1848_lib does not build
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Thu, 25 Jul 2002 15:47:39 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.28/sound/isa/ad1848/ad1848_lib.c linux-2.5.28-ac1/sound/isa/ad1848/ad1848_lib.c
--- linux-2.5.28/sound/isa/ad1848/ad1848_lib.c	Thu Jul 25 10:51:10 2002
+++ linux-2.5.28-ac1/sound/isa/ad1848/ad1848_lib.c	Sun Jul 21 17:28:32 2002
@@ -26,6 +26,7 @@
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/ioport.h>
+#include <linux/init.h>
 #include <sound/core.h>
 #include <sound/ad1848.h>
 
