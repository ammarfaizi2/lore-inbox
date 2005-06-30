Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262834AbVF3P23@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262834AbVF3P23 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 11:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262849AbVF3P23
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 11:28:29 -0400
Received: from nysv.org ([213.157.66.145]:27305 "EHLO nysv.org")
	by vger.kernel.org with ESMTP id S262834AbVF3P2T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 11:28:19 -0400
Date: Thu, 30 Jun 2005 18:27:55 +0300
To: Christopher Warner <chris@servertogo.com>, shevek@bur.st,
       linux-kernel@vger.kernel.org
Subject: Re: reiser4 vs politics: linux misses out again
Message-ID: <20050630152755.GT11013@nysv.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vk2EvGhio7iZz8DU"
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From: mjt@nysv.org (Markus  =?ISO-8859-1?Q?=20T=F6rnqvist?=)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vk2EvGhio7iZz8DU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Christopher Warner wrote:

>Sweeping change is nice, incremental change is much more sweeter. The

Incremental change which should nonetheless lead to something much
more than what we have now, as sweetly as possible.

>problem is that the "filesystem" in and of itself is where data is kept.
>In most cases people who run commercial businesses aren't going to
>change their filesystem type unless their is a clear advantage.

And no one's asking them to.

>Therefore, you're argument negates real world. Your argument should be
>more about structure and a seamless migration path.

Yeah, boot the new kernel and it's there ;)
Oh and upgrade the userland tools if you want to use the extensions,
but certainly it has to be backward-compatible as well.

In this case people won't have to mkfs their enterprise servers.

>The argument isn't about technical merit.

No, it's about where Linux is going and where some people feel
it should go, and about discussing if it's a good idea to do
something a little different than everyone else, or most of
them, to get the best system out there shipped out.

Which I think is a no-brainer, who doesn't want Linux to be best ;)

The Mac/MS situation is of course a real threat, but Linux
does have the potential to be so much more.

Oh, and it's not just the VFS. What if someone gets a killer
idea for some other minor revolution inside the code that's
difficult to implement and may be un-unixy and more plan9y?

The argument is, therefore, mostly politics.

And on how to accomplish this:

The clearest idea is to fork off 2.7, or whatever, and extend
the VFS, and whatever, there and make sure it works before 2.8 is out.
Or figure out how to do this with -mm.

It just has to be very difficult with -mm, whose apparent intention
is to serve as proving ground for backportable patches, not
really major overhauls.

Socially a new, official dev tree would draw the most attention,=20
a lot more than an obscure semi- or un-official dev tree.

Furthermore, having a change this size pop up as 2.6.25 from
an -mm backport seems a bit off...

--=20
mjt


--vk2EvGhio7iZz8DU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCxA97IqNMpVm8OhwRAofMAJ4rc1JwpVnNsVVBx0HkE1jQOFh8hACgjpzs
CJ5p7NJrBLY38hJeAtpIGl0=
=E4bJ
-----END PGP SIGNATURE-----

--vk2EvGhio7iZz8DU--
