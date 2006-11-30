Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933840AbWK3KHE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933840AbWK3KHE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 05:07:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933874AbWK3KHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 05:07:04 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:27358 "EHLO
	rubicon.netdirect.ca") by vger.kernel.org with ESMTP
	id S933840AbWK3KHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 05:07:03 -0500
X-Originating-Ip: 74.102.209.62
Date: Thu, 30 Nov 2006 05:03:56 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] Kbuild: add 3 more header files to get properly "unifdef"ed
Message-ID: <Pine.LNX.4.64.0611300459290.12927@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Add 3 more files to get "unifdef"ed when creating sanitized headers
with "make headers_install".

Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>

---

diff --git a/include/linux/Kbuild b/include/linux/Kbuild
index a1155a2..b6bc50c 100644
--- a/include/linux/Kbuild
+++ b/include/linux/Kbuild
@@ -225,6 +225,7 @@ unifdef-y += if_bridge.h
 unifdef-y += if_ec.h
 unifdef-y += if_eql.h
 unifdef-y += if_ether.h
+unifdef-y += if_fddi.h
 unifdef-y += if_frad.h
 unifdef-y += if_ltalk.h
 unifdef-y += if_pppox.h
@@ -286,6 +287,7 @@ unifdef-y += nvram.h
 unifdef-y += parport.h
 unifdef-y += patchkey.h
 unifdef-y += pci.h
+unifdef-y += personality.h
 unifdef-y += pktcdvd.h
 unifdef-y += pmu.h
 unifdef-y += poll.h
@@ -341,6 +343,7 @@ unifdef-y += videodev.h
 unifdef-y += wait.h
 unifdef-y += wanrouter.h
 unifdef-y += watchdog.h
+unifdef-y += wireless.h
 unifdef-y += xfrm.h
 unifdef-y += zftape.h

