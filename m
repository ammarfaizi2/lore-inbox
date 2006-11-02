Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751900AbWKBINk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751900AbWKBINk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 03:13:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751935AbWKBINk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 03:13:40 -0500
Received: from ns2.uludag.org.tr ([193.140.100.220]:17536 "EHLO uludag.org.tr")
	by vger.kernel.org with ESMTP id S1751900AbWKBINk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 03:13:40 -0500
From: "=?utf-8?q?S=2E=C3=87a=C4=9Flar?= Onur" <caglar@pardus.org.tr>
Reply-To: caglar@pardus.org.tr
Organization: =?utf-8?q?T=C3=9CB=C4=B0TAK_/?= UEKAE
To: Zachary Amsden <zach@vmware.com>
Subject: Re: 2.6.18 is problematic in VMware
Date: Thu, 2 Nov 2006 10:13:33 +0200
User-Agent: KMail/1.9.5
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.61.0610290953010.4585@yvahk01.tjqt.qr> <45463B7D.8050002@vmware.com>
In-Reply-To: <45463B7D.8050002@vmware.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart6923151.mItLXyFWVr";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200611021013.38701.caglar@pardus.org.tr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart6923151.mItLXyFWVr
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

30 Eki 2006 Pts 19:50 tarihinde, Zachary Amsden =C5=9Funlar=C4=B1 yazm=C4=
=B1=C5=9Ft=C4=B1:=20
> > * Checking if this processor honours the WP bit even in supervisor
> > mode... Ok. * Checking 'hlt' instruction... OK.
> >
> > What's with that?
>
> Thanks.  It is perhaps the jiffies calibration taking a while because of
> the precise timing loop.  Are you reasonably confident that it is a
> regression in performance over 2.6.17?  The boot sequence is pretty
> complicated, and a lot of it is difficult / slow to virtualize, so it
> could just be alternate timing makes the boot output appear to stall,
> when in fact the raw time is still about the same.  I will run some
> experiments.

This is the part of the same problem with my previous report ( [RFC] Avoid =
PIT=20
SMP lockups thread), and im sure none the previous kernels have that proble=
m.

=2D-=20
S.=C3=87a=C4=9Flar Onur <caglar@pardus.org.tr>
http://cekirdek.pardus.org.tr/~caglar/

Linux is like living in a teepee. No Windows, no Gates and an Apache in hou=
se!

--nextPart6923151.mItLXyFWVr
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFSaiyy7E6i0LKo6YRAmelAJ9395qcGIqkZeHhxvW81teS1EsEeQCgoUVw
YcJ+GXGBLtBPJsOtjT+PouQ=
=y4y4
-----END PGP SIGNATURE-----

--nextPart6923151.mItLXyFWVr--
