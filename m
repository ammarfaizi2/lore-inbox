Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267531AbSKQRvS>; Sun, 17 Nov 2002 12:51:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267532AbSKQRvS>; Sun, 17 Nov 2002 12:51:18 -0500
Received: from math.ut.ee ([193.40.5.125]:16603 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id <S267531AbSKQRvR>;
	Sun, 17 Nov 2002 12:51:17 -0500
Date: Sun, 17 Nov 2002 19:58:15 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: linux-kernel@vger.kernel.org
Subject: 2.5.47-bk compile errors: smbfs, cifs, nfs4, gameport, bttv
Message-ID: <Pine.GSO.4.44.0211171911580.11738-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just FYI:

fs/smbfs/inode.c: In function `smb_show_options':
fs/smbfs/inode.c:415: dereferencing pointer to incomplete type

fs/cifs/cifsfs.c: In function `cifs_show_options':
fs/cifs/cifsfs.c:202: dereferencing pointer to incomplete type

fs/nfsd/nfs4proc.c: In function `nfsd4_write':
fs/nfsd/nfs4proc.c:484: warning: passing arg 4 of `nfsd_write' from
incompatible pointer type
fs/nfsd/nfs4proc.c:484: warning: passing arg 6 of `nfsd_write' makes
integer from pointer without a cast
fs/nfsd/nfs4proc.c:484: too few arguments to function `nfsd_write'
fs/nfsd/nfs4proc.c: In function `nfsd4_proc_compound':
fs/nfsd/nfs4proc.c:568: structure has no member named `rq_resbuf'
fs/nfsd/nfs4proc.c:569: structure has no member named `rq_resbuf'
fs/nfsd/nfs4proc.c:569: structure has no member named `rq_resbuf'

drivers/input/gameport/ns558.c: In function `ns558_pnp_probe':
drivers/input/gameport/ns558.c:239: structure has no member named `name'
drivers/input/gameport/ns558.c:239: structure has no member named `name'

drivers/media/video/bttv-cards.c: In function `miro_pinnacle_gpio':
drivers/media/video/bttv-cards.c:1742: `AUDC_CONFIG_PINNACLE' undeclared (first use in this function)
drivers/media/video/bttv-cards.c:1742: (Each undeclared identifier is reported only once
drivers/media/video/bttv-cards.c:1742: for each function it appears in.)
drivers/media/video/bttv-cards.c: In function `bttv_check_chipset':
drivers/media/video/bttv-cards.c:2993: structure has no member named `name'

-- 
Meelis Roos (mroos@linux.ee)

