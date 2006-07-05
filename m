Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964891AbWGEQ5v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964891AbWGEQ5v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 12:57:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964893AbWGEQ5v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 12:57:51 -0400
Received: from mail.suse.de ([195.135.220.2]:51144 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964891AbWGEQ5v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 12:57:51 -0400
From: Andreas Schwab <schwab@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] Makefile typo
Cc: linux-kernel@vger.kernel.org
X-Yow: Is this the line for the latest whimsical YUGOSLAVIAN drama which also
 makes you want to CRY and reconsider the VIETNAM WAR?
Date: Wed, 05 Jul 2006 18:57:48 +0200
Message-ID: <je1wt0ng4z.fsf@sykes.suse.de>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a typo in the toplevel makefile.

Signed-off-by: Andreas Schwab <schwab@suse.de>

diff --git a/Makefile b/Makefile
index 11a850c..82f76a9 100644
--- a/Makefile
+++ b/Makefile
@@ -528,7 +528,7 @@ #  INSTALL_MOD_STRIP will used as the op
 
 ifdef INSTALL_MOD_STRIP
 ifeq ($(INSTALL_MOD_STRIP),1)
-mod_strip_cmd = $STRIP) --strip-debug
+mod_strip_cmd = $(STRIP) --strip-debug
 else
 mod_strip_cmd = $(STRIP) $(INSTALL_MOD_STRIP)
 endif # INSTALL_MOD_STRIP=1

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
