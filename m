Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751176AbVKEMgz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176AbVKEMgz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 07:36:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbVKEMgz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 07:36:55 -0500
Received: from mail01.solnet.ch ([212.101.4.135]:22288 "EHLO mail01.solnet.ch")
	by vger.kernel.org with ESMTP id S1751176AbVKEMgy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 07:36:54 -0500
From: Damir Perisa <damir.perisa@solnet.ch>
To: Richard Purdie <rpurdie@rpsys.net>, Greg KH <greg@kroah.com>
Subject: Re: ide-cs broken / udev magic
Date: Sat, 5 Nov 2005 13:36:42 +0100
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       Archlinux Developers <arch-dev@archlinux.org>
References: <20051103220305.77620d8f.akpm@osdl.org> <20051104232854.GA21173@kroah.com> <1131156412.8256.76.camel@localhost.localdomain>
In-Reply-To: <1131156412.8256.76.camel@localhost.localdomain>
X-Face: +)fhYFmn|<pyRIlgch_);krg#jn!^z'?xy(Ur#Z6rZi)KD+_-V<Y@i>0pOVfJ4<=?utf-8?q?Q1/=26/=26z=0A=093cxqRa=3B7O=5C4g=5C=7C=5DF-!H0!ew9kx1LqK/iP?=
 =?utf-8?q?Ov8eXi=26I7=60Pez0V0VNMAxnqRL8-30qqKK=3DxGM=0A=09pExQc=5B2=7C?=
 =?utf-8?q?l6v=23?=<iwBvEO9+h|_YS[48z%/kuD2*aT*S/$0323VCL3V9?@}jq<
 =?utf-8?q?Ns6V=3A0m=27Qia=0A=09?="[#oJg[RVe}Sy/lP95E@pa[vdKzqLqn&M`exb91"`,<k`3;Vt97cLjhub0.v+]m`%|>@Z(
 =?utf-8?q?=0A=09EeC/zU7=25?=@"L6mi#..8Q^M
Alanine: true
Glycine: true
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2922805.Co0TG3kiO3";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200511051336.49238.damir.perisa@solnet.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2922805.Co0TG3kiO3
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Le Saturday 05 November 2005 03:06, Richard Purdie a =E9crit=A0:
 | > > is there planed action to change ide-cs to work without making it
 | > > being ignored ... without this exception that needs to be
 | > > specified in udev rules?
 | >
 | > Yes, there are patches somewhere to fix this up, I'm trying to track
 | > them down.
=20
thanx for info + your work

 | This is a bug in the ide layer as CF pcmcia devices are marked as
 | removable but the devices (and the behaviour of ide-cs) does not fit
 | the Linux definition of such devices.
 |
 | See this thread: http://lkml.org/lkml/2005/9/21/118
=20
ah!... ok, now i understand more about that. what your patch is doing is=20
removing the "removable" status from them, right? what were the bad sides=20
of this patch? (why didn't it made to the linus or at least mm-tree?)

 | I'm hoping to work out a patch to change this in a manner acceptable
 | to everyone but haven't found time yet. I've not forgotten though.

if you need, i can test possible solutions. i have Apacer, Kodak and PQI=20
CF cards; SanDisk SD cards, a panasonic SD-to-CF convertor and a=20
CF-PCMCIA card.=20

greetings,
Damir

=2D-=20
The sum of the Universe is zero.

--nextPart2922805.Co0TG3kiO3
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDbKdhPABWKV6NProRAsPAAJwJUi3f0J4xIQ4VcpuGZ154/p2gBQCdE1tQ
nsttNf79pCSkpmSLID++FeA=
=ZJx4
-----END PGP SIGNATURE-----

--nextPart2922805.Co0TG3kiO3--
