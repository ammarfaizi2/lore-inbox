Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261420AbVFBNoo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261420AbVFBNoo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 09:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261425AbVFBNoo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 09:44:44 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:40463 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261420AbVFBNom (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 09:44:42 -0400
Date: Thu, 2 Jun 2005 15:44:39 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Cosmin Nicolaescu <cos@camelot.homelinux.com>,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] remove redundant info from SubmittingPatches
Message-ID: <20050602134438.GF4992@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since the Trivial Patch Monkey is mentioned both in steps 4. and 5., I
removed it from step4 (Select e-mail destination), since it should go
under 'Select your CC list'.

Signed-off-by: Cosmin Nicolaescu <cos@camelot.homelinux.com>
Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was sent by Cosmin Nicolaescu on:
- 21 Apr 2005

--- linux-2.6.11/Documentation/SubmittingPatches.orig   2005-04-21 14:17:07.375698154 -0400
+++ linux-2.6.11/Documentation/SubmittingPatches        2005-04-21 15:34:58.588664206 -0400
@@ -132,21 +132,6 @@ which require discussion or do not have 
 usually be sent first to linux-kernel.  Only after the patch is
 discussed should the patch then be submitted to Linus.
 
-For small patches you may want to CC the Trivial Patch Monkey
-trivial@rustcorp.com.au set up by Rusty Russell; which collects "trivial"
-patches. Trivial patches must qualify for one of the following rules:
- Spelling fixes in documentation
- Spelling fixes which could break grep(1).
- Warning fixes (cluttering with useless warnings is bad)
- Compilation fixes (only if they are actually correct)
- Runtime fixes (only if they actually fix things)
- Removing use of deprecated functions/macros (eg. check_region).
- Contact detail and documentation fixes
- Non-portable code replaced by portable code (even in arch-specific,
- since people copy, as long as it's trivial)
- Any fix by the author/maintainer of the file. (ie. patch monkey
- in re-transmission mode)
-
 
 
 5) Select your CC (e-mail carbon copy) list.

