Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263060AbTKJSMy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 13:12:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263972AbTKJSMy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 13:12:54 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:60116 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263060AbTKJSMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 13:12:53 -0500
Date: Mon, 10 Nov 2003 19:12:46 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>, cltien@cmedia.com.tw,
       support@cmedia.com.tw
Cc: linux-kernel@vger.kernel.org
Subject: [2.4 patch] fix SOUND_CMPCI Configure.help entry
Message-ID: <20031110181246.GP22185@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the issue below is only a minor documentation fix, but it has confused 
me when configuring a kernel for such a card.

The Config.in already contains the correct number.

Please apply
Adrian

--- linux-2.4.23-pre9-full/Documentation/Configure.help.old	2003-11-10 19:06:29.000000000 +0100
+++ linux-2.4.23-pre9-full/Documentation/Configure.help	2003-11-10 19:07:29.000000000 +0100
@@ -21391,10 +21391,10 @@
   DSP 16 card. Enter: 0 for Sony, 1 for Panasonic, 2 for IDE, 4 for no
   CD-ROM present.
 
-C-Media PCI (CMI8338/8378)
+C-Media PCI (CMI8338/8738)
 CONFIG_SOUND_CMPCI
   Say Y or M if you have a PCI sound card using the CMI8338
-  or the CMI8378 chipset.  Data on these chips are available at
+  or the CMI8738 chipset.  Data on these chips are available at
   <http://www.cmedia.com.tw/>.
 
   A userspace utility to control some internal registers of these
