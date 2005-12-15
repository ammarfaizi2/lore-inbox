Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422654AbVLOJSy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422654AbVLOJSy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 04:18:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422655AbVLOJSx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 04:18:53 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:61571 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1422652AbVLOJSu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 04:18:50 -0500
To: torvalds@osdl.org
Subject: [PATCH] arch/alpha/kernel/machvec_impl.h: C99 struct initializer
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1EmpGE-00080g-3n@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Thu, 15 Dec 2005 09:18:50 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>


---

 arch/alpha/kernel/machvec_impl.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

3f17a6cb755122a5ef7e3585ebe89b718747195d
diff --git a/arch/alpha/kernel/machvec_impl.h b/arch/alpha/kernel/machvec_impl.h
index 4959b7a..11f996f 100644
--- a/arch/alpha/kernel/machvec_impl.h
+++ b/arch/alpha/kernel/machvec_impl.h
@@ -41,7 +41,7 @@
 #define CAT1(x,y)  x##y
 #define CAT(x,y)   CAT1(x,y)
 
-#define DO_DEFAULT_RTC rtc_port: 0x70
+#define DO_DEFAULT_RTC .rtc_port = 0x70
 
 #define DO_EV4_MMU							\
 	.max_asn =			EV4_MAX_ASN,			\
-- 
0.99.9.GIT

