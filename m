Return-Path: <linux-kernel-owner+w=401wt.eu-S1751429AbXAUTNm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751429AbXAUTNm (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 14:13:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751409AbXAUTNW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 14:13:22 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:4207 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751402AbXAUTNN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 14:13:13 -0500
Date: Sun, 21 Jan 2007 20:13:19 +0100
From: Adrian Bunk <bunk@stusta.de>
To: "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] process include/linux/if_{addr,link}.h with unifdef
Message-ID: <20070121191319.GO9093@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After commit d3dcc077bf88806201093f86325ec656e4dbfbce, 
include/linux/if_{addr,link}.h should be processed with unifdef.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 include/linux/Kbuild |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.20-rc4-mm1/include/linux/Kbuild.old	2007-01-20 20:14:02.000000000 +0100
+++ linux-2.6.20-rc4-mm1/include/linux/Kbuild	2007-01-20 20:15:12.000000000 +0100
@@ -70,7 +70,6 @@
 header-y += i2c-dev.h
 header-y += i8k.h
 header-y += icmp.h
-header-y += if_addr.h
 header-y += if_arcnet.h
 header-y += if_arp.h
 header-y += if_bonding.h
@@ -80,7 +79,6 @@
 header-y += if.h
 header-y += if_hippi.h
 header-y += if_infiniband.h
-header-y += if_link.h
 header-y += if_packet.h
 header-y += if_plip.h
 header-y += if_ppp.h
@@ -214,6 +212,7 @@
 unifdef-y += i2c.h
 unifdef-y += i2o-dev.h
 unifdef-y += icmpv6.h
+unifdef-y += if_addr.h
 unifdef-y += if_bridge.h
 unifdef-y += if_ec.h
 unifdef-y += if_eql.h
@@ -221,6 +220,7 @@
 unifdef-y += if_fddi.h
 unifdef-y += if_frad.h
 unifdef-y += if_ltalk.h
+unifdef-y += if_link.h
 unifdef-y += if_pppox.h
 unifdef-y += if_shaper.h
 unifdef-y += if_tr.h

