Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266064AbSLCFDL>; Tue, 3 Dec 2002 00:03:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266069AbSLCFDL>; Tue, 3 Dec 2002 00:03:11 -0500
Received: from viola.sinor.ru ([217.70.106.9]:45549 "EHLO viola.sinor.ru")
	by vger.kernel.org with ESMTP id <S266064AbSLCFDK>;
	Tue, 3 Dec 2002 00:03:10 -0500
Date: Tue, 3 Dec 2002 11:07:28 +0600
From: "Andrey R. Urazov" <coola@ngs.ru>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: a bug in autofs
Message-ID: <20021203050728.GA1179@ktulu>
References: <20021201071612.GA936@ktulu> <1038799532.15370.301.camel@ixodes.goop.org> <20021202075725.GC1459@ktulu> <1038818346.3253.17.camel@ixodes.goop.org> <20021202151730.GB885@ktulu> <1038847726.2560.51.camel@ixodes.goop.org> <20021202175040.GA857@ktulu> <1038854145.2560.79.camel@ixodes.goop.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
In-Reply-To: <1038854145.2560.79.camel@ixodes.goop.org>
User-Agent: Mutt/1.4i
X-PGP-public-key: pub 1024D/02B49FF2
X-PGP-fingerprint: A1CE D50E 0CF3 C0EF BA35  CBEC 87D7 4A2B 02B4 9FF2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 02, 2002 at 10:35:45AM -0800, Jeremy Fitzhardinge wrote:
> Well, if you post the decoded backtrace, I'm sure it will help the IDE
> developers find your problem.  It looks to me like you've got
> something strange going on with IDE and/or ide-scsi.
I've just reproduced the crash and in the call trace of 12 entries only
to corresponded to a function in the System.map, the other were pointing
something in between function entries in the System.map. The one that
pointed exactly to a function entry point pointed to `do_page_fault'.


Best regards,
  Andrey Urazov
--=20
e-credibility: the non-guaranteeable likelihood that the electronic data=20
you're seeing is genuine rather than somebody's made-up crap.
- Karl Lehenbauer
--
mardi 03 d=E9cembre, 2002, 11:02:52 +0600 - Andrey R. Urazov (mailto:coola@=
ngs.ru)


--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE97DwPh9dKKwK0n/IRAnjuAJ9UDyd131WXecuDdmc15jqj3fUwogCgw0VU
jRK5CO3EeKh5hNI3LV9ik2s=
=+UaS
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
