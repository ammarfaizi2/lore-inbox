Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964782AbWGYPby@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964782AbWGYPby (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 11:31:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964783AbWGYPby
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 11:31:54 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:33701 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S964782AbWGYPbx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 11:31:53 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: Where does kernel/resource.c.1 file come from?
Date: Tue, 25 Jul 2006 17:33:33 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <200607251554.50484.eike-kernel@sf-tec.de> <20060725151520.GA15681@mars.ravnborg.org>
In-Reply-To: <20060725151520.GA15681@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart6462534.826o7Uupq0";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200607251733.38467.eike-kernel@sf-tec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart6462534.826o7Uupq0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Dienstag, 25. Juli 2006 17:15 schrieb Sam Ravnborg:
> On Tue, Jul 25, 2006 at 03:54:45PM +0200, Rolf Eike Beer wrote:
> > Hi,
> >
> > I'm playing around with my local copy of linux-2.6 git tree. I'm buildi=
ng
> > everything to a separate directory using O=3D to keep "git status" sile=
nt.
> >
> > After building I sometimes find a file kernel/resource.c.1 in my git tr=
ee
> > that doesn't really belong there. Who is generating this file, for what
> > reason and why doesn't it get created in my output directory?
>
> I have never seen this myself so a bit puzzled???
> Is it only kernel/resource.c that generates the .1 file - or is it
> somethign that is general?

No, it is always kernel/resource.c.1

> Can you also try to make sure that this file is generated as part of the
> build process. git status before and after should do it.

I've never seen anything but this file beside my local changes, which don't=
=20
affect the build process at all.

> If you can relaiably provoke it output of make V=3D1 would be usefull.

I'll try. Will probably take until tomorrow.

Eike

--nextPart6462534.826o7Uupq0
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBExjnSXKSJPmm5/E4RAsquAJ9adY4Tj1dUKRfxxJ+hB2KRJcc7jwCePLHP
W3MjqbQp3j8DG06Sg8RFSvc=
=nE/A
-----END PGP SIGNATURE-----

--nextPart6462534.826o7Uupq0--
