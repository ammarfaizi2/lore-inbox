Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265176AbUAPRVx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 12:21:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265209AbUAPRVx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 12:21:53 -0500
Received: from ce.fis.unam.mx ([132.248.33.1]:16021 "EHLO ce.fis.unam.mx")
	by vger.kernel.org with ESMTP id S265176AbUAPRVs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 12:21:48 -0500
Subject: Re: True story: "gconfig" removed root folder...
From: Max Valdez <maxvalde@fis.unam.mx>
To: Doug McNaught <doug@mcnaught.org>
Cc: Roman Zippel <zippel@linux-m68k.org>,
       Ozan Eren Bilgen <oebilgen@uekae.tubitak.gov.tr>,
       kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <87ptdl2q7l.fsf@asmodeus.mcnaught.org>
References: <1074177405.3131.10.camel@oebilgen>
	 <Pine.LNX.4.58.0401151558590.27223@serv>
	 <87ptdl2q7l.fsf@asmodeus.mcnaught.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-PpR5SThzo3BKrhsEqth9"
Message-Id: <1074273646.12093.3.camel@garaged.homeip.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 16 Jan 2004 11:20:46 -0600
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-PpR5SThzo3BKrhsEqth9
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I rather have my /root dir removed (nothing there), than my user home,
that would be very bad for me

Max

On Thu, 2004-01-15 at 09:20, Doug McNaught wrote:
> Roman Zippel <zippel@linux-m68k.org> writes:
>=20
> > On Thu, 15 Jan 2004, Ozan Eren Bilgen wrote:
> >
> >> Today I downloaded 2.6.1 kernel and tried to configure it with "make
> >> gconfig". After all changes I selected "Save As" and clicked "/root"
> >> folder to save in. Then I clicked "OK", without giving a file name. I
> >> expected that it opens root folder and lists contents. But this magic
> >> configurator removed (rm -Rf) my root folder and created a file named
> >> "root". It was a terrible experience!..
> >
> > I only did a quick check with menuconfig. Are you sure it's really
> > removed? It should still be there as "/root.old".
> > I probably should change the behaviour of the save routine to behave
> > differently for directories as argument, but it doesn't remove it.
> > (Changing gconfig to only accept files in the save request would probab=
ly
> > be nice too...)
>=20
> The real lesson here is "don't compile your kernel as root".  There's
> no need to do so.
>=20
> -Doug
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
--=20
Linux garaged 2.6.1-mm1 #3 SMP Sat Jan 10 13:18:40 CST 2004 i686 Pentium II=
I (Coppermine) GenuineIntel GNU/Linux
-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GS/S d- s: a-29 C++(+++) ULAHI+++ P+ L++>+++ E--- W++ N* o-- K- w++++ O- M-=
- V-- PS+ PE Y-- PGP++ t- 5- X+ R tv++ b+ DI+++ D- G++ e++ h+ r+ z**
------END GEEK CODE BLOCK------
gpg-key: http://garaged.homeip.net/gpg-key.txt

--=-PpR5SThzo3BKrhsEqth9
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBACB1tNNkpVEFxW78RArnTAJ0fGDU0+isT3OHo1fKN6WrpltZ/aACgpcdN
765JCIRUF4c8kvk/4s2auUM=
=w/YX
-----END PGP SIGNATURE-----

--=-PpR5SThzo3BKrhsEqth9--

