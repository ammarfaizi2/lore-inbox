Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269762AbUJGJSl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269762AbUJGJSl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 05:18:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269763AbUJGJSl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 05:18:41 -0400
Received: from mout0.freenet.de ([194.97.50.131]:19945 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id S269762AbUJGJSf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 05:18:35 -0400
From: Michael Buesch <mbuesch@freenet.de>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [2.4] 0-order allocation failed
Date: Thu, 7 Oct 2004 13:18:13 +0200
User-Agent: KMail/1.7
MIME-Version: 1.0
Message-Id: <200410071318.21091.mbuesch@freenet.de>
Content-Type: multipart/signed;
  boundary="nextPart3599702.ivUqQrdHHC";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3599702.ivUqQrdHHC
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi all,

I'm running 2.4.28 bk snapshot of 2004.09.03
The machine has an uptime of 7 days, 23:46 now.

I was running several bittorrent clients inside of
a screen session. Suddenly they all died (including the
screen session).
dmesg sayed this:

__alloc_pages: 0-order allocation failed (gfp=3D0x1f0/0)
__alloc_pages: 0-order allocation failed (gfp=3D0x1d2/0)
VM: killing process python
__alloc_pages: 0-order allocation failed (gfp=3D0x1d2/0)
__alloc_pages: 0-order allocation failed (gfp=3D0x1d2/0)
VM: killing process screen

I already got this with kernel 2.4.27 vanilla after a
higher amount of uptime (I think it was over 10 days).
This was exactly the reason I updated to bk snapshot.

What can be the reason for this? Is it OOM? (I can't
really believe it is).
Is it a kernel memory leak?

With 2.4.26 I never got these errors. And I ran uptimes
up to 50 days.

=2D-=20
Regards Michael Buesch  [ http://www.tuxsoft.de.vu ]


--nextPart3599702.ivUqQrdHHC
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD4DBQBBZSX9FGK1OIvVOP4RAq0+AJ44OI2/4mA2O7n2yG5///L19C74GQCVGzdP
KESQbTzgdJgj/rPGXeo/wA==
=5fjC
-----END PGP SIGNATURE-----

--nextPart3599702.ivUqQrdHHC--
