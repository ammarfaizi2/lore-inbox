Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265207AbUAUPgL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 10:36:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265442AbUAUPgL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 10:36:11 -0500
Received: from neveragain.de ([217.69.76.1]:52449 "EHLO hobbit.neveragain.de")
	by vger.kernel.org with ESMTP id S265207AbUAUPgI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 10:36:08 -0500
Date: Wed, 21 Jan 2004 16:35:51 +0100
From: Martin Loschwitz <madkiss@madkiss.org>
To: "Georg C. F. Greve" <greve@gnu.org>, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: ACPI freezes 2.6.1 on boot
Message-ID: <20040121153551.GA2615@minerva.local.lan>
References: <m3isj5a73u.fsf@reason.gnu-hamburg>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
In-Reply-To: <m3isj5a73u.fsf@reason.gnu-hamburg>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 21, 2004 at 12:12:05PM +0100, Georg C. F. Greve wrote:
> Hi all,
>=20
> I've seen the mail by Martin Loschwitz of January 1st 2004, in which
> he reported:
>=20
>  > I'm writing this mail as I'm discovering ACPI related problems on
>  > my Acer TravelMate 800LCi notebook with Linux 2.6.1-rc1-mm1.
>=20
>  > While the system boots up fine with Linux 2.6.1-rc1, with
>  > 2.6.1-rc1-mm1 it hangs while booting. The last message printed to
>  > screen is "ACPI: IRQ 9 was Edge Triggered, setting to Level
>  > Triggerd". This is fully reproducable with a Linux 2.6.0 kernel
>  > which has the ACPI20031203 patch applied.
>=20
> I'm now seeing the _exact same problem_ on an ASUS M2400N [*] with a
> Linux 2.6.1 (unpatched) kernel. The kernel freezes after printing=20
>=20
>  "ACPI: IRQ 9 was Edge Triggered, setting to Level Triggerd"=20
>=20
> (yes, the typo is in the kernel, it seems)
>=20
> I've seen no reply to his mail. Has the problem been solved or is it
> still a known bug(tm)?
>=20
> Martin? Were you successful in resolving that problem?
>=20
By now means. I, however, didn't even try to get a solution since back
then. Since the bug appeared with a patched 2.6.0 and 2.6.1-mm2, which
was one of the first patches including the new ACPI, it was clear to
me that it was ACPI related and that I would better wait for somebody
to find the root of the evil and to kill it.

I see your "Notebook vs. Linux"-story continues to be unsuccessfull,
though :(

> Regards,
> Georg
>=20
>=20
> [*] Pentium 4 M Centrino, 1.6, 512MB, Intel 855GM chipset
>=20
> --=20
> Georg C. F. Greve                                       <greve@gnu.org>
> Free Software Foundation Europe	                 (http://fsfeurope.org)
> Brave GNU World	                           (http://brave-gnu-world.org)


--=20
  .''`.   Martin Loschwitz           Debian GNU/Linux developer
 : :'  :  madkiss@madkiss.org        madkiss@debian.org
 `. `'`   http://www.madkiss.org/    people.debian.org/~madkiss/
   `-     Use Debian GNU/Linux 3.0!  See http://www.debian.org/

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFADpxXHPo+jNcUXjARAqAdAJ43zYcTwGuhmGeadf6OyntCV2OM+gCcDOKz
RasG3euXlPks7rMZdLn6B4Q=
=03Gg
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
