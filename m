Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936532AbWLARJf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936532AbWLARJf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 12:09:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936533AbWLARJf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 12:09:35 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:40970 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S936532AbWLARJe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 12:09:34 -0500
Date: Fri, 1 Dec 2006 18:09:38 +0100
From: Adrian Bunk <bunk@stusta.de>
To: ak@suse.de
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] include/asm-x86_64/cpufeature.h isn't a userspace header
Message-ID: <20061201170938.GE11084@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nothing in include/asm-x86_64/cpufeature.h is part of the 
userspace<->kernel interface.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.19-rc6-mm2/include/asm-x86_64/Kbuild.old	2006-12-01 18:05:31.000000000 +0100
+++ linux-2.6.19-rc6-mm2/include/asm-x86_64/Kbuild	2006-12-01 18:05:37.000000000 +0100
@@ -6,7 +6,6 @@
 
 header-y += boot.h
 header-y += bootsetup.h
-header-y += cpufeature.h
 header-y += debugreg.h
 header-y += ldt.h
 header-y += msr.h

