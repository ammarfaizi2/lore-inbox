Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932073AbVIDROE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932073AbVIDROE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 13:14:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932074AbVIDROE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 13:14:04 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:29596 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S932073AbVIDROD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 13:14:03 -0400
X-AuthUser: davidel@xmailserver.org
Date: Sun, 4 Sep 2005 10:13:01 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@localhost.localdomain
To: PeiSen Hou <pshou@realtek.com.tw>, Takashi Iwai <tiwai@suse.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [patch] Bring the Vaio's RA826G HDA (82801) to life ...
Message-ID: <Pine.LNX.4.63.0509041007560.9176@localhost.localdomain>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add the subsystem PCI devid to the list (on top of 2.6.13).


- Davide


Signed-off-by: Davide Libenzi <davidel@xmailserver.org>



diff -Nru linux-2.6.13/sound/pci/hda/patch_realtek.c linux-2.6.13.mod/sound/pci/hda/patch_realtek.c
--- linux-2.6.13/sound/pci/hda/patch_realtek.c	2005-09-03 15:59:25.000000000 -0700
+++ linux-2.6.13.mod/sound/pci/hda/patch_realtek.c	2005-09-03 15:33:14.000000000 -0700
@@ -1519,7 +1519,8 @@

  	/* Back 3 jack, front 2 jack (Internal add Aux-In) */
  	{ .pci_subvendor = 0x1025, .pci_subdevice = 0xe310, .config = ALC880_3ST },
  	{ .pci_subvendor = 0x104d, .pci_subdevice = 0x81d6, .config = ALC880_3ST }, 
+	{ .pci_subvendor = 0x104d, .pci_subdevice = 0x81a0, .config = ALC880_3ST },

  	/* Back 3 jack plus 1 SPDIF out jack, front 2 jack */
  	{ .modelname = "3stack-digout", .config = ALC880_3ST_DIG },
