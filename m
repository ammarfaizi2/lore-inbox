Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264830AbUEYJg4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264830AbUEYJg4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 05:36:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264827AbUEYJg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 05:36:56 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:19670 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S264830AbUEYJgx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 05:36:53 -0400
Date: Tue, 25 May 2004 11:36:52 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Alan Cox <alan@redhat.com>
Cc: Willy Tarreau <willy@w.ods.org>, Christoph Hellwig <hch@alpha.home.local>,
       akpm@osdl.org, linux-kernel@vger.kernel.org,
       vda@port.imtp.ilyichevsk.odessa.uay
Subject: Re: i486 emu in mainline?
Message-ID: <20040525093652.GA1912@lug-owl.de>
Mail-Followup-To: Alan Cox <alan@redhat.com>,
	Willy Tarreau <willy@w.ods.org>,
	Christoph Hellwig <hch@alpha.home.local>, akpm@osdl.org,
	linux-kernel@vger.kernel.org, vda@port.imtp.ilyichevsk.odessa.uay
References: <20040522234059.GA3735@infradead.org> <20040523082912.GA16071@alpha.home.local> <20040523110836.GE25746@devserv.devel.redhat.com> <20040523115735.GA16726@alpha.home.local> <20040523131512.GA25185@devserv.devel.redhat.com> <20040524151715.GS1912@lug-owl.de> <20040524174156.GG19161@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1Ne/rU5PZopP5O+/"
Content-Disposition: inline
In-Reply-To: <20040524174156.GG19161@devserv.devel.redhat.com>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1Ne/rU5PZopP5O+/
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-05-24 13:41:56 -0400, Alan Cox <alan@redhat.com>
wrote in message <20040524174156.GG19161@devserv.devel.redhat.com>:
> On Mon, May 24, 2004 at 05:17:15PM +0200, Jan-Benedict Glaw wrote:
> > There are some application that register signal handling functions IIRC
> > for SIGILL, SIGSEGV and the like to do internal error trapping on their
> > own (not only OOo comes to mind). These would probably be f*cked up if =
they
> > didn't call the LD_PRELOADed signal handler...
>=20
> No. The LD_PRELOAD also hooks the signal setting functions. This really is
> not rocket science at all.=20

But works only on dynamically linkes executables, and only on those that
don't do system calls on their own, right?

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--1Ne/rU5PZopP5O+/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAsxOzHb1edYOZ4bsRAnfEAKCRP3Z4bk0jvRfXfcu6BD8GbASWPACdGU86
yaR1N6ZRBm/YE0Nq1sXuGzI=
=nmlI
-----END PGP SIGNATURE-----

--1Ne/rU5PZopP5O+/--
