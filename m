Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290423AbSBYRxR>; Mon, 25 Feb 2002 12:53:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292036AbSBYRxH>; Mon, 25 Feb 2002 12:53:07 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:484 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S292027AbSBYRw7>; Mon, 25 Feb 2002 12:52:59 -0500
Date: Mon, 25 Feb 2002 12:52:38 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org, ddcarpen1@cs.bemidjistate.edu
Subject: Patch for YMFPCI Configure.help
Message-ID: <20020225125238.A15611@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Configure.help entry was completely bogus. Sorry.
Please give credit to Dan D. Carpenter in the changelog.

-- Pete

--- linux-2.4.18-rc2/Documentation/Configure.help	Tue Feb 19 16:12:05 2002
+++ linux-2.4.18-rc2-p3/Documentation/Configure.help	Mon Feb 25 09:49:03 2002
@@ -18943,8 +18943,11 @@
 
 Yamaha YMF7xx PCI audio (native mode)
 CONFIG_SOUND_YMFPCI
-  Support for Yamaha cards including the YMF711, YMF715, YMF718,
-  YMF719, YMF724, Waveforce 192XG, and Waveforce 192 Digital.
+  Support for Yamaha cards with the following chipsets: YMF724,
+  YMF724F, YMF740, YMF740C, YMF744, and YMF754.
+
+  Two common cards that use this type of chip are Waveforce 192XG,
+  and Waveforce 192 Digital.
 
 Yamaha PCI legacy ports support
 CONFIG_SOUND_YMFPCI_LEGACY
