Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751152AbWFTOlz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152AbWFTOlz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 10:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751153AbWFTOlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 10:41:55 -0400
Received: from f36.mail.ru ([194.67.57.74]:41737 "EHLO f36.mail.ru")
	by vger.kernel.org with ESMTP id S1751127AbWFTOly (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 10:41:54 -0400
From: olecom@mail.ru
To: Trivial Patch Monkey <trivial@kernel.org>
Cc: linux-kernel@vger.kernel.org, olecom@gmail.com
Subject: [TYPOS] a little bit of
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [158.194.64.191]
Date: Tue, 20 Jun 2006 18:41:53 +0400
Reply-To: olecom@mail.ru
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E1FshQP-000CON-00.olecom-mail-ru@f36.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ! Maybe this will be useful.


docs-kernlock_typo.spatch:


--- linux-source-2.6.16/Documentation/DocBook/kernel-locking.tmpl~ 2006-03-20 06:53:29.000000000 +0100
+++ linux-source-2.6.16/Documentation/DocBook/kernel-locking.tmpl 2006-06-09 06:56:58.038022250 +0200
@@ -1590,7 +1590,7 @@
     <para>
       Our final dilemma is this: when can we actually destroy the
       removed element?  Remember, a reader might be stepping through
-      this element in the list right now: it we free this element and
+      this element in the list right now: if we free this element and
       the <symbol>next</symbol> pointer changes, the reader will jump
       off into garbage and crash.  We need to wait until we know that
       all the readers who were traversing the list when we deleted the


docs-drv-overview_typo.spatch:


--- linux-source-2.6.16/Documentation/driver-model/overview.txt~ 2006-03-20 06:53:29.000000000 +0100
+++ linux-source-2.6.16/Documentation/driver-model/overview.txt 2006-06-09 06:52:00.171406750 +0200
@@ -18,7 +18,7 @@
 (sometimes just a list) for the devices they control. There wasn't any
 uniformity across the different bus types.
 
-The current driver model provides a comon, uniform data model for describing
+The current driver model provides a common, uniform data model for describing
 a bus and the devices that can appear under the bus. The unified bus
 model includes a set of common attributes which all busses carry, and a set
 of common callbacks, such as device discovery during bus probing, bus

