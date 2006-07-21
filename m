Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030417AbWGUIxF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030417AbWGUIxF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 04:53:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030418AbWGUIxE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 04:53:04 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:62940 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S1030417AbWGUIxD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 04:53:03 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Martin Waitz <tali@admingilde.org>
Subject: [PATCH][Doc] Include documentation for functions in drivers/base/class.c
Date: Fri, 21 Jul 2006 10:54:22 +0200
User-Agent: KMail/1.9.3
Cc: Randy Dunlap <rdunlap@xenotime.net>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607211054.23017.eike-kernel@sf-tec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/base/class.c is omitted by "make *docs". Add it to get documentation 
for class_create() and friends for free.

Signed-off-by: Rolf Eike Beer <eike-kernel@sf-tec.de>

---
commit 71f5e8f5ba65ff8f743095017e6a44f1b6f9fe51
tree c76a3509335af368adcfc70063225f0fce90adea
parent a61512454736a148d2add339eb2c682e86645f9f
author Rolf Eike Beer <eike-kernel@sf-tec.de> Fri, 21 Jul 2006 10:52:04 +0200
committer Rolf Eike Beer <beer@siso-eb-i34d.silicon-software.de> Fri, 21 Jul 2006 10:52:04 +0200

 Documentation/DocBook/kernel-api.tmpl |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Documentation/DocBook/kernel-api.tmpl b/Documentation/DocBook/kernel-api.tmpl
index 2d0cc38..5dac02e 100644
--- a/Documentation/DocBook/kernel-api.tmpl
+++ b/Documentation/DocBook/kernel-api.tmpl
@@ -388,6 +388,7 @@ X!Iinclude/linux/device.h
 -->
 !Edrivers/base/driver.c
 !Edrivers/base/core.c
+!Edrivers/base/class.c
 !Edrivers/base/firmware_class.c
 !Edrivers/base/transport_class.c
 !Edrivers/base/dmapool.c
