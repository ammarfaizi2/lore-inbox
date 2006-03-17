Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932193AbWCQU5Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbWCQU5Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 15:57:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932763AbWCQU5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 15:57:11 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:63146 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932193AbWCQU4x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 15:56:53 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Michael Krufky <mkrufky@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 17/21] Kconfig: fix ATSC frontend menu item names by
	manufacturer
Date: Fri, 17 Mar 2006 17:54:37 -0300
Message-id: <20060317205437.PS70957700017@infradead.org>
In-Reply-To: <20060317205359.PS65198900000@infradead.org>
References: <20060317205359.PS65198900000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-3mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Michael Krufky <mkrufky@linuxtv.org>
Date: 1142525905 \-0300

- Corrected typo for NxtWave NXT200X
- Added "Oren" manufacturer name to menu items for OR51132 and OR51211
- Removed "(pcHDTV HDx000 card)" from Oren frontends menu item names,
  This isn't necessary, as these frontends are selected by the card drivers,
  build configuration (DVB_BT8XX and VIDEO_CX88_DVB).

Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/dvb/frontends/Kconfig |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/dvb/frontends/Kconfig b/drivers/media/dvb/frontends/Kconfig
index c676b1e..ff077eb 100644
--- a/drivers/media/dvb/frontends/Kconfig
+++ b/drivers/media/dvb/frontends/Kconfig
@@ -155,7 +155,7 @@ comment "ATSC (North American/Korean Ter
 	depends on DVB_CORE
 
 config DVB_NXT200X
-	tristate "Nextwave NXT2002/NXT2004 based"
+	tristate "NxtWave Communications NXT2002/NXT2004 based"
 	depends on DVB_CORE
 	select FW_LOADER
 	help
@@ -169,14 +169,14 @@ config DVB_NXT200X
 	  or /lib/firmware (depending on configuration of firmware hotplug).
 
 config DVB_OR51211
-	tristate "or51211 based (pcHDTV HD2000 card)"
+	tristate "Oren OR51211 based"
 	depends on DVB_CORE
 	select FW_LOADER
 	help
 	  An ATSC 8VSB tuner module. Say Y when you want to support this frontend.
 
 config DVB_OR51132
-	tristate "OR51132 based (pcHDTV HD3000 card)"
+	tristate "Oren OR51132 based"
 	depends on DVB_CORE
 	select FW_LOADER
 	help

