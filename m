Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933753AbWK0Vl1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933753AbWK0Vl1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 16:41:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933759AbWK0Vl1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 16:41:27 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:29417 "EHLO
	rubicon.netdirect.ca") by vger.kernel.org with ESMTP
	id S933753AbWK0Vl0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 16:41:26 -0500
X-Originating-Ip: 72.57.81.197
Date: Mon, 27 Nov 2006 16:37:35 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
cc: trivial@kernel.org
Subject: [PATCH] kconfig:  Remove obsolete CONFIG_DMA_IS_DMA32 entries from
 ia64 config files
Message-ID: <Pine.LNX.4.64.0611271631480.4759@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00, UPPERCASE_25_50 0.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Remove the obsolete CONFIG_DMA_IS_DMA32 entries from the various
"defconfig" files under arch/ia64.

Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>

---

 arch/ia64/configs/bigsur_defconfig    |    1 -
 arch/ia64/configs/gensparse_defconfig |    1 -
 arch/ia64/configs/sim_defconfig       |    1 -
 arch/ia64/configs/tiger_defconfig     |    1 -
 arch/ia64/configs/zx1_defconfig       |    1 -
 arch/ia64/defconfig                   |    1 -
 6 files changed, 6 deletions(-)

diff --git a/arch/ia64/configs/bigsur_defconfig b/arch/ia64/configs/bigsur_defconfig
index 90e9c2e..deab374 100644
--- a/arch/ia64/configs/bigsur_defconfig
+++ b/arch/ia64/configs/bigsur_defconfig
@@ -89,7 +89,6 @@ CONFIG_TIME_INTERPOLATION=y
 CONFIG_EFI=y
 CONFIG_GENERIC_IOMAP=y
 CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
-CONFIG_DMA_IS_DMA32=y
 # CONFIG_IA64_GENERIC is not set
 CONFIG_IA64_DIG=y
 # CONFIG_IA64_HP_ZX1 is not set
diff --git a/arch/ia64/configs/gensparse_defconfig b/arch/ia64/configs/gensparse_defconfig
index 0d29aa2..77f528b 100644
--- a/arch/ia64/configs/gensparse_defconfig
+++ b/arch/ia64/configs/gensparse_defconfig
@@ -90,7 +90,6 @@ CONFIG_TIME_INTERPOLATION=y
 CONFIG_EFI=y
 CONFIG_GENERIC_IOMAP=y
 CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
-CONFIG_DMA_IS_DMA32=y
 CONFIG_IA64_GENERIC=y
 # CONFIG_IA64_DIG is not set
 # CONFIG_IA64_HP_ZX1 is not set
diff --git a/arch/ia64/configs/sim_defconfig b/arch/ia64/configs/sim_defconfig
index d9146c3..cb023c4 100644
--- a/arch/ia64/configs/sim_defconfig
+++ b/arch/ia64/configs/sim_defconfig
@@ -90,7 +90,6 @@ CONFIG_TIME_INTERPOLATION=y
 CONFIG_EFI=y
 CONFIG_GENERIC_IOMAP=y
 CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
-CONFIG_DMA_IS_DMA32=y
 # CONFIG_IA64_GENERIC is not set
 # CONFIG_IA64_DIG is not set
 # CONFIG_IA64_HP_ZX1 is not set
diff --git a/arch/ia64/configs/tiger_defconfig b/arch/ia64/configs/tiger_defconfig
index 9d1cffb..5fbc241 100644
--- a/arch/ia64/configs/tiger_defconfig
+++ b/arch/ia64/configs/tiger_defconfig
@@ -90,7 +90,6 @@ CONFIG_TIME_INTERPOLATION=y
 CONFIG_EFI=y
 CONFIG_GENERIC_IOMAP=y
 CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
-CONFIG_DMA_IS_DMA32=y
 # CONFIG_IA64_GENERIC is not set
 CONFIG_IA64_DIG=y
 # CONFIG_IA64_HP_ZX1 is not set
diff --git a/arch/ia64/configs/zx1_defconfig b/arch/ia64/configs/zx1_defconfig
index 949dc46..ffa5c02 100644
--- a/arch/ia64/configs/zx1_defconfig
+++ b/arch/ia64/configs/zx1_defconfig
@@ -88,7 +88,6 @@ CONFIG_TIME_INTERPOLATION=y
 CONFIG_EFI=y
 CONFIG_GENERIC_IOMAP=y
 CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
-CONFIG_DMA_IS_DMA32=y
 # CONFIG_IA64_GENERIC is not set
 # CONFIG_IA64_DIG is not set
 CONFIG_IA64_HP_ZX1=y
diff --git a/arch/ia64/defconfig b/arch/ia64/defconfig
index 9001b3f..04789ae 100644
--- a/arch/ia64/defconfig
+++ b/arch/ia64/defconfig
@@ -90,7 +90,6 @@ CONFIG_TIME_INTERPOLATION=y
 CONFIG_EFI=y
 CONFIG_GENERIC_IOMAP=y
 CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
-CONFIG_DMA_IS_DMA32=y
 CONFIG_IA64_GENERIC=y
 # CONFIG_IA64_DIG is not set
 # CONFIG_IA64_HP_ZX1 is not set
