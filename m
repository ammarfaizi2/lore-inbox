Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266638AbUBRMwR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 07:52:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266666AbUBRMwR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 07:52:17 -0500
Received: from node-d-1fcf.a2000.nl ([62.195.31.207]:63360 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S266638AbUBRMwP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 07:52:15 -0500
Subject: Re: Non-GPL export of invalidate_mmap_range
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Andrew Morton <akpm@osdl.org>
Cc: paulmck@us.ibm.com, hch@infradead.org, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
In-Reply-To: <20040217161929.7e6b2a61.akpm@osdl.org>
References: <20040216190927.GA2969@us.ibm.com>
	 <20040217073522.A25921@infradead.org> <20040217124001.GA1267@us.ibm.com>
	 <20040217161929.7e6b2a61.akpm@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-E2wu3ln5CwykfiXaVV4I"
Organization: Red Hat, Inc.
Message-Id: <1077108694.4479.4.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 18 Feb 2004 13:51:35 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-E2wu3ln5CwykfiXaVV4I
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-02-18 at 01:19, Andrew Morton wrote:
> "Paul E. McKenney" <paulmck@us.ibm.com> wrote:
> >
> > IBM shipped the promised SAN Filesystem some months ago.
>=20
> Neat, but it's hard to see the relevance of this to your patch.
>=20
> I don't see any licensing issues with the patch because the filesystem
> which needs it clearly meets Linus's "this is not a derived work" criteri=
a.

it does?
It needed no changes to work on linux?
it only uses "core unix" apis ?
it needs no changes to the core kernel? *buzz*
It doesn't require knowledge of deep and changing internals ? *buzz*
It doesn't need changing for various kernel versions ?

I remember this baby overriding syscalls and the like not too long
ago...

The word "clearly" isn't correct imo. Just because something has a few
lines of code that started on another OS doesn't make it "clearly" not a
derived work, at least not in my eyes.





--=-E2wu3ln5CwykfiXaVV4I
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD4DBQBAM1/WxULwo51rQBIRAq4WAJdHRaSX8QcjqvALd8e4QqcaJIJKAKCHnkyw
Y1biVgYswaxGbDibHTN8uw==
=ufJy
-----END PGP SIGNATURE-----

--=-E2wu3ln5CwykfiXaVV4I--
