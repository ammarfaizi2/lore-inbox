Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265443AbUAJWIu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 17:08:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265467AbUAJWIu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 17:08:50 -0500
Received: from node-d-1fcf.a2000.nl ([62.195.31.207]:62596 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S265443AbUAJWIs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 17:08:48 -0500
Subject: Re: [Dri-devel] 2.6 kernel change in nopage
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       dri-devel <dri-devel@lists.sourceforge.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1073771694.2290.17.camel@thor.asgaard.local>
References: <20031231182148.26486.qmail@web14918.mail.yahoo.com>
	 <1072958618.1603.236.camel@thor.asgaard.local>
	 <1072959055.5717.1.camel@laptop.fenrus.com>
	 <1072959820.1600.252.camel@thor.asgaard.local>
	 <20040101122851.GA13671@devserv.devel.redhat.com>
	 <1072967278.1603.270.camel@thor.asgaard.local>
	 <Pine.LNX.4.58.0401011205110.2065@home.osdl.org>
	 <1073771694.2290.17.camel@thor.asgaard.local>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-fUIxjoVi/oCSn1dLUGAA"
Organization: Red Hat, Inc.
Message-Id: <1073772500.4432.5.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sat, 10 Jan 2004 23:08:20 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-fUIxjoVi/oCSn1dLUGAA
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 2004-01-10 at 22:54, Michel D=C3=A4nzer wrote:
> First of all, thanks for all the suggestions I've received in this
> thread.
>=20
> New patch up at http://penguinppc.org/~daenzer/DRI/drm-nopage.diff; does
> this look acceptable to those who are going to do merges between the
> trees? :)

I like this one a whole lot better than the previous ones...
One could argue that you want the do_ function set the pagefault type
itself (and just igore the result in the 2.4 variants) but that's minor
nitpicking at most.

--=-fUIxjoVi/oCSn1dLUGAA
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAAHfUxULwo51rQBIRAqLDAJ9byXOcb7eYTsuhl1SpWeJ/20gTqQCfbNsM
suGsQoxeKqhhGqYsOe1etGU=
=SWo/
-----END PGP SIGNATURE-----

--=-fUIxjoVi/oCSn1dLUGAA--
