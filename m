Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263070AbUJ1XeZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263070AbUJ1XeZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 19:34:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263089AbUJ1Xdn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 19:33:43 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:13331 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263070AbUJ1XaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 19:30:06 -0400
Date: Fri, 29 Oct 2004 01:29:31 +0200
From: Adrian Bunk <bunk@stusta.de>
To: stern@rowland.harvard.edu
Cc: greg@kroah.com, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] USB uhci-debug.c: remove an unused function
Message-ID: <20041028232931.GN3207@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

The patch below removes an unused function from 
drivers/usb/host/uhci-debug.c


diffstat output:
 drivers/usb/host/uhci-debug.c |   11 -----------
 1 files changed, 11 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

- --- linux-2.6.10-rc1-mm1-full/drivers/usb/host/uhci-debug.c.old	2004-10-28 23:30:40.000000000 +0200
+++ linux-2.6.10-rc1-mm1-full/drivers/usb/host/uhci-debug.c	2004-10-28 23:30:49.000000000 +0200
@@ -34,17 +34,6 @@
 	}
 }
 
- -static inline int uhci_is_skeleton_qh(struct uhci_hcd *uhci, struct uhci_qh *qh)
- -{
- -	int i;
- -
- -	for (i = 0; i < UHCI_NUM_SKELQH; i++)
- -		if (qh == uhci->skelqh[i])
- -			return 1;
- -
- -	return 0;
- -}
- -
 static int uhci_show_td(struct uhci_td *td, char *buf, int len, int space)
 {
 	char *out = buf;

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBgYDbmfzqmE8StAARAnzfAKCMPOvCmI3QbtizyhG0Svs1By3b1gCdEA6k
JI7PpvJ1zGTpdBCkEVMe3+M=
=tfCS
-----END PGP SIGNATURE-----
