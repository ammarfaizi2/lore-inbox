Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263142AbUJ1WXn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263142AbUJ1WXn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 18:23:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263159AbUJ1WXm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 18:23:42 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:24079 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263142AbUJ1WXN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 18:23:13 -0400
Date: Fri, 29 Oct 2004 00:22:38 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Dag Brattli <dagb@cs.uit.no>, Jean Tourrilhes <jt@hpl.hp.com>
Cc: irda-users@lists.sourceforge.net, davem@davemloft.net, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] irda/qos.c: remove an unused function
Message-ID: <20041028222238.GP3207@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

The patch below removes an unused function from net/irda/qos.c


diffstat output:
 net/irda/qos.c |   11 -----------
 1 files changed, 11 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

- --- linux-2.6.10-rc1-mm1-full/net/irda/qos.c.old	2004-10-28 23:51:59.000000000 +0200
+++ linux-2.6.10-rc1-mm1-full/net/irda/qos.c	2004-10-28 23:52:08.000000000 +0200
@@ -211,17 +211,6 @@
 	return index;
 }
 
- -static inline __u32 byte_value(__u8 byte, __u32 *array) 
- -{
- -	int index;
- -
- -	ASSERT(array != NULL, return -1;);
- -
- -	index = msb_index(byte);
- -
- -	return index_value(index, array);
- -}
- -
 /*
  * Function value_lower_bits (value, array)
  *
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBgXEumfzqmE8StAARAjtAAJwJtfTHsEupGVZWHqUG1L8ddNXQfACglX+r
SKDqqr8fPgPtMjBBkhIwkx8=
=zwcY
-----END PGP SIGNATURE-----
