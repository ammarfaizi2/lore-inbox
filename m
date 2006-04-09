Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750722AbWDIOWe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbWDIOWe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 10:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750723AbWDIOWe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 10:22:34 -0400
Received: from everest.sosdg.org ([66.93.203.161]:2503 "EHLO mail.sosdg.org")
	by vger.kernel.org with ESMTP id S1750722AbWDIOWe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 10:22:34 -0400
Date: Sun, 9 Apr 2006 10:22:32 -0400
From: Coywolf Qi Hunt <coywolf@sosdg.org>
To: tiwai@suse.de
Cc: linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net,
       akpm@osdl.org
Subject: [patch] support HP Compaq Presario B2800 laptop with AD1986A codec
Message-ID: <20060409142232.GA26779@everest.sosdg.org>
Reply-To: qiyong@freeforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: coywolf@mail.sosdg.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This adds the support for HP Compaq Presario B2800 laptop with AD1986A codec.

Signed-off-by: Coywolf Qi Hunt <qiyong@freeforge.net>
---

diff --git a/sound/pci/hda/patch_analog.c b/sound/pci/hda/patch_analog.c
index 2bfe37e..921118f 100644
--- a/sound/pci/hda/patch_analog.c
+++ b/sound/pci/hda/patch_analog.c
@@ -801,6 +801,8 @@ static struct hda_board_config ad1986a_c
 	  .config = AD1986A_LAPTOP_EAPD }, /* Samsung R65-T2300 Charis */
 	{ .pci_subvendor = 0x1043, .pci_subdevice = 0x1213,
 	  .config = AD1986A_LAPTOP_EAPD }, /* ASUS A6J */
+	{ .pci_subvendor = 0x103c, .pci_subdevice = 0x30af,
+	  .config = AD1986A_LAPTOP_EAPD }, /* HP Compaq Presario B2800 */
 	{}
 };
 
