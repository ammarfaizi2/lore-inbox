Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751234AbWGUWHy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234AbWGUWHy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 18:07:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751235AbWGUWHy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 18:07:54 -0400
Received: from damned.travellingkiwi.com ([81.6.239.220]:23594 "EHLO
	damned.travellingkiwi.com") by vger.kernel.org with ESMTP
	id S1751234AbWGUWHx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 18:07:53 -0400
From: Hamish <hamish@travellingkiwi.com>
Organization: TravellingKiwi Systems
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: SATA hangs...
Date: Fri, 21 Jul 2006 23:07:48 +0100
User-Agent: KMail/1.9.1
References: <200606232134.42231.hamish@travellingkiwi.com>
In-Reply-To: <200606232134.42231.hamish@travellingkiwi.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1451599.08TtEZn5QX";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200607212307.51374.hamish@travellingkiwi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1451599.08TtEZn5QX
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 23 June 2006 21:34, you wrote:
> Hi.
>
> I'm having problems with a SATA drive on an ASUS A8V deluxe
> motherboard under kernel 2.6.17... In fact it's happened under
> every (Vanilla) kernel I've ever run on this server (Back to 2.6.14).
> (It's just over a year old. It didn't used to experience the same load
> as it does now, so I'm currently assuming it's load related...
>

I think I found it...

I upgraded to a new MB, amd64 X2 4200 and a new Gfx card. The problem got m=
uch=20
much worse. Then it started to hang on boot in the BIOS checks for HD's...=
=20
Turns out it was the cable... Unplugging the drive from the MB fixed it,=20
plugging it back in worked for a bit & died again.

I changed the cable and haven't had a problem for a week now.

TIA
  Hamish.

--nextPart1451599.08TtEZn5QX
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBEwVA3wRzSEdQQDooRAm9/AKDqU+zDwIc5X3LyQrBRQ+wWx8ImHwCg5usP
U+I37Yi6UNFEmihZ6lxIaE4=
=cXm8
-----END PGP SIGNATURE-----

--nextPart1451599.08TtEZn5QX--
