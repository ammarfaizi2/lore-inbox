Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932180AbWGGPDo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932180AbWGGPDo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 11:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932179AbWGGPDn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 11:03:43 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:47372 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S932178AbWGGPDn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 11:03:43 -0400
Message-ID: <44AE77C8.2040909@zurich.ibm.com>
Date: Fri, 07 Jul 2006 17:03:36 +0200
From: dirk husemann <hud@zurich.ibm.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060607)
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Jan Rychter <jan@rychter.com>, linux-kernel@vger.kernel.org,
       suspend2-devel@lists.suspend2.net
Subject: Re: [Suspend2-devel] Re: swsusp / suspend2 reliability
References: <200606270147.16501.ncunningham@linuxmail.org>	<20060627133321.GB3019@elf.ucw.cz> <44A14D3D.8060003@wasp.net.au>	<20060627154130.GA31351@rhlx01.fht-esslingen.de>	<20060627222234.GP29199@elf.ucw.cz>	<m2k66qzgri.fsf@tnuctip.rychter.com> <20060707135031.GA4239@ucw.cz>
In-Reply-To: <20060707135031.GA4239@ucw.cz>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig64CD8D7A7D05C2FFDBFF1E96"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig64CD8D7A7D05C2FFDBFF1E96
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Pavel Machek wrote:
> Hi!
>
>  =20
>>  Pavel> I do not think suspend2 works on more machines than in-kernel
>>  Pavel> swsusp. Problems are in drivers, and drivers are shared.
>>
>>  Pavel> That means that if you have machine where suspend2 works and
>>  Pavel> swsusp does not, please tell me. I do not think there are many=

>>  Pavel> of them.
>>
>> Accept the facts -- for some reason, there is a fairly large user base=

>> that goes to all the bother of using suspend2, which requires
>>    =20
> ...
>  =20
>> That is a fact, and all the hand waving won't change it.
>>    =20
>
> Users like suspend2 eye candy =3D> swsusp must be unreliable?
>  =20
oh, come on. that's a pretty cheap argument. let me tell you i tried
swsusp (admittedly a while ago) couldn't get it to run reliably on
several laptops, went for suspend2 --- and it worked rather well. i
certainly didn't go for suspend2 because of its "eye candy"...

this is not about eye candy, this is about pragmatism: suspend2 seems to
work on a lot more platforms than what is currently in the kernel.
> I know users that installed swsusp, decided they want progress bars,
> and went for suspend2.
>
>  =20
>> I'm tired of this. It's taking years for Linux to get reasonably worki=
ng
>> suspend facilities, which is a shame. In my opinion a large part of th=
e
>> problem is you opposing Nigel's patches. Problem is, for many people
>> Nigel's code works while yours does not.
>>    =20
>
> Nigel only submitted his code once, month or so ago, as series of 200
> or so patches. Do not blame me for _that_.
>  =20
IIRC correctly he did try earlier and was told to come back when he had
his code subdivided in little pieces.

    dirk

--=20
Dr Dirk Husemann, Pervasive Computing, IBM Research, Zurich Research Lab
	hud@zurich.ibm.com --- http://www.zurich.ibm.com/~hud/
       PGP key: http://www.zurich.ibm.com/~hud/contact/PGP
  PGP Fingerprint: 983C 48E7 0A78 A313 401C  C4AD 3C0A 278E 6431 A149
	     Email only authentic if signed with PGP key.

Appended to this email is an electronic signature attachment. You can
ignore it if your email program does not know how to verify such a
signature. If you'd like to learn more about this topic, www.gnupg.org
is a good starting point.



--------------enig64CD8D7A7D05C2FFDBFF1E96
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFErnfKPAonjmQxoUkRAgGZAJ9xYHBPIgtNCF9+A4x57uAWmBRbowCgyAbI
AvYvNkDClQZZU0Sx72NM9CI=
=jmJ0
-----END PGP SIGNATURE-----

--------------enig64CD8D7A7D05C2FFDBFF1E96--
