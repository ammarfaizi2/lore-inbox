Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262208AbTANMNX>; Tue, 14 Jan 2003 07:13:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262425AbTANMNX>; Tue, 14 Jan 2003 07:13:23 -0500
Received: from mail6.bluewin.ch ([195.186.4.229]:5860 "EHLO mail6.bluewin.ch")
	by vger.kernel.org with ESMTP id <S262208AbTANMNW>;
	Tue, 14 Jan 2003 07:13:22 -0500
Date: Tue, 14 Jan 2003 13:21:14 +0100
From: Roger Luethi <rl@hellgate.ch>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       trivial@rustcorp.com.au
Subject: [PATCH][2.5] export skb_pad symbol
Message-ID: <20030114122114.GA30656@k3.hellgate.ch>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	trivial@rustcorp.com.au
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux 2.5.57 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Actually exporting the symbol introduced in 2.5.57 makes module users
happy. Please apply.

--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="export_skpad.diff"

--- linux-2.5.58/net/netsyms.c.org	Tue Jan 14 13:11:29 2003
+++ linux-2.5.58/net/netsyms.c	Tue Jan 14 13:11:35 2003
@@ -534,6 +534,7 @@
 EXPORT_SYMBOL(__kfree_skb);
 EXPORT_SYMBOL(skb_clone);
 EXPORT_SYMBOL(skb_copy);
+EXPORT_SYMBOL(skb_pad);
 EXPORT_SYMBOL(netif_rx);
 EXPORT_SYMBOL(netif_receive_skb);
 EXPORT_SYMBOL(dev_add_pack);

--jRHKVT23PllUwdXP--
