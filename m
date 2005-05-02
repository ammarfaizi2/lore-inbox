Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261152AbVEBVaw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbVEBVaw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 17:30:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261153AbVEBVaw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 17:30:52 -0400
Received: from mail01.solnet.ch ([212.101.4.135]:7182 "EHLO mail01.solnet.ch")
	by vger.kernel.org with ESMTP id S261152AbVEBVam (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 17:30:42 -0400
From: Damir Perisa <damir.perisa@solnet.ch>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.12-rc3-mm2 - kswapd0 keeps running
Date: Mon, 2 May 2005 23:30:19 +0200
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <20050430164303.6538f47c.akpm@osdl.org> <200505021732.00590.damir.perisa@solnet.ch> <20050502111452.0dca6625.akpm@osdl.org>
In-Reply-To: <20050502111452.0dca6625.akpm@osdl.org>
X-Face: +)fhYFmn|<pyRIlgch_);krg#jn!^z'?xy(Ur#Z6rZi)KD+_-V<Y@i>0pOVfJ4<=?iso-8859-1?q?Q1/=26/=26z=0A=093cxqRa=3B7O=5C4g=5C=7C=5DF-!H0!ew9kx1LqK/?=
 =?iso-8859-1?q?iPOv8eXi=26I7=60Pez0V0VNMAxnqRL8-30qqKK=3DxGM=0A=09pExQc=5B?=
 =?iso-8859-1?q?2=7Cl6v=23?=<iwBvEO9+h|_YS[48z%/kuD2*aT*S/$0323VCL3V9?@}jq<
 =?iso-8859-1?q?Ns6V=3A0m=27Qia=0A=09?="[#oJg[RVe}Sy/lP95E@pa[vdKzqLqn&M`exb91"`,<k`3;Vt97cLjhub0.v+]m`%|>@Z(
 =?iso-8859-1?q?=0A=09EeC/zU7=25?=@"L6mi#..8Q^M
Alanine: true
Glycine: true
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1182279.9rhmp4uA2H";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200505022330.22216.damir.perisa@solnet.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1182279.9rhmp4uA2H
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Le Monday 02 May 2005 20:14, Andrew Morton a =E9crit=A0:
> hm. =A0I wonder why you had any cachefs pages anyway. =A0Is the sysrq-P
> trace always the same?

since i modified it to enable magic keys, yes, every time i tried to=20
output Regs (sysrq-P), the same outputs. i will keep observing and=20
reporting, if cases with different output appear.

> Does disabling cachefs in kerel config fix it?

unfortunately, the cpu on this machine is busy for the next few days, so i=
=20
cannot recompile the kernel right now ... i will recompile disabling=20
cachefs as soon as i have the resources for it (we all know, students=20
have limited resources, especially students interested in=20
bioinformatics). ... or is there a way to disable cachefs on the run=20
(without recompiling/rebooting)?=20

untill then, remaining with best regards,
Damir

=2D-=20
Because we don't think about future generations, they will never forget=20
us.
		-- Henrik Tikkanen

--nextPart1182279.9rhmp4uA2H
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCdpvuPABWKV6NProRAnJFAJ968Bq/4dVutzEABo6XRVZdQn1TggCfbMZZ
aCUxpZ1Hh+ruIwFA5kEtiH8=
=s/JU
-----END PGP SIGNATURE-----

--nextPart1182279.9rhmp4uA2H--
