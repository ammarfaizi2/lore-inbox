Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945999AbWBDKM3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945999AbWBDKM3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 05:12:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946013AbWBDKM3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 05:12:29 -0500
Received: from cust8446.nsw01.dataco.com.au ([203.171.93.254]:47825 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1945999AbWBDKM2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 05:12:28 -0500
From: Nigel Cunningham <ncunningham@cyclades.com>
Organization: Cyclades Corporation
To: suspend2-devel@lists.suspend2.net
Subject: Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.
Date: Sat, 4 Feb 2006 20:08:59 +1000
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, Bojan Smojver <bojan@rexursive.com>,
       linux-kernel@vger.kernel.org
References: <200602030918.07006.nigel@suspend2.net> <1139015620.2191.39.camel@coyote.rexursive.com> <20060204085301.GI3291@elf.ucw.cz>
In-Reply-To: <20060204085301.GI3291@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1557242.GdA14yVzLf";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602042009.06462.ncunningham@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1557242.GdA14yVzLf
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Saturday 04 February 2006 18:53, Pavel Machek wrote:
> This was personal email. It is pretty rude to post it to public lists.
>
> > But hey, you seem to be bent on not having it - and you seem to be the
> > one making that calls, so the rest of us that just want to use the
> > notebooks properly will have to patch until someone decides that
> > having something that works is more important than being right all the
> > time.
>
> In the end, it is important what is right, not what works. If you do
> not understand that -- bad for you.

True, but in something like putting code in the kernel vs in userspace,=20
people apply different criteria in determining what is right. God hasn't=20
written "You shall do suspend to disk in userspace" (and we'd probably=20
rebel against Him anyway if He did :>), so we have to figure out what the=20
best way is. Is userspace the 'right' solution? Well, yes, it does let you=
=20
add features without adding to kernel code. But it also creates other=20
problems. Putting it in kernel space has issues too - some things like=20
userui are best left where they won't necessary take down the whole=20
process if they don't work right. Personally, I think we're getting too=20
polarised here. I've already accepted that there's a space for userspace=20
code by merging (into Suspend2) code that puts the user interface there,=20
along with management of storage. You agree that somethings, such as the=20
atomic copy, simply can't be done in userspace. Without having looked=20
seriously at the code yet, I'd be pretty sure that you're also leaving the=
=20
calculation of what pages to store in the kernel. That just leaves how to=20
store the image. Aren't we actually a lot closer than it has appeared?

Nigel

--nextPart1557242.GdA14yVzLf
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD5H1CN0y+n1M3mo0RArgvAKC7TDNMKdhNv3e5pwQ249Z85+2k9ACg0xRD
dB78OdcdUKPzpM7QWWG2ouo=
=6zBt
-----END PGP SIGNATURE-----

--nextPart1557242.GdA14yVzLf--
