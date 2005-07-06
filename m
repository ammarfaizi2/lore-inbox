Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262185AbVGFJXm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262185AbVGFJXm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 05:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262191AbVGFJXl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 05:23:41 -0400
Received: from faui3es.informatik.uni-erlangen.de ([131.188.33.16]:41174 "EHLO
	faui3es.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S262185AbVGFHXf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 03:23:35 -0400
Date: Wed, 6 Jul 2005 09:20:59 +0200
From: Martin Waitz <tali@admingilde.org>
To: Jonathan Briggs <jbriggs@esoft.com>
Cc: Hans Reiser <reiser@namesys.com>, Ross Biro <ross.biro@gmail.com>,
       Hubert Chan <hubert@uhoreg.ca>, Horst von Brand <vonbrand@inf.utfsm.cl>,
       Kyle Moffett <mrmacman_g4@mac.com>, David Masover <ninja@slaphack.com>,
       Valdis.Kletnieks@vt.edu, Lincoln Dale <ltd@cisco.com>,
       Gregory Maxwell <gmaxwell@gmail.com>, Jeff Garzik <jgarzik@pobox.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
Message-ID: <20050706072059.GE15652@admingilde.org>
Mail-Followup-To: Jonathan Briggs <jbriggs@esoft.com>,
	Hans Reiser <reiser@namesys.com>, Ross Biro <ross.biro@gmail.com>,
	Hubert Chan <hubert@uhoreg.ca>,
	Horst von Brand <vonbrand@inf.utfsm.cl>,
	Kyle Moffett <mrmacman_g4@mac.com>,
	David Masover <ninja@slaphack.com>, Valdis.Kletnieks@vt.edu,
	Lincoln Dale <ltd@cisco.com>, Gregory Maxwell <gmaxwell@gmail.com>,
	Jeff Garzik <jgarzik@pobox.com>,
	Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	ReiserFS List <reiserfs-list@namesys.com>
References: <hubert@uhoreg.ca> <200506290509.j5T595I6010576@laptop11.inf.utfsm.cl> <87hdfgvqvl.fsf@evinrude.uhoreg.ca> <8783be6605062914341bcff7cb@mail.gmail.com> <42C3615A.9020600@namesys.com> <20050705154624.GC15652@admingilde.org> <1120602720.27600.79.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TU+u6i6jrDPzmlWF"
Content-Disposition: inline
In-Reply-To: <1120602720.27600.79.camel@localhost>
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


--TU+u6i6jrDPzmlWF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Tue, Jul 05, 2005 at 04:32:00PM -0600, Jonathan Briggs wrote:
> You could do filesystems in userspace too and just use the kernel's
> block layer.

but you can't do that in an library, you have to use a filesystem
server in order to get access control.
But you can build a library that handles uniform access to
files and directories.

Don't get me wrong, I'm all for a uniform interface for files and
metadata, but I don't think that it has to be in the kernel.
Gnome and KDE already have their own userspace VFS, something
like that should be used.

One has to distinguish between the low-level filesystem and
the storage system which is presented to the user.

--=20
Martin Waitz

--TU+u6i6jrDPzmlWF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCy4Zbj/Eaxd/oD7IRAguVAJ4vT8avX+ZkGGUSdVEiARDpP1zhuwCdERaQ
8Y6bC3l+jpDpyMl0aSo+Ryk=
=7MXK
-----END PGP SIGNATURE-----

--TU+u6i6jrDPzmlWF--
