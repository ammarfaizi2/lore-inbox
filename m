Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932268AbWAPJX6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932268AbWAPJX6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 04:23:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932283AbWAPJXb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 04:23:31 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:44523 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932279AbWAPJX2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 04:23:28 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com,
       akpm@osdl.org, Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 12/25] git dvb callbacks fix
Date: Mon, 16 Jan 2006 07:11:22 -0200
Message-id: <20060116091122.PS15581000012@infradead.org>
In-Reply-To: <20060116091105.PS83611600000@infradead.org>
References: <20060116091105.PS83611600000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-1mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Andrew Morton <akpm@osdl.org>

- Not sure what went wrong here, but SND_PCI_PM_CALLBACKS got deleted.

Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/cx88/cx88-alsa.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/media/video/cx88/cx88-alsa.c b/drivers/media/video/cx88/cx88-alsa.c
index fd8bc71..e649f67 100644
--- a/drivers/media/video/cx88/cx88-alsa.c
+++ b/drivers/media/video/cx88/cx88-alsa.c
@@ -805,7 +805,6 @@ static struct pci_driver cx88_audio_pci_
 	.id_table = cx88_audio_pci_tbl,
 	.probe    = cx88_audio_initdev,
 	.remove   = cx88_audio_finidev,
-	SND_PCI_PM_CALLBACKS
 };
 
 /****************************************************************************

