Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291402AbSAaXWH>; Thu, 31 Jan 2002 18:22:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291407AbSAaXV6>; Thu, 31 Jan 2002 18:21:58 -0500
Received: from ziggy.one-eyed-alien.net ([64.169.228.100]:41989 "EHLO
	ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S291402AbSAaXVo>; Thu, 31 Jan 2002 18:21:44 -0500
Date: Thu, 31 Jan 2002 15:21:42 -0800
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Greg Boyce <gboyce@rakis.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Machines misreporting Bogomips
Message-ID: <20020131152142.B20618@one-eyed-alien.net>
Mail-Followup-To: Greg Boyce <gboyce@rakis.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.42.0201311747560.24180-100000@egg>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="xXmbgvnjoT4axfJE"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.42.0201311747560.24180-100000@egg>; from gboyce@rakis.net on Thu, Jan 31, 2002 at 05:55:57PM -0500
Organization: One Eyed Alien Networks
X-Copyright: (C) 2002 Matthew Dharm, all rights reserved.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--xXmbgvnjoT4axfJE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I don't know if this will help much, but I have seen that type of
performance drop on systems when the entire cache is disabled.

Matt

On Thu, Jan 31, 2002 at 05:55:57PM -0500, Greg Boyce wrote:
> kernel folk,
>=20
> I've got a strange issue that I've been struggling to find the solution to
> for some time now.
>=20
> I work in a group that assists in the managing of large numbers of
> deployed linux boxes running variants of the 2.2 kernel on them.  The
> machines themselves are all pretty standard.  There are slight variances
> on vendors, cpu speeds, etc., but they're all running from the same
> motherboards.
>=20
> Every once in a while we come across single machines which are running a
> lot slower than they should be, and are misreporting their speed in
> bogomips under /proc/cpuinfo.  Reinstalling the OS and changing versions
> of the kernel don't appear to affect the machines themselves at all.
>=20
> I was wondering if anyone would be able to provide me with a starting
> point to hunt this down.  The only solution we had found in the past was
> to replace the machines, but some of them are located out of the country
> and that would be expensive.
>=20
> Here is the output from /proc/cpuinfo for machines.  The first machine is
> normal, the second is affected by this bug.  They're both running the same
> hardware, although the first machine's CPU is 650mhz instead of 500mhz.
>=20
> Machine 1:
> processor	: 0
> vendor_id	: GenuineIntel
> cpu family	: 6
> model		: 8
> model name	: Pentium III (Coppermine)
> stepping	: 3
> cpu MHz		: 645.676332
> cache size	: 0 KB
> fdiv_bug	: no
> hlt_bug		: no
> sep_bug		: no
> f00f_bug	: no
> coma_bug	: no
> fpu		: yes
> fpu_exception	: yes
> cpuid level	: 3
> wp		: yes
> flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
> cmov pat pse36 psn mmx osfxsr kni
> bogomips	: 643.89
>=20
> Machine 2:
> processor	: 0
> vendor_id	: GenuineIntel
> cpu family	: 6
> model		: 7
> model name	: Pentium III (Katmai)
> stepping	: 3
> cpu MHz		: 496.677416
> cache size	: 512 KB
> fdiv_bug	: no
> hlt_bug		: no
> sep_bug		: no
> f00f_bug	: no
> coma_bug	: no
> fpu		: yes
> fpu_exception	: yes
> cpuid level	: 2
> wp		: yes
> flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
> cmov pat pse36 mmx osfxsr kni
> bogomips	: 4.06
>=20
> Let me know if there's anything else I can provide to help with the
> diagnosis.  The machine itself is an IBM Netfinity 4000R.
>=20
> --
> Gregory Boyce
>=20
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

G:   Baaap booop BAHHHP.
Mir: 9600 Baud?
Mik: No, no!  9600 goes baap booop, not booop bahhhp!
					-- Greg, Miranda and Mike
User Friendly, 12/31/1998

--xXmbgvnjoT4axfJE
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8WdGGz64nssGU+ykRAg8qAJ9Zny2TK3Xu+L2tFAyHWwORtln0LACeMji3
FgCRXCmgDZCzZinkkr9wL3Q=
=+NGU
-----END PGP SIGNATURE-----

--xXmbgvnjoT4axfJE--
