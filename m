Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261960AbTH3SCM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 14:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261973AbTH3SCL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 14:02:11 -0400
Received: from codepoet.org ([166.70.99.138]:51904 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id S261960AbTH3SCD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 14:02:03 -0400
Date: Sat, 30 Aug 2003 12:01:50 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Martin List-Petersen <martin@list-petersen.se>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.22-ac1
Message-ID: <20030830180150.GA15950@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Martin List-Petersen <martin@list-petersen.se>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <200308291258.h7TCwmU24496@devserv.devel.redhat.com> <3F4F5401.1070401@basmevissen.nl> <20030829213136.GC3150@codepoet.org> <1062263687.9747.14.camel@loke>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
In-Reply-To: <1062263687.9747.14.camel@loke>
X-Operating-System: Linux 2.4.19-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat Aug 30, 2003 at 07:14:48PM +0200, Martin List-Petersen wrote:
> On Fri, 2003-08-29 at 23:31, Erik Andersen wrote:
> > On Fri Aug 29, 2003 at 03:24:17PM +0200, Bas Mevissen wrote:
> > > How do you feel about adding things like Alsa
> >=20
> > I made a patch adding alsa to 2.4.x a while back...  You just
> > need to apply these three patches. =20
> >=20
> >     http://codepoet.org/kernel/080-proc_dir_entry.bz2
> >     http://codepoet.org/kernel/081-export-rtc.bz2
> >     http://codepoet.org/kernel/082_alsa-0.9.2.bz2
> >=20
> > I've not updated it since 2.4.22-rc2, but it should patch into
> > 2.4.22 without any problem...  It works for me anyways. =20
>=20
> Got problems with those patched. I applied them to 2.4.22-ac1 (didn't
> complain much), however soundcore fails loading:
>=20
> # depmod-ae
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.22-20030830-marlow/kernel/sound/soundcore.o
> depmod:         snd_compat_devfs_remove
>=20
> I've seen something like that in
> http://www.geocrawler.com/archives/3/12349/2002/11/0/10252380/ on the
> alsa-devel list.=20
>=20
> Is your stuff pulled before that ?
> Or is it just the fact, that i'm not automounting devfs ?

I don't use devfs, so it may well be you need to pull
some additional bits from the alsa source tree.

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/UOaNX5tkPjDTkFcRAoRYAJ9t/tFogMMk2NL0Z6pt9yZLz8zm7wCgq7Gr
M+pzW0OK888mkEYK/0bFWK0=
=jkhV
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
