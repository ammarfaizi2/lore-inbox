Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263088AbUJ1Whl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263088AbUJ1Whl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 18:37:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262885AbUJ1Wcn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 18:32:43 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:45583 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261589AbUJ1W3g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 18:29:36 -0400
Date: Fri, 29 Oct 2004 00:29:04 +0200
From: Adrian Bunk <bunk@stusta.de>
To: kraxel@bytesex.org
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] media/video/bw-qcam.c: remove an unused function
Message-ID: <20041028222904.GR3207@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

The patch below removes an unused function from media/video/bw-qcam.c


diffstat output:
 drivers/media/video/bw-qcam.c |    5 -----
 1 files changed, 5 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

- --- linux-2.6.10-rc1-mm1-full/drivers/media/video/bw-qcam.c.old	2004-10-28 23:16:36.000000000 +0200
+++ linux-2.6.10-rc1-mm1-full/drivers/media/video/bw-qcam.c	2004-10-28 23:17:06.000000000 +0200
@@ -91,11 +91,6 @@
 	return parport_read_status(q->pport);
 }
 
- -static inline int read_lpcontrol(struct qcam_device *q)
- -{
- -	return parport_read_control(q->pport);
- -}
- -
 static inline int read_lpdata(struct qcam_device *q)
 {
 	return parport_read_data(q->pport);

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBgXKwmfzqmE8StAARAnbBAJ4nSVGxBfghHU4GT2OAXxkSDnJT2gCgkACJ
t4/AVnBl8LKBN2TTWMkIRXs=
=uM8n
-----END PGP SIGNATURE-----
