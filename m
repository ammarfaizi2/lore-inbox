Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264769AbUEETLG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264769AbUEETLG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 15:11:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264776AbUEETLG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 15:11:06 -0400
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:17352 "EHLO
	mail-in-07.arcor-online.net") by vger.kernel.org with ESMTP
	id S264769AbUEETLC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 15:11:02 -0400
From: Jan Killius <jkillius@arcor.de>
Reply-To: jkillius@arcor.de
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc3-mm2
Date: Wed, 5 May 2004 21:10:51 +0200
User-Agent: KMail/1.6.52
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_7wTmAhXbPmJzGb+"
Message-Id: <200405052110.51866.jkillius@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_7wTmAhXbPmJzGb+
Content-Type: text/plain;
  charset="us-ascii";
  boundary=""
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,
here is a small patch thats fix building on x86-64.

-- 
        Jan

--Boundary-00=_7wTmAhXbPmJzGb+
Content-Type: text/x-diff;
  charset="us-ascii";
  name="mempolice.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="mempolice.patch"

diff -Naur linux-2.6.6-rc3-mm2/arch/x86_64/ia32/ia32_binfmt.c linux-2.6.6-rc3-mm2.new/arch/x86_64/ia32/ia32_binfmt.c
--- linux-2.6.6-rc3-mm2/arch/x86_64/ia32/ia32_binfmt.c	2004-05-05 21:06:39.000000000 +0200
+++ linux-2.6.6-rc3-mm2.new/arch/x86_64/ia32/ia32_binfmt.c	2004-05-05 21:01:43.398886976 +0200
@@ -14,6 +14,7 @@
 #include <linux/string.h>
 #include <linux/binfmts.h>
 #include <linux/mm.h>
+#include <linux/mempolicy.h>
 #include <linux/security.h>
 
 #include <asm/segment.h> 

--Boundary-00=_7wTmAhXbPmJzGb+--
