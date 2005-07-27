Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262428AbVG0Pww@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262428AbVG0Pww (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 11:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262422AbVG0Pw3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 11:52:29 -0400
Received: from az33egw02.freescale.net ([192.88.158.103]:413 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S262109AbVG0PwG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 11:52:06 -0400
Date: Wed, 27 Jul 2005 10:51:54 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@nylon.am.freescale.net
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org,
       linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] ppc32: Mark boards that don't build as BROKEN
Message-ID: <Pine.LNX.4.61.0507271051270.12380@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marked APUS and GEMINI as BROKEN since they do not build at the platform
level.  We have requested that the maintainers of these boards/platforms
fix them by the time 2.6.15 is released or we plan on concerning them
unmaintained and thus removing them.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit 08b693c5a82934788fdedbe5a6f9bc5fc67118e4
tree d9e1a5932246a8d376f14f5f6d62c601370a13f8
parent a287e1a2f397c7c4aeba88169b413500bd642fcc
author Kumar K. Gala <kumar.gala@freescale.com> Wed, 27 Jul 2005 10:51:06 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Wed, 27 Jul 2005 10:51:06 -0500

 arch/ppc/Kconfig |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/ppc/Kconfig b/arch/ppc/Kconfig
--- a/arch/ppc/Kconfig
+++ b/arch/ppc/Kconfig
@@ -529,6 +529,7 @@ config PPC_MULTIPLATFORM
 
 config APUS
 	bool "Amiga-APUS"
+	depends on BROKEN
 	help
 	  Select APUS if configuring for a PowerUP Amiga.
 	  More information is available at:
@@ -606,6 +607,7 @@ config PAL4
 
 config GEMINI
 	bool "Synergy-Gemini"
+	depends on BROKEN
 	help
 	  Select Gemini if configuring for a Synergy Microsystems' Gemini
 	  series Single Board Computer.  More information is available at:
