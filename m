Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262805AbUAXWoU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 17:44:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262827AbUAXWoU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 17:44:20 -0500
Received: from mx1.redhat.com ([66.187.233.31]:64928 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262805AbUAXWoN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 17:44:13 -0500
Date: Sat, 24 Jan 2004 23:43:49 +0100
From: Arjan van de Ven <arjanv@redhat.com>
To: Ville Herva <vherva@twilight.cs.hut.fi>,
       Felix von Leitner <felix-kernel@fefe.de>, linux-kernel@vger.kernel.org
Subject: Re: Request: I/O request recording
Message-ID: <20040124224349.GA3946@devserv.devel.redhat.com>
References: <20040124181026.GA22100@codeblau.de> <1074968776.4442.4.camel@laptop.fenrus.com> <20040124192545.GW11115091@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline
In-Reply-To: <20040124192545.GW11115091@niksula.cs.hut.fi>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 24, 2004 at 09:25:45PM +0200, Ville Herva wrote:
> On Sat, Jan 24, 2004 at 07:26:17PM +0100, you [Arjan van de Ven] wrote:
> >=20
> > I recently did something like this (and it scared me, it seems a typical
> > Fedora boot into gnome opens like 11.000 files ;) but via a printk in
> > the kernel....
> >=20
> > I experimented with readahead'ing all that stuff while the initscripts
> > ran in the hope it would save time... but it doesn't somehow.
>=20
> Did you sort the sectors to be read, or just read the files into page cac=
he
> in randomish order ?

semi random order but mostly submitted in parallel so the kernel has lots of
freedom to reorder

> Or do you mean that even after all the files were read into cache, the X
> startup time didn't get any better (not counting the cache priming)?

I mean that the time it takes to prime is just about exactly the time you
then win... eg net gain of about zero

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAEvUkxULwo51rQBIRAqD4AJ9Znu0tteE29cVuHRasjUDOi613OACdHuNj
gdy/F6GbTu8izo9S3Q8fE7w=
=WL/k
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
