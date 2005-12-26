Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932073AbVLZSAo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932073AbVLZSAo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 13:00:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932077AbVLZSAo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 13:00:44 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:60032 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932073AbVLZSAo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 13:00:44 -0500
Subject: [PATCH] SubmittingPatches: improve documentation re: buggy mailers
From: Lee Revell <rlrevell@joe-job.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 26 Dec 2005 13:05:24 -0500
Message-Id: <1135620324.8293.57.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are plenty of perfectly good mailers available that don't mangle
patches.  Warn users about buggy mailers in general and Thunderbird in
particular.

Signed-Off-By: Lee Revell <rlrevell@joe-job.com>

--- linux-2.6.15-rc5-rt2/Documentation/SubmittingPatches-orig	2005-12-26 13:01:51.000000000 -0500
+++ linux-2.6.15-rc5-rt2/Documentation/SubmittingPatches	2005-12-26 13:03:27.000000000 -0500
@@ -186,6 +186,10 @@
 For this reason, all patches should be submitting e-mail "inline".
 WARNING:  Be wary of your editor's word-wrap corrupting your patch,
 if you choose to cut-n-paste your patch.
+WARNING:  Avoid Mozilla's Thunderbird email client, unlike other 
+popular mailers it seems to be incapable of sending
+non-whitespace-damaged patches.
+
 
 Do not attach the patch as a MIME attachment, compressed or not.
 Many popular e-mail applications will not always transmit a MIME
@@ -193,8 +197,8 @@
 code.  A MIME attachment also takes Linus a bit more time to process,
 decreasing the likelihood of your MIME-attached change being accepted.
 
-Exception:  If your mailer is mangling patches then someone may ask
-you to re-send them using MIME.
+No exceptions.  If your mailer is mangling patches then you will be 
+told to get a better mailer.
 
 
 


