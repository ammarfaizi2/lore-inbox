Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932580AbWBQHhn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932580AbWBQHhn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 02:37:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932581AbWBQHhn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 02:37:43 -0500
Received: from admingilde.org ([213.95.32.146]:16785 "EHLO mail.admingilde.org")
	by vger.kernel.org with ESMTP id S932580AbWBQHhn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 02:37:43 -0500
Date: Fri, 17 Feb 2006 08:37:41 +0100
From: Martin Waitz <tali@admingilde.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC: more documentation in source files
Message-ID: <20060217073741.GB5517@admingilde.org>
Mail-Followup-To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
References: <20060216214033.GA5517@admingilde.org> <20060216224346.GA17190@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="K8nIJk4ghYZn606h"
Content-Disposition: inline
In-Reply-To: <20060216224346.GA17190@kroah.com>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--K8nIJk4ghYZn606h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Thu, Feb 16, 2006 at 02:43:46PM -0800, Greg KH wrote:
> What's wrong with just extending kerneldoc in the ways that you feel it
> would be more powerful?

nothing wrong with that, only a lot of work ;-)

> What specifically do you feel is lacking in kerneldoc that doxygen
> provides?

 * it automatically links all structures / function calls in the text
   to their detailed description.
 * it can put descriptive, structured text on one page with
   code documentation.
 * section hierarchy can be defined in the source files by assigning
   documentation blocks to "groups".
 * It's already there.

Most of these things won't be too hard to implement, but nethertheless
it will take some time.  I really don't want to reinvent the wheel.

Well, I'm not really fixed on doxygen, I just wanted to experiment
with other documentation systems to see what they can provide.
If someone can recommend a good one - fine.
If we write it ourself - fine, too.
But I don't want to start extending kernel-doc before taking a look
on alternatives.

--=20
Martin Waitz

--K8nIJk4ghYZn606h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFD9X1Ej/Eaxd/oD7IRAipUAJwMFXA1rQkTeMpXLShfhttuBkRaCACdGvY/
f+ZHvgoJHYTBgzOGAk0djX8=
=mCWx
-----END PGP SIGNATURE-----

--K8nIJk4ghYZn606h--
