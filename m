Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268146AbUH2A2Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268146AbUH2A2Q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 20:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268145AbUH2A2Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 20:28:16 -0400
Received: from havoc.gtf.org ([216.162.42.101]:39402 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S268146AbUH2A05 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 20:26:57 -0400
Date: Sat, 28 Aug 2004 20:26:53 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCHES] 2.4.x misc updates
Message-ID: <20040829002653.GA14479@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please do a

	bk pull bk://gkernel.bkbits.net/misc-2.4

This will update the following files:

 drivers/sound/ac97_codec.c |    1 +
 1 files changed, 1 insertion(+)

through these ChangeSets:

<ileong@nvidia.com> (04/08/28 1.1549)
   [ac97_codec] add new codec

diff -Nru a/drivers/sound/ac97_codec.c b/drivers/sound/ac97_codec.c
--- a/drivers/sound/ac97_codec.c	2004-08-28 20:26:27 -04:00
+++ b/drivers/sound/ac97_codec.c	2004-08-28 20:26:27 -04:00
@@ -155,6 +155,7 @@
 	{0x43525931, "Cirrus Logic CS4299 rev A", &crystal_digital_ops},
 	{0x43525933, "Cirrus Logic CS4299 rev C", &crystal_digital_ops},
 	{0x43525934, "Cirrus Logic CS4299 rev D", &crystal_digital_ops},
+	{0x43585430, "CXT48",			&default_ops,		AC97_DELUDED_MODEM },
 	{0x43585442, "CXT66",			&default_ops,		AC97_DELUDED_MODEM },
 	{0x44543031, "Diamond Technology DT0893", &default_ops},
 	{0x45838308, "ESS Allegro ES1988",	&null_ops},
