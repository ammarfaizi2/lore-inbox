Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261734AbVE3UKb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261734AbVE3UKb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 16:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261735AbVE3UKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 16:10:31 -0400
Received: from tron.kn.vutbr.cz ([147.229.191.152]:55055 "EHLO
	tron.kn.vutbr.cz") by vger.kernel.org with ESMTP id S261734AbVE3UKX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 16:10:23 -0400
Message-ID: <429B7328.7060208@stud.feec.vutbr.cz>
Date: Mon, 30 May 2005 22:10:16 +0200
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050506)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: akpm@osdl.org
CC: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: [PATCH] Add offset.h to dontdiff
Content-Type: multipart/mixed;
 boundary="------------070103030708040808090704"
X-Spam-Flag: NO
X-Spam-Report: Spam detection software, running on the system "tron.kn.vutbr.cz", has
  tested this incoming email. See other headers to know if the email
  has beed identified as possible spam.  The original message
  has been attached to this so you can view it (if it isn't spam) or block
  similar future email.  If you have any questions, see
  the administrator of that system for details.
  ____
  Content analysis details:   (-3.9 points, 6.0 required)
  ____
   pts rule name              description
  ---- ---------------------- --------------------------------------------
   0.7 FROM_ENDS_IN_NUMS      From: ends in numbers
  -4.9 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
                              [score: 0.0000]
   0.3 MAILTO_TO_SPAM_ADDR    URI: Includes a link to a likely spammer email
  ____
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070103030708040808090704
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit

include/asm/offset.h is a generated file on x86_64 and mips.
Let's add it to Documentation/dontdiff.

Signed-off-by: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>


--------------070103030708040808090704
Content-Type: text/x-patch;
 name="dontdiff-offset.h.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dontdiff-offset.h.diff"

--- linux/Documentation/dontdiff.orig	2005-05-30 18:51:07.000000000 +0200
+++ linux/Documentation/dontdiff	2005-05-30 21:58:37.000000000 +0200
@@ -111,6 +111,7 @@
 mktables
 modpost
 modversions.h*
+offset.h
 offsets.h
 oui.c*
 parse.c*

--------------070103030708040808090704--
