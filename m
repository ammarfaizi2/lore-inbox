Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262184AbUCGQIl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 11:08:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262190AbUCGQIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 11:08:41 -0500
Received: from mx1.redhat.com ([66.187.233.31]:29917 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262184AbUCGQIj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 11:08:39 -0500
Date: Sun, 7 Mar 2004 17:08:24 +0100
From: Arjan van de Ven <arjanv@redhat.com>
To: Andreas Gruenbacher <agruen@suse.de>, Sam Ravnborg <sam@ravnborg.org>,
       lkml <linux-kernel@vger.kernel.org>,
       "kbuild-devel@lists.sourceforge.net" 
	<kbuild-devel@lists.sourceforge.net>
Subject: Re: External kernel modules, second try
Message-ID: <20040307160824.GA14967@devserv.devel.redhat.com>
References: <1078620297.3156.139.camel@nb.suse.de> <20040307125348.GA2020@mars.ravnborg.org> <1078664629.9812.1.camel@laptop.fenrus.com> <1078667199.3594.50.camel@nb.suse.de> <1078668091.9106.1.camel@laptop.fenrus.com> <20040307160527.GA2027@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
Content-Disposition: inline
In-Reply-To: <20040307160527.GA2027@mars.ravnborg.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 07, 2004 at 05:05:27PM +0100, Sam Ravnborg wrote:
> On Sun, Mar 07, 2004 at 03:01:31PM +0100, Arjan van de Ven wrote:
> > >  and it's missing the symbols from
> > > module files.
> >=20
> > sure but the module files are generally installed...
> I'm aiming for a situation where I can build external modules,
> using an almost clean kernel src tree.

Personally I don't see the point. I'm perfectly happy with the current
situation with the exception of not using System.map and co.

=46rom a distribution kernel pov; I already ship a subset of files for buil=
ding
modules against (basically include/, the KConfig and makefiles), which only
not 100% works because I don't ship vmlinux.


--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAS0j3xULwo51rQBIRApWdAJ9ue9FTMNFuXYjPhawsezYGahajpgCfdbIX
4+LpaMLE5w7Wth9TMyeRBcE=
=/mDQ
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--
