Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264231AbTFKUCY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 16:02:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264186AbTFKUCK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 16:02:10 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:5534 "EHLO
	grelber.thyrsus.com") by vger.kernel.org with ESMTP id S264231AbTFKUBy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 16:01:54 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation/SendingPatches [2 of 2].
Date: Wed, 11 Jun 2003 16:18:10 -0400
User-Agent: KMail/1.5
Cc: torvalds@transmeta.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306111618.10329.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The bit about log rolling.

--- linux-new/Documentation/SubmittingPatches	2003-06-11 15:54:29.000000000 -0400
+++ linux-new/Documentation/SubmittingPatches2	2003-06-11 15:54:06.000000000 -0400
@@ -92,6 +92,16 @@
 complete, that is OK.  Simply note "this patch depends on patch X"
 in your patch description.
 
+In politics, there's a concept called "log rolling", where unrelated
+amendments are bundled together so that changes people want grease the
+way for changes they don't.  Do not do this.  It's annoying.
+
+In coding, this sort of thing can be very subtle, such as performance increases
+that help your new version perform as well as the original while doing more
+work, but which could also have been applied to the original making it even
+faster.  The linux-kernel guys are very good at taking the chocolate coating
+and leaving the pill behind.  This can be very frustrating to developers, but
+it's one of the big reasons open source produces such excellent results.
 
 4) Select e-mail destination.
 
