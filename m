Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750992AbWDEAEI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750992AbWDEAEI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 20:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750981AbWDEACF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 20:02:05 -0400
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:55490
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1750983AbWDEAB6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 20:01:58 -0400
Date: Tue, 4 Apr 2006 17:01:14 -0700
From: gregkh@suse.de
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Takashi Iwai <tiwai@suse.de>, Adrian Bunk <bunk@stusta.de>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 23/26] Add default entry for CTL Travel Master U553W
Message-ID: <20060405000114.GX27049@kroah.com>
References: <20060404235634.696852000@quad.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="add-default-entry-for-ctl-travel-master.patch"
In-Reply-To: <20060404235927.GA27049@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

Added the default entry of ALC880 configuration table for
CTL Travel Master U553W.

This patch was already included in Linus' tree.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 sound/pci/hda/patch_realtek.c |    2 ++
 1 file changed, 2 insertions(+)

--- linux-2.6.16.1.orig/sound/pci/hda/patch_realtek.c
+++ linux-2.6.16.1/sound/pci/hda/patch_realtek.c
@@ -2948,6 +2948,8 @@ static struct hda_board_config alc260_cf
 	{ .modelname = "basic", .config = ALC260_BASIC },
 	{ .pci_subvendor = 0x104d, .pci_subdevice = 0x81bb,
 	  .config = ALC260_BASIC }, /* Sony VAIO */
+	{ .pci_subvendor = 0x152d, .pci_subdevice = 0x0729,
+	  .config = ALC260_BASIC }, /* CTL Travel Master U553W */
 	{ .modelname = "hp", .config = ALC260_HP },
 	{ .pci_subvendor = 0x103c, .pci_subdevice = 0x3010, .config = ALC260_HP },
 	{ .pci_subvendor = 0x103c, .pci_subdevice = 0x3011, .config = ALC260_HP },

--
