Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281256AbRKERnY>; Mon, 5 Nov 2001 12:43:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281257AbRKERnP>; Mon, 5 Nov 2001 12:43:15 -0500
Received: from [194.51.220.145] ([194.51.220.145]:36333 "EHLO emeraude")
	by vger.kernel.org with ESMTP id <S281256AbRKERnF>;
	Mon, 5 Nov 2001 12:43:05 -0500
Date: Mon, 5 Nov 2001 18:37:24 +0100
From: Stephane Jourdois <stephane@tuxfinder.org>
To: "Marcel J.E. Mol" <marcel@mesa.nl>
Cc: LKLM <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] SMM BIOS on Dell i8100
Message-ID: <20011105183724.A17663@emeraude.kwisatz.net>
Reply-To: stephane@tuxfinder.org
In-Reply-To: <20011105100346.A1511@emeraude.kwisatz.net> <20011105130954.A24310@joshua.mesa.nl> <20011105180124.B17203@emeraude.kwisatz.net> <20011105182029.C24310@joshua.mesa.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline
In-Reply-To: <20011105182029.C24310@joshua.mesa.nl>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.4.14-pre8
X-Send-From: emeraude
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 05, 2001 at 06:20:29PM +0100, Marcel J.E. Mol wrote:
> Thanks for the info. I really believe you :-)
> The X keycodes are indeed 129-132. I checked them using xev.
Yep, I did that just after mutt quitting. If someone could tell me
why those values... are e0 00-8f scancodes binded to 129-255 under
XFree86 ? (Not important, but just to increase my poor knowledge)

> I checked /proc/i8k while pressing the buttons next to the
> power button and they work fine.=20
Did you use my patch ? I think that Jeff Garzik would appreciate
to have a proof that it still works on i8000 ;-)

> So what's left is to tie these buttons to some function so that
> I can control the soundvolume/dvd player wherever I am i X...
Then now you should download i8kutils-1.1 from :
	http://people.debian.org/~dz/i8k/
Marcello's utils are just what you are looking for now.
in fact, i8kbuttons.c will enable volume controll, i8kmon will
display a very usefull fans status (and *YES* ! you can start them
with a click :-)).

Just a little hint for i8kbuttons :
I suggest that you run :
=2E/i8kbuttons --up "aumix -v +5" --down "aumix -v -5"

default bindings do not work, they are Massimo's aliases :-)


I use both tools since yesterday... and I watched a DVD just for
that occasion (I hate * and / in mplayer ;-)

Finally, as I told Massimo this morning, I just *love* to start my
fans just to here the little noise and see the proc temp decreasing.
(try a cat /dev/zero to increase quickly your cpu temp and enjoy !)


I think you'll appreciate those tools...
I can imagine your joy, I'm just thinking to me yesterday evening ;-)


Stephane.

--=20
 ///  Stephane Jourdois        	/"\  ASCII RIBBON CAMPAIGN \\\
(((    Ing=E9nieur d=E9veloppement 	\ /    AGAINST HTML MAIL    )))
 \\\   6, av. de la Belle Image	 X                         ///
  \\\  94440 Marolles en Brie  	/ \    +33 6 8643 3085    ///

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjvmzlQACgkQk2dpMN4A2NNAQQCeIch2/AfK5vV49Hv/4Q1AWfLw
Lk4An20PKjbUtzuzDc/OGjKON/jF61pN
=eGHV
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--
