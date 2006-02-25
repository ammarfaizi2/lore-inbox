Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161103AbWBYUwe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161103AbWBYUwe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 15:52:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161108AbWBYUwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 15:52:34 -0500
Received: from nproxy.gmail.com ([64.233.182.206]:49353 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161103AbWBYUwe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 15:52:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=CTS6tHcUmV21Ykdg+ysnifVCOYO1Yf/uWAH0Q4g7W5iiWOVV+XK/OtDPQNoTQOhfY9G5XHflIwiRo6HFca1lNFAsvp89JkKbYm2HX6Y9N23Dn5SoQTpMJ2EdNJ1qxxT43ymqxllZRWeoLh4vxyKeHn2Zxkj8XFxXhJcTdswtYMs=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH] small update of allnoconfig description
Date: Sat, 25 Feb 2006 21:52:50 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602252152.50354.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


'allnoconfig' is described by 'make help' as a "minimal config", that's not
strictly correct. To be pedantic, a minimal config would be one where 
EMBEDDED was set to Y and most things therein disabled etc. Simply 
answering 'no' to all options does not give a minimal config.
A better description of allnoconfig is that it answers all options with 'no'.

This patch updates the description.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 scripts/kconfig/Makefile |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.16-rc4-mm2-orig/scripts/kconfig/Makefile	2006-02-18 02:09:11.000000000 +0100
+++ linux-2.6.16-rc4-mm2-work/scripts/kconfig/Makefile	2006-02-25 21:46:15.000000000 +0100
@@ -78,7 +78,7 @@ help:
 	@echo  '  defconfig	  - New config with default answer to all options'
 	@echo  '  allmodconfig	  - New config selecting modules when possible'
 	@echo  '  allyesconfig	  - New config where all options are accepted with yes'
-	@echo  '  allnoconfig	  - New minimal config'
+	@echo  '  allnoconfig	  - New config where all options are answered with no'
 
 # ===========================================================================
 # Shared Makefile for the various kconfig executables:


