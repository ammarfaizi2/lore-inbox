Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262684AbSI1CKD>; Fri, 27 Sep 2002 22:10:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262685AbSI1CKD>; Fri, 27 Sep 2002 22:10:03 -0400
Received: from [216.40.201.6] ([216.40.201.6]:14610 "EHLO
	www.businesssite.com.br") by vger.kernel.org with ESMTP
	id <S262684AbSI1CKD>; Fri, 27 Sep 2002 22:10:03 -0400
Date: Fri, 27 Sep 2002 23:10:18 -0300
To: linux-kernel@vger.kernel.org
Subject: [patch] 'tags' target in makefile broken
Message-ID: <20020928021018.GA368@cathedrallabs.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline
From: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

hi,
	little typo in Makefile

-- 
aris

--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="makefile.patch"

--- linux-2.5.39-vanilla/Makefile	2002-09-27 23:01:19.000000000 -0300
+++ linux-2.5.39/Makefile	2002-09-27 22:47:42.000000000 -0300
@@ -756,7 +756,7 @@
 	  find arch/$(ARCH) $(RCS_FIND_IGNORE) \
 	       -name '*.[chS]' -print; \
 	  find include $(RCS_FIND_IGNORE) \
-	       \( -name config -o -name 'asm-*' \) -prune -o \
+	       \( -name config -o -name 'asm-*' \) -prune \
 	       -o -name '*.[chS]' -print; \
 	  find include/asm-$(ARCH) $(RCS_FIND_IGNORE) \
 	       -name '*.[chS]' -print; \

--5vNYLRcllDrimb99--
