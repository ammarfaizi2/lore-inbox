Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263073AbUJ1Wc1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263073AbUJ1Wc1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 18:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262885AbUJ1WcI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 18:32:08 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:48911 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262950AbUJ1Wav (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 18:30:51 -0400
Date: Fri, 29 Oct 2004 00:30:19 +0200
From: Adrian Bunk <bunk@stusta.de>
To: kraxel@bytesex.org
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] media/video/ir-kbd-i2c.c: remove an unused function
Message-ID: <20041028223019.GS3207@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

The patch below removes an unused function from 
drivers/media/video/ir-kbd-i2c.c


diffstat output:
 drivers/media/video/ir-kbd-i2c.c |   10 ----------
 1 files changed, 10 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

- --- linux-2.6.10-rc1-mm1-full/drivers/media/video/ir-kbd-i2c.c.old	2004-10-28 23:05:55.000000000 +0200
+++ linux-2.6.10-rc1-mm1-full/drivers/media/video/ir-kbd-i2c.c	2004-10-28 23:06:06.000000000 +0200
@@ -155,16 +155,6 @@
 
 /* ----------------------------------------------------------------------- */
 
- -static inline int reverse(int data, int bits)
- -{
- -	int i,c;
- -
- -	for (c=0,i=0; i<bits; i++) {
- -		c |= (((data & (1<<i)) ? 1:0)) << (bits-1-i);
- -	}
- -	return c;
- -}
- -
 static int get_key_haup(struct IR *ir, u32 *ir_key, u32 *ir_raw)
 {
 	unsigned char buf[3];

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBgXL7mfzqmE8StAARArBcAKCb/U0OoUJyBuf/mv8bf4HrYnMkxQCfVesi
XVAdDS0V0qASRwJjc0DQ3nk=
=lohc
-----END PGP SIGNATURE-----
