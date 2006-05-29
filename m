Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751088AbWE2B3k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751088AbWE2B3k (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 21:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbWE2B3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 21:29:40 -0400
Received: from amnesiac.heapspace.net ([195.54.228.42]:34309 "EHLO
	amnesiac.heapspace.net") by vger.kernel.org with ESMTP
	id S1751088AbWE2B3j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 21:29:39 -0400
Date: Mon, 29 May 2006 04:29:33 +0300
From: Daniel Stone <daniel@fooishbar.org>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Dave Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: OpenGL-based framebuffer concepts
Message-ID: <20060529012933.GR16521@fooishbar.org>
Mail-Followup-To: Jon Smirl <jonsmirl@gmail.com>,
	Dave Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com> <200605272245.22320.dhazelton@enter.net> <9e4733910605272027o7b59ea5n5d402dabdd7167cb@mail.gmail.com> <200605280112.01639.dhazelton@enter.net> <21d7e9970605281613y3c44095bu116a84a66f5ba1d7@mail.gmail.com> <9e4733910605281759j2e7bebe1h6e3f2bf1bdc3fc50@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0aF+6pWUK5w8WdCh"
Content-Disposition: inline
In-Reply-To: <9e4733910605281759j2e7bebe1h6e3f2bf1bdc3fc50@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0aF+6pWUK5w8WdCh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 28, 2006 at 08:59:19PM -0400, Jon Smirl wrote:
> On 5/28/06, Dave Airlie <airlied@gmail.com> wrote:
> >c) Lots of distros don't use fbdev drivers, forcing this on them to
> >use drm isn't an option.
>=20
> Why isn't this an option? Will the distros that insist on continuing
> to ship three conflicting video drivers fighting over a single piece
> of hardware please stand up and be counted? Distros get new drivers
> all the time, why will this be any different?

Often they flat-out don't work.  Walk into a store and buy a random
laptop.  Odds are it uses an Intel graphics chip.  Now load intelfb on
this.  Watch it completely fail to set a mode, as intelfb has no
knowledge beyond what the CRTC was like on i810.

The support offered by fbdev drivers is laughable in comparison to the
support offered by X drivers.  If you're lucky, it fails cleanly.  If
not, you're silently failing to get a working display.

--0aF+6pWUK5w8WdCh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEek59RkzMgPKxYGwRAmstAJ0cz8m7JVtOs3GfioNKvKmRWZoAygCferj1
rO+SzW1gg2qxZwWe/o4W+7Q=
=mjgG
-----END PGP SIGNATURE-----

--0aF+6pWUK5w8WdCh--
