Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261332AbTCGBj6>; Thu, 6 Mar 2003 20:39:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261258AbTCGBj6>; Thu, 6 Mar 2003 20:39:58 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:1249 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261332AbTCGBj5>;
	Thu, 6 Mar 2003 20:39:57 -0500
Subject: Re: [RFC][PATCH] linux-2.5.64_monotonic-clock_A0
From: john stultz <johnstul@us.ibm.com>
To: george anzinger <george@mvista.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Joel.Becker@oracle.com,
       "Martin J. Bligh" <mbligh@aracnet.com>, wim.coekaerts@oracle.com
In-Reply-To: <3E67F6C6.6090708@mvista.com>
References: <1046996126.16608.509.camel@w-jstultz2.beaverton.ibm.com>
	 <3E67F6C6.6090708@mvista.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-41A+Wa9qKiwXi65cT18W"
Organization: 
Message-Id: <1047001687.16614.522.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 06 Mar 2003 17:48:07 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-41A+Wa9qKiwXi65cT18W
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2003-03-06 at 17:32, george anzinger wrote:
> IMHO I solved this problem in the high-res timers patch.  I have=20
> posted the core of the conversion stuff as a path (last night at=20
> 23:24) with this subject "[PATCH] Functions to do easy scaled math."=20
> It consists of a header file containing a handful of inline asm code=20
> to do the messy stuff (i.e. the stuff C can't do due to standard=20
> restrictions).  I also provided an asm-generic version to fill the gap=20
> on other archs.  Oh, and there is even a text file to explain it all.

Well... that's absurdly convenient. :)

I'll start looking at your code immediately.=20

thanks!
-john



--=-41A+Wa9qKiwXi65cT18W
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA+Z/pXMDAZ/OmgHwwRAo+lAJ9d5NXeoFao5YyHXOwLfCTynUSt7QCfTkkL
QSnbqMHJqnyv25m+8SMMtsQ=
=lh8b
-----END PGP SIGNATURE-----

--=-41A+Wa9qKiwXi65cT18W--

