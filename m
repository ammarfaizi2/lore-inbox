Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261810AbVDUTgK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261810AbVDUTgK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 15:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbVDUTgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 15:36:10 -0400
Received: from shim1.irt.drexel.edu ([144.118.29.71]:16276 "EHLO
	shim1.irt.drexel.edu") by vger.kernel.org with ESMTP
	id S261810AbVDUTgG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 15:36:06 -0400
Date: Thu, 21 Apr 2005 15:36:03 -0400
From: Cosmin Nicolaescu <cos@camelot.homelinux.com>
Subject: [PATCH 2.6.11] Documentation [corrected]: remove redundant info from
 SubmittingPatches
To: linux-kernel@vger.kernel.org
Cc: trivial@rustcorp.com.au
Message-id: <20050421193603.4386.qmail@camelot.homelinux.com>
MIME-version: 1.0
Content-type: TEXT/PLAIN
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since the Trivial Patch Monkey is mentioned both in steps 4. and 5., I
removed it from step4 (Select e-mail destination), since it should go
under 'Select your CC list'.

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

Signed-off-by: Cosmin Nicolaescu <cos@camelot.homelinux.com>
