Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965066AbWGJXhw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965066AbWGJXhw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 19:37:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965289AbWGJXhv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 19:37:51 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:47036 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S965066AbWGJXhv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 19:37:51 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Reply-To: nigel@suspend2.net
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [Suspend2-devel] Re: uswsusp history lesson
Date: Tue, 11 Jul 2006 09:37:45 +1000
User-Agent: KMail/1.9.1
Cc: suspend2-devel@lists.suspend2.net, Arjan van de Ven <arjan@infradead.org>,
       Avuton Olrich <avuton@gmail.com>, Olivier Galibert <galibert@pobox.com>,
       Jan Rychter <jan@rychter.com>, linux-kernel@vger.kernel.org,
       "Rafael J. Wysocki" <rjw@sisk.pl>, grundig <grundig@teleline.es>
References: <20060627133321.GB3019@elf.ucw.cz> <200607110749.48209.nigel@suspend2.net> <20060710232212.GD444@elf.ucw.cz>
In-Reply-To: <20060710232212.GD444@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1608371.idEdJl74iD";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200607110937.49257.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1608371.idEdJl74iD
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Tuesday 11 July 2006 09:22, Pavel Machek wrote:
> > The modularity is part of the basis of the redesign, so I couldn't easi=
ly
> > remove that. Removing the compression and encryption support is trivial
> > though (one file each, plus Makefile & Kconfig entries - no other
> > modifications needed). Userspace splash - well, just don't compile and
> > install that userspace component - suspend2 will keep working quite
> > happily without any userspace app to do a nice display (it will still do
> > printks, so you won't be flying completely blind).
>
> Lets see the patches, then.

They're basically what you already have - as I said, just ignore the=20
compression and encryption files and a couple of lines in the Makefile and=
=20
Kconfig changes. No modifications are needed to have suspend2 without a=20
userspace user interface. That's the advantage of that modular design you=20
don't like.

Regards,

Nigel
=2D-=20
See http://www.suspend2.net for Howtos, FAQs, mailing
lists, wiki and bugzilla info.

--nextPart1608371.idEdJl74iD
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEsuTNN0y+n1M3mo0RAtSaAKCNlehkaf6R7R+82yJqU7r5+/FQQwCglTDN
48f0OM0TmqoVEGCbEG0w8k4=
=Q8cT
-----END PGP SIGNATURE-----

--nextPart1608371.idEdJl74iD--
