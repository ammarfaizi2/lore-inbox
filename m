Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932824AbWKIMqJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932824AbWKIMqJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 07:46:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932825AbWKIMqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 07:46:09 -0500
Received: from mail.sf-mail.de ([62.27.20.61]:24722 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S932824AbWKIMqG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 07:46:06 -0500
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: A proposal; making 2.6.20 a bugfix only version.
Date: Thu, 9 Nov 2006 13:45:46 +0100
User-Agent: KMail/1.9.5
Cc: Diego Calleja <diegocg@gmail.com>, Jesper Juhl <jesper.juhl@gmail.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Adrian Bunk <bunk@stusta.de>
References: <9a8748490611081409x6b4cc4b4lc52b91c7b7b237a6@mail.gmail.com> <20061109002802.f61804fa.diegocg@gmail.com> <1163054902.3138.454.camel@laptopd505.fenrus.org>
In-Reply-To: <1163054902.3138.454.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3375255.QJBFWYpzcT";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200611091345.51940.eike-kernel@sf-tec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3375255.QJBFWYpzcT
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Arjan van de Ven wrote:
> On Thu, 2006-11-09 at 00:28 +0100, Diego Calleja wrote:
> > El Wed, 08 Nov 2006 23:22:11 +0100,
> >
> > Arjan van de Ven <arjan@infradead.org> escribi=C3=B3:
> > > > There are many parts of the kernel that are not documented.
> > >
> > > this is where the OSDL Documentation Person will help a lot; a full
> > > time person.
> >
> > Maybe it's just me, but wouldn't be this fixed by just asking developers
> > to document their code?
>
> it's a matter of skills. Someone can be awesome at coding a feature but
> his english and writing skills may be waaaaay down there.

Yes, that's maybe part of the problem. Nevertheless I think we should rejec=
t=20
every patch that adds new functions of global use (everything that might ge=
t=20
called from outside this module) without proper kerneldoc comments on it. A=
t=20
least everything that comes with EXPORT_SYMBOl_*.

I just remember that digging out all this cdev_* stuff from inside the code=
=20
was just pain. If your new feature is _that_ cool that it has to be=20
immediately merged than there will be surely someone out there to help you=
=20
with the documentation if your English is a bit poor. Someone has to review=
=20
that code anyway. If you can give him hints even in bad English what is goi=
ng=20
on it will surely help him (or her) to understand what you're doing, review=
=20
your code and write up some nice comments to make life for the next one to=
=20
touch it a _lot_ easier.

Eike

--nextPart3375255.QJBFWYpzcT
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBFUyL/XKSJPmm5/E4RAthVAJ9rzAt3+lPP+GcoVhXDy+HE9AkSKgCgiR7D
7n1R9TMzI5AhPDeiZyN23PA=
=l83P
-----END PGP SIGNATURE-----

--nextPart3375255.QJBFWYpzcT--
