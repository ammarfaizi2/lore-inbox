Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263175AbUJ2Cnb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263175AbUJ2Cnb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 22:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262893AbUJ1XNQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 19:13:16 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:6930 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262890AbUJ1XIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 19:08:54 -0400
Date: Fri, 29 Oct 2004 01:08:22 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: jgarzik@pobox.com, linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] net/wan/n2.c: remove an unused function
Message-ID: <20041028230822.GZ3207@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

The patch below removes an unused function from drivers/net/wan/n2.c


diffstat output:
 drivers/net/wan/n2.c |    5 -----
 1 files changed, 5 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

- --- linux-2.6.10-rc1-mm1-full/drivers/net/wan/n2.c.old	2004-10-28 23:20:08.000000000 +0200
+++ linux-2.6.10-rc1-mm1-full/drivers/net/wan/n2.c	2004-10-28 23:20:30.000000000 +0200
@@ -159,11 +159,6 @@
 }
 
 
- -static __inline__ void close_windows(card_t *card)
- -{
- -	outb(inb(card->io + N2_PCR) & ~PCR_ENWIN, card->io + N2_PCR);
- -}
- -
 
 #include "hd6457x.c"
 

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD4DBQFBgXvmmfzqmE8StAARAsS9AJdRPRqqWJy4EK11Q64LECq6wCFxAJ48ir7L
Z19hK1ZCVfdLPDo4FAWqsA==
=/cPs
-----END PGP SIGNATURE-----
