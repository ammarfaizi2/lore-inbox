Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262184AbUBZPhz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 10:37:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262276AbUBZPhz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 10:37:55 -0500
Received: from node-d-1fcf.a2000.nl ([62.195.31.207]:53377 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S262184AbUBZPhw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 10:37:52 -0500
Subject: Re: 2.6.1 IO lockup on SMP systems
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Dave Jones <davej@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, rathamahata@php4.ru,
       linux-kernel@vger.kernel.org, gluk@php4.ru, anton@megashop.ru,
       mfedyk@matchmail.com
In-Reply-To: <20040226143710.GA3157@redhat.com>
References: <200401311940.28078.rathamahata@php4.ru>
	 <20040223142626.48938d7c.akpm@osdl.org>
	 <200402241454.08210.rathamahata@php4.ru>
	 <200402261519.35506.rathamahata@php4.ru>
	 <20040226045331.060c07d3.akpm@osdl.org>
	 <20040226051135.17171184.akpm@osdl.org>  <20040226143710.GA3157@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-cbkizD/6UGsBaW5ZeWYg"
Organization: Red Hat, Inc.
Message-Id: <1077809851.4443.4.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 26 Feb 2004 16:37:31 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-cbkizD/6UGsBaW5ZeWYg
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-02-26 at 15:37, Dave Jones wrote:
> On Thu, Feb 26, 2004 at 05:11:35AM -0800, Andrew Morton wrote:
>  > Andrew Morton <akpm@osdl.org> wrote:
>  > >
>  > > Not sure why the oom-killer didn't do anything.
>  >=20
>  > There's still free swap space.  The oom-killer has problems.
>=20
> That sounds odd. Surely if we have free swap, we don't
> want the oom-killer to do anything ?

with highmem it's not so easy :)
the lowzone can be entirely pinned by pagetables and such and the
highmem zone can be free... and still you want to oomkill.

--=-cbkizD/6UGsBaW5ZeWYg
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAPhK7xULwo51rQBIRAjH0AKCnh7WGkPHBSgNBB8/vla831DDmywCfe6es
b+1Yb2gjjRNlQ57nY6ZZz1I=
=KXVM
-----END PGP SIGNATURE-----

--=-cbkizD/6UGsBaW5ZeWYg--
