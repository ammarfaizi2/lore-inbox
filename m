Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932589AbVIEV31@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932589AbVIEV31 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 17:29:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932590AbVIEV3Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 17:29:16 -0400
Received: from smtp1.brturbo.com.br ([200.199.201.163]:55516 "EHLO
	smtp1.brturbo.com.br") by vger.kernel.org with ESMTP
	id S932591AbVIEV3J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 17:29:09 -0400
Date: Mon, 05 Sep 2005 18:26:16 -0300
From: mchehab@brturbo.com.br
To: linux-kernel@vger.kernel.org
Cc: video4linux-list@redhat.com, akpm@osdl.org
Subject: [PATCH 21/24] V4L: added some missing parameter descriptions at
 msp3400.c
Message-ID: <431cb7f8.d4gBcgPvRB+0ux4F%mchehab@brturbo.com.br>
User-Agent: nail 11.25 7/29/05
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="=_431cb7f8.vsZ6uA6s8LuT+0PYuiiiqVuNQ+dFawBW6RQ9NY54BlQVOaRg"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--=_431cb7f8.vsZ6uA6s8LuT+0PYuiiiqVuNQ+dFawBW6RQ9NY54BlQVOaRg
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

.

--=_431cb7f8.vsZ6uA6s8LuT+0PYuiiiqVuNQ+dFawBW6RQ9NY54BlQVOaRg
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="v4l-21-patch.diff"

- added some missing parameter descriptions at msp3400.c

Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>

 linux/drivers/media/video/msp3400.c |    4 ++++
 1 files changed, 4 insertions(+)

diff -u /tmp/dst.1110 linux/drivers/media/video/msp3400.c
--- /tmp/dst.1110	2005-09-05 11:43:15.000000000 -0300
+++ linux/drivers/media/video/msp3400.c	2005-09-05 11:43:15.000000000 -0300
@@ -124,10 +124,14 @@
 module_param(amsound,          int, 0644);
 module_param(dolby,            int, 0644);
 
+MODULE_PARM_DESC(opmode, "Forces a MSP3400 opmode. 0=Manual, 1=Simple, 2=Simpler");
 MODULE_PARM_DESC(once, "No continuous stereo monitoring");
 MODULE_PARM_DESC(debug, "Enable debug messages");
+MODULE_PARM_DESC(stereo_threshold, "Sets signal threshold to activate stereo");
 MODULE_PARM_DESC(standard, "Specify audio standard: 32 = NTSC, 64 = radio, Default: Autodetect");
 MODULE_PARM_DESC(amsound, "Hardwire AM sound at 6.5Hz (France), FM can autoscan");
+MODULE_PARM_DESC(dolby, "Activates Dolby processsing");
+
 
 MODULE_DESCRIPTION("device driver for msp34xx TV sound processor");
 MODULE_AUTHOR("Gerd Knorr");

--=_431cb7f8.vsZ6uA6s8LuT+0PYuiiiqVuNQ+dFawBW6RQ9NY54BlQVOaRg--
