Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311796AbSCTQae>; Wed, 20 Mar 2002 11:30:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311797AbSCTQaZ>; Wed, 20 Mar 2002 11:30:25 -0500
Received: from ns01.passionet.de ([62.153.93.33]:47762 "HELO
	mail.cgn.kopernikus.de") by vger.kernel.org with SMTP
	id <S311796AbSCTQaK>; Wed, 20 Mar 2002 11:30:10 -0500
Date: Wed, 20 Mar 2002 17:29:43 +0100
From: Manon Goo <manon@manon.de>
Reply-To: Manon Goo <manon@manon.de>
To: Dave Jones <davej@suse.de>
Cc: "White, Charles" <Charles.White@COMPAQ.com>, Arrays <Arrays@COMPAQ.com>,
        linux-kernel@vger.kernel.org,
        =?ISO-8859-1?Q?Markus_Schr=F6der?= <schroeder.markus@allianz.de>
Subject: Re: Hooks for random device entropy generation missing in
 cpqarray.c
Message-ID: <5095533.1016645383@eva.dhcp.gimlab.org>
In-Reply-To: <20020320171655.F5094@suse.de>
X-Mailer: Mulberry/2.2.0b3 (Mac OS X)
X-manon-file: sentbox
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="==========05120663=========="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--==========05120663==========
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hmmm in cpqarray.c this appers to be called in cpqarray_init() is this only
called when the driver initalizes or at every access ?


--On Mittwoch, 20. M=E4rz 2002 17:16 Uhr +0100 Dave Jones <davej@suse.de>=20
wrote:

> On Wed, Mar 20, 2002 at 05:06:54PM +0100, Manon Goo wrote:
>  > I have a quick and drity patch for 1 contorlller:
>  > ...
>  >
>  > --On Mittwoch, 20. M=E4rz 2002 8:25 Uhr -0600 "White, Charles"
>  > <Charles.White@COMPAQ.com> wrote:
>  >
>  > >Yes.. I was reported that it some how got dropped from our 2.4
> version of  > >the driver..  DON'T add add_interrupt_randomness, just add
> "|  > >SA_SAMPLE_RANDOM" to the call to request_irq.
>  > How would I do this for the cpqarray ?
>
>  Exactly like Charles explained how to. See also...
>  http://www.codemonkey.org.uk/patches/merged/2.5.4/dj2/random-cpqirq.diff
>  if it still isnt' clear.
> --
>| Dave Jones.        http://www.codemonkey.org.uk
>| SuSE Labs


--==========05120663==========
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (Darwin)
Comment: For info see http://www.gnupg.org

iD8DBQE8mLj3lp/TJR6NORURAoDrAKCQNSVZH5GHV8Sum2ajnOKfXOspOwCfU+qM
0TOeWbUyz/lsf0No3gnV/bM=
=CsTc
-----END PGP SIGNATURE-----

--==========05120663==========--

