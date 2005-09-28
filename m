Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751015AbVI1V47@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751015AbVI1V47 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 17:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751064AbVI1Vym
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 17:54:42 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:41989 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1751053AbVI1VyT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 17:54:19 -0400
Date: Wed, 28 Sep 2005 17:50:53 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc: perex@suse.cz, tiwai@suse.de
Subject: [patch 2.6.14-rc2 2/3] alsa: fix alc880_test_mixer typo
Message-ID: <09282005175053.11001@bilbo.tuxdriver.com>
In-Reply-To: <09282005175052.10938@bilbo.tuxdriver.com>
User-Agent: PatchPost/0.1
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a typo (cut & paste) in the alc880_test_mixer structure.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---

 sound/pci/hda/patch_realtek.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -1385,8 +1385,8 @@ static snd_kcontrol_new_t alc880_test_mi
 	HDA_CODEC_VOLUME("Side Playback Volume", 0x0f, 0x0, HDA_OUTPUT),
 	ALC_BIND_MUTE("Front Playback Switch", 0x0c, 2, HDA_INPUT),
 	ALC_BIND_MUTE("Surround Playback Switch", 0x0d, 2, HDA_INPUT),
-	ALC_BIND_MUTE("CLFE Playback Volume", 0x0e, 2, HDA_INPUT),
-	ALC_BIND_MUTE("Side Playback Volume", 0x0f, 2, HDA_INPUT),
+	ALC_BIND_MUTE("CLFE Playback Switch", 0x0e, 2, HDA_INPUT),
+	ALC_BIND_MUTE("Side Playback Switch", 0x0f, 2, HDA_INPUT),
 	PIN_CTL_TEST("Front Pin Mode", 0x14),
 	PIN_CTL_TEST("Surround Pin Mode", 0x15),
 	PIN_CTL_TEST("CLFE Pin Mode", 0x16),
