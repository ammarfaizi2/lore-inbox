Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263547AbTDTI3y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 04:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263548AbTDTI3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 04:29:54 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:34542 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S263547AbTDTI3x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 04:29:53 -0400
Subject: Re: Are linux-fs's drive-fault-tolerant by concept?
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Florian Weimer <fw@deneb.enyo.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1050789745.3961.19.camel@dhcp22.swansea.linux.org.uk>
References: <20030419180421.0f59e75b.skraw@ithnet.com>
	 <87lly6flrz.fsf@deneb.enyo.de>
	 <1050789745.3961.19.camel@dhcp22.swansea.linux.org.uk>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Qp5loyMlFJkdyZS7xtxx"
Organization: Red Hat, Inc.
Message-Id: <1050828106.1412.7.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 (1.2.4-2) 
Date: 20 Apr 2003 10:41:46 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Qp5loyMlFJkdyZS7xtxx
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2003-04-20 at 00:02, Alan Cox wrote:
> On Sad, 2003-04-19 at 18:18, Florian Weimer wrote:
> > Stephan von Krawczynski <skraw@ithnet.com> writes:
> >=20
> > > Most I came across have only small problems (few dead sectors),
> >=20
> > IDE disks automatically remap defective sectors, so you won't see any
> > of them unless the disk is already quite broken.
>=20
> You will if it writes and fails to read back. The disk can't invent a
> sector that is gone.=20

but linux can if you use an raid1 mirror... maybe we should teach the md
layer to write back the data from the other disk on a "bad sector"
error.

--=-Qp5loyMlFJkdyZS7xtxx
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+ol1JxULwo51rQBIRAtbIAJ9RMl+WJqWfM0d07tlghGNvEM8D0QCeLC8u
Re63l4ITwRY1l9zRuADzO0s=
=Bq9a
-----END PGP SIGNATURE-----

--=-Qp5loyMlFJkdyZS7xtxx--
