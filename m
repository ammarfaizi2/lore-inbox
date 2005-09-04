Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932141AbVIDXn1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932141AbVIDXn1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 19:43:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932137AbVIDXnG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 19:43:06 -0400
Received: from allen.werkleitz.de ([80.190.251.108]:48257 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S932136AbVIDXat
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 19:30:49 -0400
Message-Id: <20050904232332.497514000@abc>
References: <20050904232259.777473000@abc>
Date: Mon, 05 Sep 2005 01:23:41 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Manu Abraham <manu@linuxtv.org>
Content-Disposition: inline; filename=dvb-bt8xx-dst-ci-doc-update.patch
X-SA-Exim-Connect-IP: 84.189.198.88
Subject: [DVB patch 42/54] dst: ci doc update
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manu Abraham <manu@linuxtv.org>

Updated documentation

Signed-off-by: Manu Abraham <manu@linuxtv.org>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 Documentation/dvb/ci.txt |    9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

--- linux-2.6.13-git4.orig/Documentation/dvb/ci.txt	2005-09-04 22:24:23.000000000 +0200
+++ linux-2.6.13-git4/Documentation/dvb/ci.txt	2005-09-04 22:28:38.000000000 +0200
@@ -23,7 +23,6 @@ This application requires the following 
 	  eg: $ szap -c channels.conf -r "TMC" -x
 
 	(b) a channels.conf containing a valid PMT PID
-
 	  eg: TMC:11996:h:0:27500:278:512:650:321
 
 	  here 278 is a valid PMT PID. the rest of the values are the
@@ -31,13 +30,7 @@ This application requires the following 
 
 	(c) after running a szap, you have to run ca_zap, for the
 	  descrambler to function,
-
-	  eg: $ ca_zap patched_channels.conf "TMC"
-
-	  The patched means a patch to apply to scan, such that scan can
-	  generate a channels.conf_with pmt, which has this PMT PID info
-	  (NOTE: szap cannot use this channels.conf with the PMT_PID)
-
+	  eg: $ ca_zap channels.conf "TMC"
 
 	(d) Hopeflly Enjoy your favourite subscribed channel as you do with
 	  a FTA card.

--

