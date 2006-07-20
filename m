Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964879AbWGTARb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964879AbWGTARb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 20:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964881AbWGTARb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 20:17:31 -0400
Received: from mailrelay3.sunrise.ch ([194.158.229.31]:39344 "EHLO
	obelix.sunrise.ch") by vger.kernel.org with ESMTP id S964879AbWGTARa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 20:17:30 -0400
Date: Wed, 19 Jul 2006 20:13:21 -0400
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] i386: make CONFIG_EFI depend on EXPERIMENTAL
Message-ID: <20060720001321.GC8584@krypton>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
From: apgo@patchbomb.org (Arthur Othieno)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It is labelled as such, but doesn't actually depend on EXPERIMENTAL.

Signed-off-by: Arthur Othieno <apgo@patchbomb.org>
---
 arch/i386/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/i386/Kconfig b/arch/i386/Kconfig
index 84c1b29..8577043 100644
--- a/arch/i386/Kconfig
+++ b/arch/i386/Kconfig
@@ -673,7 +673,7 @@ config MTRR
 
 config EFI
 	bool "Boot from EFI support (EXPERIMENTAL)"
-	depends on ACPI
+	depends on ACPI && EXPERIMENTAL
 	default n
 	---help---
 	This enables the the kernel to boot on EFI platforms using
-- 
1.4.0

