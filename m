Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261900AbVGEQFB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261900AbVGEQFB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 12:05:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261924AbVGEQEz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 12:04:55 -0400
Received: from faui3es.informatik.uni-erlangen.de ([131.188.33.16]:34759 "EHLO
	faui3es.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261900AbVGEPul (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 11:50:41 -0400
Date: Tue, 5 Jul 2005 17:46:24 +0200
From: Martin Waitz <tali@admingilde.org>
To: Hans Reiser <reiser@namesys.com>
Cc: Ross Biro <ross.biro@gmail.com>, Hubert Chan <hubert@uhoreg.ca>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Kyle Moffett <mrmacman_g4@mac.com>, David Masover <ninja@slaphack.com>,
       Valdis.Kletnieks@vt.edu, Lincoln Dale <ltd@cisco.com>,
       Gregory Maxwell <gmaxwell@gmail.com>, Jeff Garzik <jgarzik@pobox.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
Message-ID: <20050705154624.GC15652@admingilde.org>
Mail-Followup-To: Hans Reiser <reiser@namesys.com>,
	Ross Biro <ross.biro@gmail.com>, Hubert Chan <hubert@uhoreg.ca>,
	Horst von Brand <vonbrand@inf.utfsm.cl>,
	Kyle Moffett <mrmacman_g4@mac.com>,
	David Masover <ninja@slaphack.com>, Valdis.Kletnieks@vt.edu,
	Lincoln Dale <ltd@cisco.com>, Gregory Maxwell <gmaxwell@gmail.com>,
	Jeff Garzik <jgarzik@pobox.com>,
	Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	ReiserFS List <reiserfs-list@namesys.com>
References: <hubert@uhoreg.ca> <200506290509.j5T595I6010576@laptop11.inf.utfsm.cl> <87hdfgvqvl.fsf@evinrude.uhoreg.ca> <8783be6605062914341bcff7cb@mail.gmail.com> <42C3615A.9020600@namesys.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hxkXGo8AKqTJ+9QI"
Content-Disposition: inline
In-Reply-To: <42C3615A.9020600@namesys.com>
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--hxkXGo8AKqTJ+9QI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Wed, Jun 29, 2005 at 08:04:58PM -0700, Hans Reiser wrote:
> >How is directories as files logically any different than putting all
> >data into .data files and making all files directories (yes you would
> >need some sort of special handling for files that were really called
> >.data).=20
> >
> Add to this that you make .data the default if the file within the
> directory is not specified, and define a stanadard set of names for
> metafiles, and you've got the essential idea, and any differences are
> details.

sure, that would work more or less, but what would it give you?
You haven't introduced anything new that userspace couldn't do before.
Just write a library which mangles pathnames and treats files and
directories the same. You don't need the kernel to do that.

Filesystems are there to store files.
Everything else can be done in userspace.

--=20
Martin Waitz

--hxkXGo8AKqTJ+9QI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCyqtQj/Eaxd/oD7IRAutQAJ9SVdhimwM4FQtsy474jufwR0u+hwCaAjI0
1GgC+SvUvSLvRd9FIWOJ7NM=
=TiSP
-----END PGP SIGNATURE-----

--hxkXGo8AKqTJ+9QI--
