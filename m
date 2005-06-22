Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261392AbVFVPEN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261392AbVFVPEN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 11:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261407AbVFVPC6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 11:02:58 -0400
Received: from az33egw02.freescale.net ([192.88.158.103]:55283 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S261392AbVFVO6N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 10:58:13 -0400
Date: Wed, 22 Jun 2005 09:58:03 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@nylon.am.freescale.net
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix extra double quote in IPV4 Kconfig
Message-ID: <Pine.LNX.4.61.0506220957080.2654@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kconfig option had an extra double quote at the end of the line
which was causing in warning when building.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit 374e90e7fd4dffa513765adf6e28db4740119082
tree 8c2271bdea1c1c8de95c687f581048e485a16f73
parent 7a90b498a2d6f7884390f46d4611099007f2f778
author Kumar K. Gala <kumar.gala@freescale.com> Wed, 22 Jun 2005 11:36:22 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Wed, 22 Jun 2005 11:36:22 -0500

 net/ipv4/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/ipv4/Kconfig b/net/ipv4/Kconfig
--- a/net/ipv4/Kconfig
+++ b/net/ipv4/Kconfig
@@ -2,7 +2,7 @@
 # IP configuration
 #
 choice 
-	prompt "Choose IP: FIB lookup""
+	prompt "Choose IP: FIB lookup"
 	depends on INET
 	default IP_FIB_HASH
 
