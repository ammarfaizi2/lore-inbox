Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264323AbUD0UDn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264323AbUD0UDn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 16:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264310AbUD0UDm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 16:03:42 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:36480 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S264323AbUD0UDb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 16:03:31 -0400
Date: Tue, 27 Apr 2004 13:03:29 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix thinkos in #if -> #ifdef conversions
Message-ID: <20040427200329.GE1655@smtp.west.cox.net>
References: <20040427192408.GC1655@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040427192408.GC1655@smtp.west.cox.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2004 at 12:24:09PM -0700, Tom Rini wrote:

> <donning brown paper bag>

<crawling into a hole to hide>

And when trying to catch up on old patches, I forgot this hunk:
===== arch/ppc/platforms/prep_setup.c 1.44 vs edited =====
--- 1.44/arch/ppc/platforms/prep_setup.c	Wed Apr  7 16:02:57 2004
+++ edited/arch/ppc/platforms/prep_setup.c	Tue Apr 27 13:01:57 2004
@@ -134,6 +134,7 @@
 #define PREP_IBM_CAROLINA_IDE_0	0xf0
 #define PREP_IBM_CAROLINA_IDE_1	0xf1
 #define PREP_IBM_CAROLINA_IDE_2	0xf2
+#define PREP_IBM_CAROLINA_IDE_3	0xf3
 /* 7248-43P */
 #define PREP_IBM_CAROLINA_SCSI_0	0xf4
 #define PREP_IBM_CAROLINA_SCSI_1	0xf5

-- 
Tom Rini
http://gate.crashing.org/~trini/
