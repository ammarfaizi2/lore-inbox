Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030528AbWKVERi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030528AbWKVERi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 23:17:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030683AbWKVERe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 23:17:34 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:17677 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S967089AbWKVER2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 23:17:28 -0500
Date: Wed, 22 Nov 2006 05:17:27 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Roy Zang <tie-fei.zang@freescale.com>
Cc: Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org
Subject: [2.6 patch] arch/powerpc/Kconfig: fix the EMBEDDED6xx dependencies
Message-ID: <20061122041727.GA5200@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes the EMBEDDED6xx dependencies to the equivalent 
dependency that seems to have been intended.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.19-rc5-mm2/arch/powerpc/Kconfig.old	2006-11-22 02:24:21.000000000 +0100
+++ linux-2.6.19-rc5-mm2/arch/powerpc/Kconfig	2006-11-22 02:24:34.000000000 +0100
@@ -369,7 +369,7 @@ config PPC_MULTIPLATFORM
 
 config EMBEDDED6xx
 	bool "Embedded 6xx/7xx/7xxx-based board"
-	depends on PPC32 && (BROKEN||BROKEN_ON_SMP)
+	depends on PPC32 && BROKEN_ON_SMP
 
 config APUS
 	bool "Amiga-APUS"

