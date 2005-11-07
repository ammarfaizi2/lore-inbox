Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932417AbVKGDPz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932417AbVKGDPz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 22:15:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbVKGDPz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 22:15:55 -0500
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:63892 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932417AbVKGDPz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 22:15:55 -0500
From: mchehab@brturbo.com.br
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, video4linux-list@redhat.com,
       Michael Krufky <mkrufky@m1k.net>
Subject: [Patch 09/20] V4L(909) Updated cardlist and strip trailing
	whitespace
Date: Mon, 07 Nov 2005 00:58:08 -0200
Message-Id: <1131333341.25215.8.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1-2mdk 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Krufky <mkrufky@m1k.net>

- Updated CARDLIST and strip trailing whitespace.

Signed-off-by: Michael Krufky <mkrufky@m1k.net>
Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>

-----------------

 Documentation/video4linux/CARDLIST.saa7134 |    2 +-
 drivers/media/video/saa7134/saa7134-dvb.c  |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- hg.orig/Documentation/video4linux/CARDLIST.saa7134
+++ hg/Documentation/video4linux/CARDLIST.saa7134
@@ -56,7 +56,7 @@
  55 -> LifeView FlyDVB-T DUO                    [5168:0502,5168:0306]
  56 -> Avermedia AVerTV 307                     [1461:a70a]
  57 -> Avermedia AVerTV GO 007 FM               [1461:f31f]
- 58 -> ADS Tech Instant TV (saa7135)            [1421:0350,1421:0370]
+ 58 -> ADS Tech Instant TV (saa7135)            [1421:0350,1421:0370,1421:1370]
  59 -> Kworld/Tevion V-Stream Xpert TV PVR7134
  60 -> Typhoon DVB-T Duo Digital/Analog Cardbus [4e42:0502]
  61 -> Philips TOUGH DVB-T reference design     [1131:2004]
--- hg.orig/drivers/media/video/saa7134/saa7134-dvb.c
+++ hg/drivers/media/video/saa7134/saa7134-dvb.c
@@ -749,7 +749,7 @@ static void philips_tda827xa_pll_sleep(u
 	struct saa7134_dev *dev = fe->dvb->priv;
 	static u8 tda827xa_sleep[] = { 0x30, 0x90};
 	struct i2c_msg tuner_msg = {.addr = addr,.flags = 0,.buf = tda827xa_sleep,
-		                    .len = sizeof(tda827xa_sleep) };
+			            .len = sizeof(tda827xa_sleep) };
 	i2c_transfer(&dev->i2c_adap, &tuner_msg, 1);
 
 }


	

	
		
_______________________________________________________ 
Yahoo! Acesso Grátis: Internet rápida e grátis. 
Instale o discador agora!
http://br.acesso.yahoo.com/

