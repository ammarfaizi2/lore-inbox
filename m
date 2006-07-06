Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965125AbWGFDDk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965125AbWGFDDk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 23:03:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965129AbWGFDDk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 23:03:40 -0400
Received: from wx-out-0102.google.com ([66.249.82.197]:53284 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S965125AbWGFDDj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 23:03:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=bx/yL4SUtkgp+wOIT4vgjgbECCBQZ/edk8y6nSLNxewohz6KUR11wmCNdq9oGdOYY3LEPyTDZVwtSLnP4MAfzoxqccse+A6s+iPGjoHcSLjNDqWMEUWvE+1cXUiERvWwxMEsfmdlsZktfdkpDXVzkpNtjtglOiTAaOCdw7ThfR0=
Date: Wed, 5 Jul 2006 23:03:37 -0400
From: Thomas Tuttle <thinkinginbinary@gmail.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: Create new LED trigger for CPU activity (ledtrig-cpu) (UPDATED)
Message-ID: <20060706030337.GC25835@phoenix>
References: <e4cb19870607051948t7e6d208m729a572a65f2da5e@mail.gmail.com> <20060705200126.48f83ec0.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qz2CZ664xQdCRdPu"
Content-Disposition: inline
In-Reply-To: <20060705200126.48f83ec0.rdunlap@xenotime.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Qz2CZ664xQdCRdPu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On July 05 at 23:01 EDT, Randy.Dunlap hastily scribbled:
> On Wed, 5 Jul 2006 22:48:17 -0400 Thomas Tuttle wrote:
>=20
> > Here is a new version of the patch, incorporating code style tips from
> > Randy Dunlap <rdunlap@xenotime.net>, and based on 2.6.17-git25, rather
> > than 2.6.17.1.
> >=20
> > I noticed that there's a Heartbeat LED trigger in the git version.  I
> > hope this isn't too similar.
>=20
> I missed at least one thing:
>=20
> Don't #include <linux/config.h>
> That is done automatically now by Kbuild.  Source files
> should not do it.  (you could wait to see if there are other comments. :)
>=20
> ---
> ~Randy

Are you sure?  Will it rebuild a file if a config entry is changed that
is simply mentioned in an #ifdef?

Is this a recent change?  It wasn't working this way in 2.6.17.1--it
automatically noticed changes to the config of the file itself, but not
to config symbols tested using #ifdef.

--Qz2CZ664xQdCRdPu
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFErH2J/UG6u69REsYRAm5aAJ9B3/DKmXyKrDuoPZEZj8CYTaK2pACfVC1M
iLn7mqnNLR6lb6yKbXeN5Uc=
=wB0i
-----END PGP SIGNATURE-----

--Qz2CZ664xQdCRdPu--
