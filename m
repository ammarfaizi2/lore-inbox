Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265862AbUBBVJN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 16:09:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265855AbUBBVJC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 16:09:02 -0500
Received: from kiuru.kpnet.fi ([193.184.122.21]:37551 "EHLO kiuru.kpnet.fi")
	by vger.kernel.org with ESMTP id S266107AbUBBVEZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 16:04:25 -0500
Subject: Re: Oops with 2.6.2-rc3
From: Markus =?ISO-8859-1?Q?H=E4stbacka?= <midian@ihme.org>
To: Jeremy Andrews <jandrews@kerneltrap.org>
Cc: Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <20040202201411.GA19268@home.kerneltrap.org>
References: <20040202201411.GA19268@home.kerneltrap.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-eNA2GL003WdTwwOwCfYx"
Message-Id: <1075755810.15169.4.camel@midux>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 02 Feb 2004 23:03:30 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-eNA2GL003WdTwwOwCfYx
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-02-02 at 22:14, Jeremy Andrews wrote:
> Hello,
>=20
>   Attached is the text from a series of four Oops that ultimately locked =
up my computer.  This is a new server that I've been having trouble getting=
 stable for the past week -- this is the first Oops I've managed to capture=
.  It's a 2.6.2-rc3 kernel compiled/running on Fedora Core 1 on a P4.  (I'v=
e not tried an -mm kernel yet, I'll try that soon.  I'm also thinking the s=
tock gcc 3.3.2 may be problematic...?)
>=20
>   The computer seems to crash once or twice a day -- always a hard freeze=
 requiring that I press the reset button to reboot.  I have not found a pat=
tern -- during this crash I had the Gnome desktop up and I was balancing my=
 checkbook with GnuCash.
>=20
>   The server has 1GB of RAM, so I originally enabled HIGHMEM (as the boot=
 messages recommend), but this made the system even more unstable, freezing=
 every couple of hours.  As you can see in the attached .config, HIGHMEM is=
 no longer enabled (and was not when this crash occured).  Running memtest8=
6 for several hours did not turn up any memory errors.
>=20
>   It may be a problem with how I've configured my kernel, but I've tried =
to be careful.  Relevant information is below and attached.
>=20
>   Kernel version:
> Linux papaya 2.6.2-rc3 #2 Sat Jan 31 22:15:02 EST 2004 i686 i686 i386 GNU=
/Linux
[..snip..]
I heard that the PREEMPT is causing problems, earlier, try without
CONFIG_PREEMPT

Could you please describe what the server is serving (router or
something else?)

I had that kind of problem with my router back in 2.6.0-test, I don't
know if it's fixed yet.
=20
	Markus

--=-eNA2GL003WdTwwOwCfYx
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAHrsh3+NhIWS1JHARAlyfAKCaHm8lwrWhUTHbMW5sIBhYBW46ZQCgjrEz
lhjUvcIvjxWuZXxHEVnqq88=
=buY0
-----END PGP SIGNATURE-----

--=-eNA2GL003WdTwwOwCfYx--

