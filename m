Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265101AbTFYVe6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 17:34:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265084AbTFYVe6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 17:34:58 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:33540 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S265112AbTFYVb6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 17:31:58 -0400
Date: Wed, 25 Jun 2003 23:41:38 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: torvalds@osdl.org
Cc: rmk@flint.arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.73bk - Typo after 8250_cs update (SERIAL)
Message-ID: <20030625234138.A23761@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

s/GetConfiguration/GetConfigurationInfo/


 drivers/serial/8250_cs.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/serial/8250_cs.c~trivial-typo-8250_cs drivers/serial/8250_cs.c
--- linux-2.5.73-1.1348.16.4-to-1.1448/drivers/serial/8250_cs.c~trivial-typo-8250_cs	Wed Jun 25 23:28:18 2003
+++ linux-2.5.73-1.1348.16.4-to-1.1448-fr/drivers/serial/8250_cs.c	Wed Jun 25 23:28:18 2003
@@ -435,7 +435,7 @@ static int multi_config(dev_link_t * lin
 
 	i = CardServices(GetConfigurationInfo, handle, &config);
 	if (i != CS_SUCCESS) {
-		cs_error(handle, GetConfiguration, i);
+		cs_error(handle, GetConfigurationInfo, i);
 		return -1;
 	}
 	link->conf.Vcc = config.Vcc;

_
