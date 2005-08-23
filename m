Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932343AbVHWUAU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932343AbVHWUAU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 16:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932357AbVHWUAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 16:00:20 -0400
Received: from sccrmhc14.comcast.net ([63.240.76.49]:24502 "EHLO
	sccrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S932343AbVHWUAU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 16:00:20 -0400
Message-ID: <430B8063.8070301@temple.edu>
Date: Tue, 23 Aug 2005 16:00:35 -0400
From: Nick Sillik <n.sillik@temple.edu>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050727)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: [-mm PATCH] drivers/char/speakup/synthlist.h - Fix warnings with
 -Wundef
Content-Type: multipart/mixed;
 boundary="------------090903010707050208020304"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090903010707050208020304
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch fixes (it should) the following warnings generated with -Wundef in the file 
drivers/char/speakup/synthlist.h

drivers/char/speakup/synthlist.h:13:35: warning: "CONFIG_SPEAKUP_ACNTPC" is not defined
drivers/char/speakup/synthlist.h:16:35: warning: "CONFIG_SPEAKUP_ACNTSA" is not defined
drivers/char/speakup/synthlist.h:19:35: warning: "CONFIG_SPEAKUP_APOLLO" is not defined
drivers/char/speakup/synthlist.h:22:35: warning: "CONFIG_SPEAKUP_AUDPTR" is not defined
drivers/char/speakup/synthlist.h:25:32: warning: "CONFIG_SPEAKUP_BNS" is not defined
drivers/char/speakup/synthlist.h:28:35: warning: "CONFIG_SPEAKUP_DECEXT" is not defined
drivers/char/speakup/synthlist.h:31:35: warning: "CONFIG_SPEAKUP_DECTLK" is not defined
drivers/char/speakup/synthlist.h:34:33: warning: "CONFIG_SPEAKUP_DTLK" is not defined
drivers/char/speakup/synthlist.h:37:34: warning: "CONFIG_SPEAKUP_KEYPC" is not defined
drivers/char/speakup/synthlist.h:40:33: warning: "CONFIG_SPEAKUP_LTLK" is not defined
drivers/char/speakup/synthlist.h:43:35: warning: "CONFIG_SPEAKUP_SFTSYN" is not defined
drivers/char/speakup/synthlist.h:46:35: warning: "CONFIG_SPEAKUP_SPKOUT" is not defined
drivers/char/speakup/synthlist.h:49:34: warning: "CONFIG_SPEAKUP_TXPRT" is not defined
drivers/char/speakup/synthlist.h:13:35: warning: "CONFIG_SPEAKUP_ACNTPC" is not defined
drivers/char/speakup/synthlist.h:16:35: warning: "CONFIG_SPEAKUP_ACNTSA" is not defined
drivers/char/speakup/synthlist.h:19:35: warning: "CONFIG_SPEAKUP_APOLLO" is not defined
drivers/char/speakup/synthlist.h:22:35: warning: "CONFIG_SPEAKUP_AUDPTR" is not defined
drivers/char/speakup/synthlist.h:25:32: warning: "CONFIG_SPEAKUP_BNS" is not defined
drivers/char/speakup/synthlist.h:28:35: warning: "CONFIG_SPEAKUP_DECEXT" is not defined
drivers/char/speakup/synthlist.h:31:35: warning: "CONFIG_SPEAKUP_DECTLK" is not defined
drivers/char/speakup/synthlist.h:34:33: warning: "CONFIG_SPEAKUP_DTLK" is not defined
drivers/char/speakup/synthlist.h:37:34: warning: "CONFIG_SPEAKUP_KEYPC" is not defined
drivers/char/speakup/synthlist.h:40:33: warning: "CONFIG_SPEAKUP_LTLK" is not defined
drivers/char/speakup/synthlist.h:43:35: warning: "CONFIG_SPEAKUP_SFTSYN" is not defined
drivers/char/speakup/synthlist.h:46:35: warning: "CONFIG_SPEAKUP_SPKOUT" is not defined
drivers/char/speakup/synthlist.h:49:34: warning: "CONFIG_SPEAKUP_TXPRT" is not defined
drivers/char/speakup/synthlist.h:13:35: warning: "CONFIG_SPEAKUP_ACNTPC" is not defined
drivers/char/speakup/synthlist.h:16:35: warning: "CONFIG_SPEAKUP_ACNTSA" is not defined
drivers/char/speakup/synthlist.h:19:35: warning: "CONFIG_SPEAKUP_APOLLO" is not defined
drivers/char/speakup/synthlist.h:22:35: warning: "CONFIG_SPEAKUP_AUDPTR" is not defined
drivers/char/speakup/synthlist.h:25:32: warning: "CONFIG_SPEAKUP_BNS" is not defined
drivers/char/speakup/synthlist.h:28:35: warning: "CONFIG_SPEAKUP_DECEXT" is not defined
drivers/char/speakup/synthlist.h:31:35: warning: "CONFIG_SPEAKUP_DECTLK" is not defined
drivers/char/speakup/synthlist.h:34:33: warning: "CONFIG_SPEAKUP_DTLK" is not defined
drivers/char/speakup/synthlist.h:37:34: warning: "CONFIG_SPEAKUP_KEYPC" is not defined
drivers/char/speakup/synthlist.h:40:33: warning: "CONFIG_SPEAKUP_LTLK" is not defined
drivers/char/speakup/synthlist.h:43:35: warning: "CONFIG_SPEAKUP_SFTSYN" is not defined
drivers/char/speakup/synthlist.h:46:35: warning: "CONFIG_SPEAKUP_SPKOUT" is not defined
drivers/char/speakup/synthlist.h:49:34: warning: "CONFIG_SPEAKUP_TXPRT" is not defined
drivers/char/speakup/synthlist.h:13:35: warning: "CONFIG_SPEAKUP_ACNTPC" is not defined
drivers/char/speakup/synthlist.h:16:35: warning: "CONFIG_SPEAKUP_ACNTSA" is not defined
drivers/char/speakup/synthlist.h:19:35: warning: "CONFIG_SPEAKUP_APOLLO" is not defined
drivers/char/speakup/synthlist.h:22:35: warning: "CONFIG_SPEAKUP_AUDPTR" is not defined
drivers/char/speakup/synthlist.h:25:32: warning: "CONFIG_SPEAKUP_BNS" is not defined
drivers/char/speakup/synthlist.h:28:35: warning: "CONFIG_SPEAKUP_DECEXT" is not defined
drivers/char/speakup/synthlist.h:31:35: warning: "CONFIG_SPEAKUP_DECTLK" is not defined
drivers/char/speakup/synthlist.h:34:33: warning: "CONFIG_SPEAKUP_DTLK" is not defined
drivers/char/speakup/synthlist.h:37:34: warning: "CONFIG_SPEAKUP_KEYPC" is not defined
drivers/char/speakup/synthlist.h:40:33: warning: "CONFIG_SPEAKUP_LTLK" is not defined
drivers/char/speakup/synthlist.h:43:35: warning: "CONFIG_SPEAKUP_SFTSYN" is not defined
drivers/char/speakup/synthlist.h:46:35: warning: "CONFIG_SPEAKUP_SPKOUT" is not defined
drivers/char/speakup/synthlist.h:49:34: warning: "CONFIG_SPEAKUP_TXPRT" is not defined

Signed-off-by: Nick Sillik <n.sillik@temple.edu>

--------------090903010707050208020304
Content-Type: text/x-patch;
 name="speakup-wundef.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="speakup-wundef.patch"

diff -urN linux-2.6.13-rc6-mm2/drivers/char/speakup/synthlist.h linux-2.6.13-rc6-mm2-patched/drivers/char/speakup/synthlist.h
--- linux-2.6.13-rc6-mm2/drivers/char/speakup/synthlist.h	2005-08-23 15:51:31.000000000 -0400
+++ linux-2.6.13-rc6-mm2-patched/drivers/char/speakup/synthlist.h	2005-08-23 15:57:30.000000000 -0400
@@ -7,7 +7,7 @@
 /* declare extern built in synths */
 #define SYNTH_DECL(who) extern struct spk_synth synth_##who;
 #define PASS2
-#define  CFG_TEST(name) (name)
+#define  CFG_TEST(name) defined(name)
 #endif
 
 #if CFG_TEST(CONFIG_SPEAKUP_ACNTPC)

--------------090903010707050208020304--
