Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262978AbVF3OWp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262978AbVF3OWp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 10:22:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262979AbVF3OWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 10:22:45 -0400
Received: from nysv.org ([213.157.66.145]:10183 "EHLO nysv.org")
	by vger.kernel.org with ESMTP id S262978AbVF3OVa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 10:21:30 -0400
Date: Thu, 30 Jun 2005 17:21:07 +0300
To: Nikita Danilov <nikita@clusterfs.com>
Cc: Douglas McNaught <doug@mcnaught.org>, Hubert Chan <hubert@uhoreg.ca>,
       Kyle Moffett <mrmacman_g4@mac.com>, David Masover <ninja@slaphack.com>,
       Valdis.Kletnieks@vt.edu, Lincoln Dale <ltd@cisco.com>,
       Gregory Maxwell <gmaxwell@gmail.com>, Hans Reiser <reiser@namesys.com>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
Message-ID: <20050630142107.GQ11013@nysv.org>
References: <20050629135820.GJ11013@nysv.org> <200506291719.j5THJCSg011438@laptop11.inf.utfsm.cl> <20050630095926.GN11013@nysv.org> <17091.60930.633968.822210@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="15+E349fsei051WC"
Content-Disposition: inline
In-Reply-To: <17091.60930.633968.822210@gargle.gargle.HOWL>
User-Agent: Mutt/1.5.9i
From: mjt@nysv.org (Markus  =?ISO-8859-1?Q?=20T=F6rnqvist?=)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--15+E349fsei051WC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 30, 2005 at 05:05:06PM +0400, Nikita Danilov wrote:

>You will have to force user level to use common framework
>anyway.

Naturally.

>Otherwise one application will use
>
>~/pictures/sunset.jpg/...meta/mime-type
>
>and another one
>
>~/pictures/sunset.jpg/...meta/XML-schema-FOOBAR/version-0.99/attributes/co=
mmon/MIME-type/value
>
>etc. Putting mechanism into kernel doesn't make it somehow magically
>interoperable. It is _policy_ that does. And policy belongs to the
>kernel not.

Indeed this may not be something where Infinite Diversity in
Infinite Combinations is a good thing.

The best way to make sure everything works ok, is to draw out the
specs for a policy and ensure it, but maybe it can't be enforced
in the kernel.

Unless the policy defined which directories (disregard the irony,
please :) in the meta structure are available and off limits for
mkdir et al.

Sure this may be circumvented still by setting up an xml schema
somewhere and so on and so forth.

So my best guess probably is to have LSB extended with a damned
good policy about How Things Work(tm) with the new meta system.

--=20
mjt


--15+E349fsei051WC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCw//TIqNMpVm8OhwRAubeAKCMlpRdTmmQiOK8DI9EawG0uPQESgCg0bg0
AyYr4cvzv3+7cvPfbpDoVtM=
=miQV
-----END PGP SIGNATURE-----

--15+E349fsei051WC--
