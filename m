Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751273AbVLCQYf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751273AbVLCQYf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 11:24:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbVLCQYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 11:24:35 -0500
Received: from aveiro.procergs.com.br ([200.198.128.42]:18874 "EHLO
	aveiro.procergs.com.br") by vger.kernel.org with ESMTP
	id S1751273AbVLCQYe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 11:24:34 -0500
Cc: Otavio Salvador <otavio@debian.org>
Subject: [PATCH] Revert my comment change did in [PATCH] OSS: replace all uses of pci_module_init with pci_register_driver
In-Reply-To: <11336254302237-git-send-email-otavio@debian.org>
X-Mailer: git-send-email
Date: Sat, 3 Dec 2005 14:24:27 -0200
Message-Id: <11336270673942-git-send-email-otavio@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Otavio Salvador <otavio@debian.org>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Otavio Salvador <otavio@debian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Otavio Salvador <otavio@debian.org>


---

 sound/oss/es1371.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

applies-to: fa7c34e6bdc9208dec681eb41707029371db3703
1518764e5ded4c388408da73c561e37fc28bf2ce
diff --git a/sound/oss/es1371.c b/sound/oss/es1371.c
index f770df8..5c697f1 100644
--- a/sound/oss/es1371.c
+++ b/sound/oss/es1371.c
@@ -94,7 +94,7 @@
  *    07.02.2000   0.24  Use pci_alloc_consistent and pci_register_driver
  *    07.02.2000   0.25  Use ac97_codec
  *    01.03.2000   0.26  SPDIF patch by Mikael Bouillot <mikael.bouillot@bigfoot.com>
- *                       Use pci_register_driver
+ *                       Use pci_module_init
  *    21.11.2000   0.27  Initialize dma buffers in poll, otherwise poll may return a bogus mask
  *    12.12.2000   0.28  More dma buffer initializations, patch from
  *                       Tjeerd Mulder <tjeerd.mulder@fujitsu-siemens.com>
---
0.99.9k


