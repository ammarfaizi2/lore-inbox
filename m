Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263069AbUJ1Wbo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263069AbUJ1Wbo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 18:31:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263082AbUJ1W2T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 18:28:19 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:6415 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263124AbUJ1WTK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 18:19:10 -0400
Date: Fri, 29 Oct 2004 00:18:35 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] floppy.c: remove an unused function
Message-ID: <20041028221835.GN3207@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

The patch below removes an unused function from drivers/block/floppy.c


diffstat output:
 drivers/block/floppy.c |    5 -----
 1 files changed, 5 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

- --- linux-2.6.10-rc1-mm1-full/drivers/block/floppy.c.old	2004-10-28 22:52:49.000000000 +0200
+++ linux-2.6.10-rc1-mm1-full/drivers/block/floppy.c	2004-10-28 22:53:05.000000000 +0200
@@ -3325,11 +3325,6 @@
 	return 0;
 }
 
- -static inline void clear_write_error(int drive)
- -{
- -	CLEARSTRUCT(UDRWE);
- -}
- -
 static inline int set_geometry(unsigned int cmd, struct floppy_struct *g,
 			       int drive, int type, struct block_device *bdev)
 {

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBgXA7mfzqmE8StAARAgBkAKCgbAI7DFkUyF3VMiMz3RQ9vK8jWwCePwXi
dwjHupZq+g+ynYaVZzhEYxk=
=ne+x
-----END PGP SIGNATURE-----
