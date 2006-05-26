Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750833AbWEZOmT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750833AbWEZOmT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 10:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750838AbWEZOmT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 10:42:19 -0400
Received: from lug-owl.de ([195.71.106.12]:49025 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S1750833AbWEZOmS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 10:42:18 -0400
Date: Fri, 26 May 2006 16:42:16 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, lkml <linux-kernel@vger.kernel.org>,
       drepper@redhat.com, akpm <akpm@osdl.org>, serue@us.ibm.com,
       sam@vilain.net, clg@fr.ibm.com, dev@sw.ru
Subject: Re: [PATCH] POSIX-hostname up to 255 characters
Message-ID: <20060526144216.GZ13513@lug-owl.de>
Mail-Followup-To: "Eric W. Biederman" <ebiederm@xmission.com>,
	"Randy.Dunlap" <rdunlap@xenotime.net>,
	lkml <linux-kernel@vger.kernel.org>, drepper@redhat.com,
	akpm <akpm@osdl.org>, serue@us.ibm.com, sam@vilain.net,
	clg@fr.ibm.com, dev@sw.ru
References: <20060525204534.4068e730.rdunlap@xenotime.net> <m1zmh5b129.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RUvhGz2nhX7DIu1B"
Content-Disposition: inline
In-Reply-To: <m1zmh5b129.fsf@ebiederm.dsl.xmission.com>
X-Operating-System: Linux mail 2.6.12.3lug-owl
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--RUvhGz2nhX7DIu1B
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-05-26 03:14:06 -0600, Eric W. Biederman <ebiederm@xmission.com=
> wrote:
> "Randy.Dunlap" <rdunlap@xenotime.net> writes:
> > This patch is against 2.6.17-rc5, for review/comments, please.
> > It won't apply to -mm since Andrew has merged the uts-namespace patches.
> > I'll see about merging it with those patches next.
> > ---
> >
> > From: Randy Dunlap <rdunlap@xenotime.net>
> >
> > Implement POSIX-defined length for 'hostname' so that hostnames
> > can be longer than 64 characters (max. 255 characters plus
> > terminating NULL character).
> >
> > Adds sys_gethostname_long() and sys_sethostname_long().
> > Tested on i386 and x86_64.
>=20
> Is there any particular reason for this?
> The existing sys_gethostname and sys_sethostname interfaces
> should work for any string length.
>=20
> Although I do agree that we need at least one new syscall
> for the architectures that don't currently use get_hostname.

=2E..and this should have gone to linux-arch, too...

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 f=C3=BCr einen Freien Staat voll Freier B=C3=BCrger"  | im Internet! |   i=
m Irak!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--RUvhGz2nhX7DIu1B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEdxPIHb1edYOZ4bsRAlfyAJ0d3/tPD+U7fxgpz0cPBq1ibjvtowCff00W
T1YsRNCxQcOxiuH/2ixb3bI=
=rrp9
-----END PGP SIGNATURE-----

--RUvhGz2nhX7DIu1B--
