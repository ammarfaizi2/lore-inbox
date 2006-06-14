Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964991AbWFNPPl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964991AbWFNPPl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 11:15:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964996AbWFNPPk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 11:15:40 -0400
Received: from mail.gmx.de ([213.165.64.21]:5340 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964991AbWFNPPk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 11:15:40 -0400
X-Authenticated: #20022210
Message-ID: <4490281B.5060801@gmx.net>
Date: Wed, 14 Jun 2006 17:15:39 +0200
From: Marc Sowen <marc.sowen@gmx.net>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] com20020_cs, kernel 2.6.17-rc6, 3rd try
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everybody,

this patch enables the com20020_cs arcnet driver to see the SoHard (now Mercury Computer Systems Inc.) SH ARC-PCMCIA card. Added signed off line.

Regards,
  Marc

Signed-off-by: Marc Sowen <marc.sowen@ibeo-as.de>

--- a/linux-2.6.17-rc6/drivers/net/pcmcia/com20020_cs.c 2006-06-06 02:57:02.000000000 +0200
+++ b/linux-2.6.17-rc6/drivers/net/pcmcia/com20020_cs.c 2006-06-13 17:10:03.000000000 +0200
@@ -388,6 +388,7 @@

  static struct pcmcia_device_id com20020_ids[] = {
         PCMCIA_DEVICE_PROD_ID12("Contemporary Control Systems, Inc.", "PCM20 Arcnet Adapter", 0x59991666, 0x95dfffaf),
+       PCMCIA_DEVICE_PROD_ID12("SoHard AG", "SH ARC PCMCIA", 0xf8991729, 0x69dff0c7),
         PCMCIA_DEVICE_NULL
  };
  MODULE_DEVICE_TABLE(pcmcia, com20020_ids);


