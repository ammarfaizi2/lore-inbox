Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750986AbVILQ2Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750986AbVILQ2Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 12:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751030AbVILQ2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 12:28:25 -0400
Received: from ns1.suse.de ([195.135.220.2]:20165 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750985AbVILQ2Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 12:28:25 -0400
Date: Mon, 12 Sep 2005 18:28:22 +0200
From: Karsten Keil <kkeil@suse.de>
To: akpm@osdl.org, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Sedlbauer speed star II V 3.1 exist with various subversions
Message-ID: <20050912162822.GA20594@pingi3.kke.suse.de>
Mail-Followup-To: akpm@osdl.org, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this is my first try to submit a patch via the public isdn-2.6 git tree, hopefully I
got it correct.

You can fetch the patch from
rsync:/rsync.kernel.org/pub/scm/linux/kernel/git/kkeil/isdn-2.6.git

Sedlbauer speed star II V 3.1 exist with various subversions

- the 4th id field should be not used 

Signed-off-by: Karsten Keil <kkeil@suse.de>

---

 drivers/isdn/hisax/sedlbauer_cs.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

953abba4c70dcf5ec73a0eb610860dacb738540b
diff --git a/drivers/isdn/hisax/sedlbauer_cs.c b/drivers/isdn/hisax/sedlbauer_cs.c
--- a/drivers/isdn/hisax/sedlbauer_cs.c
+++ b/drivers/isdn/hisax/sedlbauer_cs.c
@@ -611,7 +611,7 @@ static int sedlbauer_event(event_t event
 } /* sedlbauer_event */
 
 static struct pcmcia_device_id sedlbauer_ids[] = {
-	PCMCIA_DEVICE_PROD_ID1234("SEDLBAUER", "speed star II", "V 3.1", "(c) 93 - 98 cb ", 0x81fb79f5, 0xf3612e1d, 0x6b95c78a, 0x50d4149c),
+	PCMCIA_DEVICE_PROD_ID123("SEDLBAUER", "speed star II", "V 3.1", 0x81fb79f5, 0xf3612e1d, 0x6b95c78a),
 	PCMCIA_DEVICE_PROD_ID123("SEDLBAUER", "ISDN-Adapter", "4D67", 0x81fb79f5, 0xe4e9bc12, 0x397b7e90),
 	PCMCIA_DEVICE_PROD_ID123("SEDLBAUER", "ISDN-Adapter", "4D98", 0x81fb79f5, 0xe4e9bc12, 0x2e5c7fce),
 	PCMCIA_DEVICE_PROD_ID123("SEDLBAUER", "ISDN-Adapter", " (C) 93-94 VK", 0x81fb79f5, 0xe4e9bc12, 0x8db143fe),


-- 
Karsten Keil
SuSE Labs
ISDN development
