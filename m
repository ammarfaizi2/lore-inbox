Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264255AbUGFSew@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264255AbUGFSew (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 14:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264258AbUGFSew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 14:34:52 -0400
Received: from multivac.one-eyed-alien.net ([64.169.228.101]:62117 "EHLO
	multivac.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id S264255AbUGFSet (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 14:34:49 -0400
Date: Tue, 6 Jul 2004 11:34:45 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: surfing t <surf17@lycos.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Points to fs architecture
Message-ID: <20040706183445.GA28783@one-eyed-alien.net>
Mail-Followup-To: surfing t <surf17@lycos.com>,
	linux-kernel@vger.kernel.org
References: <20040705213858.2002086AE1@ws7-1.us4.outblaze.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline
In-Reply-To: <20040705213858.2002086AE1@ws7-1.us4.outblaze.com>
User-Agent: Mutt/1.4.1i
Organization: One Eyed Alien Networks
X-Copyright: (C) 2004 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This sounds like a job for dazuko (www.dazuko.org) -- I know that utilities
like ClamAV use that to accomplish some very similar things to what you're
describing.

Matt

On Mon, Jul 05, 2004 at 04:38:58PM -0500, surfing t wrote:
> Hello,
>=20
> I want to create a utility that "hooks" into the the filesystem. What I w=
ant to do is to be able to review
> all file system read/write/seek requests, most of the time without affect=
ing file system operation (ie after
> review the request is passed on to the entity that would have received it=
 had my utility not been installed, however
> some of the requests my driver should handle itself. My problem is that w=
hile I have first-hand experience on kernel
> programming I have never done anything on a UNIX og Linux kernel and I on=
ly know its structure from a user-level
> perspective. Where can I find documentation on how to code drivers for th=
e Linux kernel and about how the entire
> file system works (by "file system" I don't refer to ext3 or reiserfs or =
anything like that - I mean the architecture that allows all these things t=
o co-exist). I want my driver to be at a level above things like ext3/reise=
rfs if possible. Basically I just want to "hijack" the system calls that ap=
plications use to access files and then pass them on to the original system=
 call. Is this possible and how do I do it? Any help will be greatly apprec=
iated and the utility I have in mind will benefit the entire community (I w=
ill GPL it of course) and I believe it could so some extent make Linux more=
 popular. I am a bit secretive right now because I really want to implement=
 this idea myself. I will give credit to those who responds to this message.
>=20
> Thank you in advance!
> --=20
> _______________________________________________
> Find what you are looking for with the Lycos Yellow Pages
> http://r.lycos.com/r/yp_emailfooter/http://yellowpages.lycos.com/default.=
asp?SRC=3Dlycos10
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

NYET! The evil stops here!
					-- Pitr
User Friendly, 6/22/1998

--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFA6vDFIjReC7bSPZARAgVXAJ9kCsB3ZavdGKFOWNXEL9yyzEmNGgCeLnbM
u9QtsrHAn1WpWKjIDnpKzmw=
=X2zI
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--
