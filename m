Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263342AbTJBNhk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 09:37:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263345AbTJBNhk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 09:37:40 -0400
Received: from rumms.uni-mannheim.de ([134.155.50.52]:6036 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S263342AbTJBNhi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 09:37:38 -0400
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.0-test6-mm2
Date: Thu, 2 Oct 2003 15:37:23 +0200
User-Agent: KMail/1.5.9
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20031002022341.797361bc.akpm@osdl.org>
In-Reply-To: <20031002022341.797361bc.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-03=_UoCf/30fV1VkGwM";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200310021537.24898.schlicht@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-03=_UoCf/30fV1VkGwM
Content-Type: multipart/mixed;
  boundary="Boundary-01=_UoCf/XjLasTr9av"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_UoCf/XjLasTr9av
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 02 October 2003 11:23, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test6/2
>.6.0-test6-mm2/
[...]
> +RD2-ioctl-B6.patch

This one introduces a small typo which the attached patch fixes.

   Thomas

--Boundary-01=_UoCf/XjLasTr9av
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="fix_typo-cdrom_mcd.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
	filename="fix_typo-cdrom_mcd.diff"

=2D-- linux-2.6.0-test6-mm2/drivers/cdrom/mcd.c.orig	Thu Oct  2 15:15:58 20=
03
+++ linux-2.6.0-test6-mm2/drivers/cdrom/mcd.c	Thu Oct  2 15:16:19 2003
@@ -224,7 +224,7 @@
 	return cdrom_release(&mcd_info);
 }
=20
=2Dstatic int mcd_block_ioctl(struct struct block_device *bdev, struct file=
 *file,
+static int mcd_block_ioctl(struct block_device *bdev, struct file *file,
 				unsigned cmd, unsigned long arg)
 {
 	return cdrom_ioctl(&mcd_info, bdev, cmd, arg);

--Boundary-01=_UoCf/XjLasTr9av--

--Boundary-03=_UoCf/30fV1VkGwM
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA/fCoUYAiN+WRIZzQRAmeEAKDtEkzL4RfM6MZWrPdrjlM238++OwCg7kmD
bLfGk5eziZqSBmTaFd9WoFE=
=uBVm
-----END PGP SIGNATURE-----

--Boundary-03=_UoCf/30fV1VkGwM--
