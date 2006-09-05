Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965084AbWIEPHL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965084AbWIEPHL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 11:07:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965085AbWIEPHL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 11:07:11 -0400
Received: from mail.gmx.de ([213.165.64.20]:6111 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S965084AbWIEPHJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 11:07:09 -0400
X-Authenticated: #2360897
Date: Tue, 5 Sep 2006 17:07:06 +0200
From: Bernhard Walle <bernhard.walle@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>
Subject: hrtimers -- high-resolution clock subsystem
Message-ID: <20060905150706.GB14242@mail1.bwalle.de>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

,----[ Documentation/hrtimers.txt]--
| We used the high-resolution clock subsystem ontop of hrtimers to
| verify the hrtimer implementation details in praxis
`----

I didn't find any "high-resolution clock subsystem" in the internet as
patch. Can you give me the point or did I got this sentence wrong?
Thanks.

BTW: There's a typo in this text, patch below. And I hope the patch is
correct. Or would an extra email for this be better?

-------------------------------------------------------------------------
Fixed typo in hrtimers documentation.

Signed-off-by: Bernhard Walle <bernhard.walle@gmx.de>

---
 hrtimers.txt |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- Documentation/hrtimers.txt.orig	2006-09-05 16:53:51.000000000 +0200
+++ Documentation/hrtimers.txt	2006-09-05 16:54:48.000000000 +0200
@@ -149,7 +149,7 @@
 ----------------------------------
 
 We used the high-resolution clock subsystem ontop of hrtimers to verify
-the hrtimer implementation details in praxis, and we also ran the posix
+the hrtimer implementation details in practise, and we also ran the posix
 timer tests in order to ensure specification compliance. We also ran
 tests on low-resolution clocks.
 

