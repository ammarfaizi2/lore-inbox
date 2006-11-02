Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752222AbWKBIVS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752222AbWKBIVS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 03:21:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752211AbWKBIVS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 03:21:18 -0500
Received: from ns2.uludag.org.tr ([193.140.100.220]:41382 "EHLO uludag.org.tr")
	by vger.kernel.org with ESMTP id S1751886AbWKBIVR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 03:21:17 -0500
From: "=?utf-8?q?S=2E=C3=87a=C4=9Flar?= Onur" <caglar@pardus.org.tr>
Reply-To: caglar@pardus.org.tr
Organization: =?utf-8?q?T=C3=9CB=C4=B0TAK_/?= UEKAE
To: Mark Lord <lkml@rtr.ca>
Subject: Re: 2.6.18 is problematic in VMware
Date: Thu, 2 Nov 2006 10:21:11 +0200
User-Agent: KMail/1.9.5
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, Zachary Amsden <zach@vmware.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       venkatesh.pallipadi@intel.com
References: <Pine.LNX.4.61.0610290953010.4585@yvahk01.tjqt.qr> <Pine.LNX.4.61.0610310857280.23540@yvahk01.tjqt.qr> <4547584F.6000702@rtr.ca>
In-Reply-To: <4547584F.6000702@rtr.ca>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2477084.5AFRIuNAYv";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200611021021.12001.caglar@pardus.org.tr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2477084.5AFRIuNAYv
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

31 Eki 2006 Sal 16:06 tarihinde, Mark Lord =C5=9Funlar=C4=B1 yazm=C4=B1=C5=
=9Ft=C4=B1:=20
> My experience with VMware on several recent processors (mostly P-M family)
> is that it crawls unless I force this first:
>       echo 1 > /sys/module/processor/parameters/max_cstate
>
> So I use a wrapper script around VMware (workstation) to save max_cstate,
> set it to 1, and restore it again on exit.

Hmm, this seems related to that one[1], without setting max_cstate my=20
processors has some issues :)

[1] http://bugme.osdl.org/show_bug.cgi?id=3D7376

=2D-=20
S.=C3=87a=C4=9Flar Onur <caglar@pardus.org.tr>
http://cekirdek.pardus.org.tr/~caglar/

Linux is like living in a teepee. No Windows, no Gates and an Apache in hou=
se!

--nextPart2477084.5AFRIuNAYv
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFSap3y7E6i0LKo6YRArJPAJwNxZLUiSakTQaZIaVpNb4tDIyW5wCfbKrj
ueJp3qT/c3PODu3TSqmsP3o=
=heae
-----END PGP SIGNATURE-----

--nextPart2477084.5AFRIuNAYv--
