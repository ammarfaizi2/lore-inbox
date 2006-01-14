Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751581AbWANNQg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751581AbWANNQg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 08:16:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751579AbWANNQg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 08:16:36 -0500
Received: from smtprelay06.ispgateway.de ([80.67.18.44]:4569 "EHLO
	smtprelay06.ispgateway.de") by vger.kernel.org with ESMTP
	id S1751290AbWANNQf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 08:16:35 -0500
From: Ingo Oeser <ioe-lkml@rameria.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [patch 00/62] sem2mutex: -V1
Date: Sat, 14 Jan 2006 14:16:13 +0100
User-Agent: KMail/1.7.2
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Jes Sorensen <jes@trained-monkey.org>, Greg KH <greg@kroah.com>
References: <20060113124402.GA7351@elte.hu> <200601131925.34971.ioe-lkml@rameria.de> <20060113195658.GA3780@elte.hu>
In-Reply-To: <20060113195658.GA3780@elte.hu>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1638038.euvqrMeBtZ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200601141416.20055.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1638038.euvqrMeBtZ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 13 January 2006 20:56, Ingo Molnar wrote:
> * Ingo Oeser <ioe-lkml@rameria.de> wrote:
> > On Friday 13 January 2006 14:44, Ingo Molnar wrote:
> > Could we get for each of these and a mutex:
> >=20
> >  - description=20
> >  - common use case
> >  - small argument why this and nothing else should be used there
>=20
> like ... Documentation/mutex-design.txt?

Much simpler.=20

Take your favorite conversion and optionally a discussable
conversion. Now describe why mutex/completion/struct work can do=20
the same and still reach the same level of safety.

Sth. like extending Documentation/DocBook/kernel-locking.tmpl
which still misses completions and struct work queues,
how all works together, possible nesting and so on.

It all boils down to discussion one conversion of each type.
If one could point me to such discussions in the archives=20
I could write sth. up.


Regards

Ingo Oeser


--nextPart1638038.euvqrMeBtZ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDyPmjU56oYWuOrkARAu0FAKDapZhaYtXqX+/W+BeuRdxzMABn1QCgxQk3
IrgCGRSg0QvM3gUu8+NQtKc=
=GyvE
-----END PGP SIGNATURE-----

--nextPart1638038.euvqrMeBtZ--
