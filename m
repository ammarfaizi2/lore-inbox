Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262465AbVG0USH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262465AbVG0USH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 16:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262436AbVG0USB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 16:18:01 -0400
Received: from ms-smtp-02-smtplb.rdc-nyc.rr.com ([24.29.109.6]:7654 "EHLO
	ms-smtp-02.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id S262465AbVG0URR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 16:17:17 -0400
Message-ID: <42E7EBA9.5070404@temple.edu>
Date: Wed, 27 Jul 2005 16:16:41 -0400
From: Nick Sillik <n.sillik@temple.edu>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: drivers/char/speakup/synthlist.h fix -Wundef errors
Content-Type: multipart/mixed;
 boundary="------------030408000702020305040208"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030408000702020305040208
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch should fix a slew of -Wundef errors in the synthlist.h file 
used by the speakup driver.

Nick Sillik
n.sillik@temple.edu

--------------030408000702020305040208
Content-Type: text/plain;
 name="synthlist_wundef.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="synthlist_wundef.patch"

diff -urN a/drivers/char/speakup/synthlist.h b/drivers/char/speakup/synthlist.h
--- a/drivers/char/speakup/synthlist.h	2005-07-27 16:10:04.000000000 -0400
+++ b/drivers/char/speakup/synthlist.h	2005-07-27 16:12:23.000000000 -0400
@@ -10,43 +10,43 @@
 #define  CFG_TEST(name) (name)
 #endif
 
-#if CFG_TEST(CONFIG_SPEAKUP_ACNTPC)
+#ifdef CFG_TEST(CONFIG_SPEAKUP_ACNTPC)
 SYNTH_DECL(acntpc)
 #endif
-#if CFG_TEST(CONFIG_SPEAKUP_ACNTSA)
+#ifdef CFG_TEST(CONFIG_SPEAKUP_ACNTSA)
 SYNTH_DECL(acntsa)
 #endif
-#if CFG_TEST(CONFIG_SPEAKUP_APOLLO)
+#ifdef CFG_TEST(CONFIG_SPEAKUP_APOLLO)
 SYNTH_DECL(apollo)
 #endif
-#if CFG_TEST(CONFIG_SPEAKUP_AUDPTR)
+#ifdef CFG_TEST(CONFIG_SPEAKUP_AUDPTR)
 SYNTH_DECL(audptr)
 #endif
-#if CFG_TEST(CONFIG_SPEAKUP_BNS)
+#ifdef CFG_TEST(CONFIG_SPEAKUP_BNS)
 SYNTH_DECL(bns)
 #endif
-#if CFG_TEST(CONFIG_SPEAKUP_DECEXT)
+#ifdef CFG_TEST(CONFIG_SPEAKUP_DECEXT)
 SYNTH_DECL(decext)
 #endif
-#if CFG_TEST(CONFIG_SPEAKUP_DECTLK)
+#ifdef CFG_TEST(CONFIG_SPEAKUP_DECTLK)
 SYNTH_DECL(dectlk)
 #endif
-#if CFG_TEST(CONFIG_SPEAKUP_DTLK)
+#ifdef CFG_TEST(CONFIG_SPEAKUP_DTLK)
 SYNTH_DECL(dtlk)
 #endif
-#if CFG_TEST(CONFIG_SPEAKUP_KEYPC)
+#ifdef CFG_TEST(CONFIG_SPEAKUP_KEYPC)
 SYNTH_DECL(keypc)
 #endif
-#if CFG_TEST(CONFIG_SPEAKUP_LTLK)
+#ifdef CFG_TEST(CONFIG_SPEAKUP_LTLK)
 SYNTH_DECL(ltlk)
 #endif
-#if CFG_TEST(CONFIG_SPEAKUP_SFTSYN)
+#ifdef CFG_TEST(CONFIG_SPEAKUP_SFTSYN)
 SYNTH_DECL(sftsyn)
 #endif
-#if CFG_TEST(CONFIG_SPEAKUP_SPKOUT)
+#ifdef CFG_TEST(CONFIG_SPEAKUP_SPKOUT)
 SYNTH_DECL(spkout)
 #endif
-#if CFG_TEST(CONFIG_SPEAKUP_TXPRT)
+#ifdef CFG_TEST(CONFIG_SPEAKUP_TXPRT)
 SYNTH_DECL(txprt)
 #endif
 

--------------030408000702020305040208--
