Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261380AbTDHNVO (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 09:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261382AbTDHNVO (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 09:21:14 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:43665 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261380AbTDHNVN (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 09:21:13 -0400
Subject: Re: [LTP] Re: Same syscall is defined to different numbers on 3
	different archs(was Re: Makefile  issue)
From: Paul Larson <plars@linuxtestproject.org>
To: Werner Almesberger <wa@almesberger.net>
Cc: Andi Kleen <ak@suse.de>, Robert Williamson <robbiew@us.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>, aniruddha.marathe@wipro.com,
       ltp-list@lists.sourceforge.net
In-Reply-To: <20030407232302.D19288@almesberger.net>
References: <OF51DE965A.FDCB6DBE-ON85256D01.005201B1-86256D01.005610CF@pok.ibm.com.suse.
	lists.linux.kernel> <p73vfxqxpz4.fsf@oldwotan.suse.de> 
	<20030407232302.D19288@almesberger.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-bNfi/CyAaWVOSNxmEOXl"
X-Mailer: Ximian Evolution 1.0.5 
Date: 08 Apr 2003 08:30:50 -0500
Message-Id: <1049808651.30732.113.camel@plars>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-bNfi/CyAaWVOSNxmEOXl
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2003-04-07 at 21:23, Werner Almesberger wrote:
> Andi Kleen wrote:
> > #include </path/to/kernel/source/include/asm-<arch>/unistd.h>
> > (you need the version in the kernel source because many glibc packagers
> > in their infinite wisdom use an old outdated copy of asm/ usually from
> > the last stable kernel only)=20
>=20
> Do we need a /proc/syscalls ? :-)
I don't think so.  Apps should be accessing things through libraries
anyway.  The only reason we don't in some cases like this is that it's
new and not in libs on any distro yet.  Besides, I don't think having a
/proc/syscalls would be any better than having to do ifdefs or use
kernel headers.

-Paul Larson


--=-bNfi/CyAaWVOSNxmEOXl
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEABECAAYFAj6SzwoACgkQbkpggQiFDqfjYACdHOCcUOjf0hlpzcpQTTxAz6vl
e8kAnjtt93zNjRoNU+JjyFuXe5v6zNIP
=gVPp
-----END PGP SIGNATURE-----

--=-bNfi/CyAaWVOSNxmEOXl--

