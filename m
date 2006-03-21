Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751683AbWCUN1M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751683AbWCUN1M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 08:27:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751686AbWCUN1L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 08:27:11 -0500
Received: from hs-grafik.net ([80.237.205.72]:6416 "EHLO hs-grafik.net")
	by vger.kernel.org with ESMTP id S1751683AbWCUN1K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 08:27:10 -0500
From: Alexander Gran <alex@zodiac.dnsalias.org>
To: "Mattia Dongili" <malattia@linux.it>
Subject: Re: Bug on unmounting in 2.6.16-rc6-mm2
Date: Tue, 21 Mar 2006 14:27:00 +0100
User-Agent: KMail/1.9.1
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       reiserfs@namesys.com
References: <200603211219.14115@zodiac.zodiac.dnsalias.org> <200603211252.34797@zodiac.zodiac.dnsalias.org> <39320.217.33.203.18.1142942796.squirrel@picard.linux.it>
In-Reply-To: <39320.217.33.203.18.1142942796.squirrel@picard.linux.it>
X-Face: ){635DT*1Z+Z}$~Bf[[i"X:f2i+:Za[:Q0<UzyJPoAm(;y"@=?utf-8?q?LwMhWM4=5D=60x1bDaQDpet=3B=3Be=0A=09N=5CBIb8o=5BF!fdHrI-=7E=24?=
 =?utf-8?q?ctS=3F!?=,U+0}](xD}_b]awZrK=>753Wk;RwhCU`Bt(I^/Jxl~5zIH<
 =?utf-8?q?=0A=09XplI=3A9GKEcr/JPqzW=3BR=5FqDQe*=23CE=7E70=3Bj=25Hg8CNh*4?=<
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1642844.IiarpWyLGx";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200603211427.03657@zodiac.zodiac.dnsalias.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1642844.IiarpWyLGx
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Oh, yep.=20
I just tried umounting /home.
Bugs too, but system keeps running, so I could easily catch the dmesg:
http://zodiac.dnsalias.org/misc/2.6.16-rc6-mm2/dmesg-2

regards
Alex

Am Dienstag, 21. M=E4rz 2006 13:06 schrieb Mattia Dongili:
> On Tue, March 21, 2006 12:52 pm, Alexander Gran said:
> > Am Dienstag, 21. M=E4rz 2006 12:32 schrieb Andrew Morton:
>
> [...]
>
> >> > Sorry for the inconvenience, but I've got no OCR at hand ;)
> >>
> >> Is it reproducible?
> >
> > Yep.
>
> This is probably the same I get unmounting a reiser4 partition.
> I got the oops through netconsole, attached to avoid line wrapping.

=2D-=20
Encrypted Mails welcome.
PGP-Key at http://zodiac.dnsalias.org/misc/pgpkey.asc | Key-ID: 0x6D7DD291

--nextPart1642844.IiarpWyLGx
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEH/8n/aHb+2190pERArvJAKCG1uvs8EkzZtDWq+apVCK2280s7QCdHFzp
fApLYPcjuc3QdR1Amoy66QE=
=SGLl
-----END PGP SIGNATURE-----

--nextPart1642844.IiarpWyLGx--
