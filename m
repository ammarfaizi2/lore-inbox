Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936351AbWK3M3a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936351AbWK3M3a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 07:29:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936336AbWK3M3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 07:29:09 -0500
Received: from ns2.uludag.org.tr ([193.140.100.220]:21154 "EHLO uludag.org.tr")
	by vger.kernel.org with ESMTP id S936355AbWK3MVi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 07:21:38 -0500
From: "=?utf-8?q?S=2E=C3=87a=C4=9Flar?= Onur" <caglar@pardus.org.tr>
Reply-To: caglar@pardus.org.tr
Organization: =?utf-8?q?T=C3=9CB=C4=B0TAK_/?= UEKAE
To: Zachary Amsden <zach@vmware.com>
Subject: Re: Fix for OpenSUSE kernel bug (was Re: [Opps] Invalid opcode)
Date: Thu, 30 Nov 2006 16:21:43 +0200
User-Agent: KMail/1.9.5
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       Gerd Hoffmann <kraxel@suse.de>, Andrew Morton <akpm@osdl.org>,
       Daniel Hecht <dhecht@vmware.com>, Sahil Rihan <srihan@vmware.com>,
       Trampus Richmond <trampus@vmware.com>, betts@vmware.com
References: <200611051507.37196.caglar@pardus.org.tr> <200611051917.56971.caglar@pardus.org.tr> <456E7DE2.5070808@vmware.com>
In-Reply-To: <456E7DE2.5070808@vmware.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart61314288.vR9c29H9zr";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200611301621.51240.caglar@pardus.org.tr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart61314288.vR9c29H9zr
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi;

30 Kas 2006 Per 08:44 tarihinde, Zachary Amsden =C5=9Funlar=C4=B1 yazm=C4=
=B1=C5=9Ft=C4=B1:=20
> I'm proposing this as a fix for your bug. Having tasklets scheduled
> before softirqd gets to run might be somewhat backwards, but there is
> nothing I can find wrong about it from a correctness point of view.
> Better to boot the kernel even when compiled with bug checking on, I thin=
k.
>
> This bug started becoming apparent in 2.6.18 because of some rework with
> the CPU hotplug code, but in theory, it exists at least all the way back
> to 2.6.10, which is as far as I looked backwards in time.

I cannot reproduce that opps with 2.6.18.4 + your patch any longer, so at=20
least works for me :), thanks

Cheers
=2D-=20
S.=C3=87a=C4=9Flar Onur <caglar@pardus.org.tr>
http://cekirdek.pardus.org.tr/~caglar/

Linux is like living in a teepee. No Windows, no Gates and an Apache in hou=
se!

--nextPart61314288.vR9c29H9zr
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.0 (GNU/Linux)

iD8DBQBFbuj/y7E6i0LKo6YRAunSAJ43j9p8TI6GtEibeBwNyPEEs94dRgCg04QM
ZwQNiTYm2ObELK558cB3TAE=
=3Pz7
-----END PGP SIGNATURE-----

--nextPart61314288.vR9c29H9zr--
