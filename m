Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262089AbTABPTp>; Thu, 2 Jan 2003 10:19:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262190AbTABPTp>; Thu, 2 Jan 2003 10:19:45 -0500
Received: from nammta01.sugar-land.nam.slb.com ([163.188.150.130]:63897 "EHLO
	mail.slb.com") by vger.kernel.org with ESMTP id <S262089AbTABPTn>;
	Thu, 2 Jan 2003 10:19:43 -0500
Date: Thu, 02 Jan 2003 15:21:23 +0000
From: Loic Jaquemet <jaquemet@fiifo.u-psud.fr>
Subject: PATCH : 2.5.5x - tv card with i2c ( bttv )
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-id: <3E1458F3.13EB4BFD@fiifo.u-psud.fr>
Organization: WesternGeco
MIME-version: 1.0
X-Mailer: Mozilla 4.79 [en] (X11; U; SunOS 5.6 sun4u)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


this is needed since 2.5.49 to get a bttv module.

--- linux-2.5.54-old/drivers/media/video/audiochip.h    2002-11-22
22:40:23.000000000 +0100
+++ linux-2.5.54/drivers/media/video/audiochip.h        2002-11-23
10:24:19.000000000 +0100
@@ -67,4 +67,7 @@
 #define AUDC_SWITCH_MUTE      _IO('m',16)      /* turn on mute */
 #endif
 
+/* misc stuff to pass around config info to i2c chips */
+#define AUDC_CONFIG_PINNACLE  _IOW('m',32,int)
+
 #endif /* AUDIOCHIP_H */



-- 
+----------------------------------------------+
|Jaquemet Loic                                 |
|Intern in WesternGeco, Schlumberger in Gatwick|
|Phone: 44-(0)1293-55-6876                     |
|Eleve ingenieur en informatique FIIFO, ORSAY  |
+----------------------------------------------+
http://sourceforge.net/projects/ffss/
#wirelessfr @ irc.freenode.net
