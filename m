Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314473AbSDXDLp>; Tue, 23 Apr 2002 23:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314498AbSDXDLo>; Tue, 23 Apr 2002 23:11:44 -0400
Received: from mail.mesatop.com ([208.164.122.9]:6924 "EHLO thor.mesatop.com")
	by vger.kernel.org with ESMTP id <S314473AbSDXDLn>;
	Tue, 23 Apr 2002 23:11:43 -0400
Subject: [PATCH] 2.5.9-dj1, change to CONFIG_DMASOUND_PMAC in
	sound/oss/dmasound/Config.help
From: Steven Cole <elenstev@mesatop.com>
To: Dave Jones <davej@suse.de>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1019617394.29017.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution/1.0.2-5mdk 
Date: 23 Apr 2002 21:09:24 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In sound/oss/dmasound/, in Config.in and the Makefile,
CONFIG_DMASOUND_AWACS has been changed to CONFIG_DMASOUND_PMAC.

This patch completes that change.

Steven

--- linux-2.5.9-dj1/sound/oss/dmasound/Config.help.orig	Tue Apr 23 20:40:06 2002
+++ linux-2.5.9-dj1/sound/oss/dmasound/Config.help	Tue Apr 23 20:47:19 2002
@@ -15,7 +15,7 @@
   want). If you want to compile it as a module, say M here and read
   <file:Documentation/modules.txt>.
 
-CONFIG_DMASOUND_AWACS
+CONFIG_DMASOUND_PMAC
   If you want to use the internal audio of your PowerMac in Linux,
   answer Y to this question. This will provide a Sun-like /dev/audio,
   compatible with the Linux/i386 sound system. Otherwise, say N.



