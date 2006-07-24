Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750944AbWGXPMF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750944AbWGXPMF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 11:12:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751019AbWGXPMF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 11:12:05 -0400
Received: from amnesiac.heapspace.net ([195.54.228.42]:43015 "EHLO
	amnesiac.heapspace.net") by vger.kernel.org with ESMTP
	id S1750944AbWGXPME (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 11:12:04 -0400
Date: Mon, 24 Jul 2006 18:11:59 +0300
From: Daniel Stone <daniel@fooishbar.org>
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: Magnus =?iso-8859-1?Q?Vigerl=F6f?= <wigge@bigfoot.com>,
       linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [RFC] input: Wacom tablet driver for simple X hotplugging
Message-ID: <20060724151159.GA5082@fooishbar.org>
References: <20060721211341.5366.93270.sendpatchset@pipe> <200607212209.05254.dtor@insightbb.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline
In-Reply-To: <200607212209.05254.dtor@insightbb.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 21, 2006 at 10:09:04PM -0400, Dmitry Torokhov wrote:
> On Friday 21 July 2006 17:13, Magnus Vigerl=F6f wrote:
> > I'd appreciate whether you think this is a viable idea to make it as a
> > generic driver instead or should I continue with the Wacom-specific
> > one. I know the 'right' thing would be to make X truly hot-plug aware,
> > but this driver is something that would be possible to use in current
> > systems without any problems.
> >=20
>=20
> Yes, I think fixing X would ultimately be time better spent.=20

It's already mostly done, and should hopefully land for 7.2.  It's a
neat concept, along the lines of /dev/input/mice, but the time for that
kind of pathological braindamage is long gone.

Cheers,
Daniel

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFExOM+RkzMgPKxYGwRArZyAJ0UHhjdbJeTWjDkdM2iGbjb09gRgQCfRaVH
MrOBGRELyhscY2AWZ0lc+7g=
=scxB
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--
