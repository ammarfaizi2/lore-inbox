Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030227AbVLFUjY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030227AbVLFUjY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 15:39:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750881AbVLFUjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 15:39:24 -0500
Received: from moutng.kundenserver.de ([212.227.126.183]:1746 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1750759AbVLFUjX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 15:39:23 -0500
From: Prakash Punnoor <prakash@punnoor.de>
To: Michael Krufky <mkrufky@gmail.com>
Subject: Re: [PATCH] b2c2: make front-ends selectable and include noob option
Date: Tue, 6 Dec 2005 21:39:16 +0100
User-Agent: KMail/1.9
Cc: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org
References: <200512062053.00711.prakash@punnoor.de> <37219a840512061220w17388551jd54c189973e23355@mail.gmail.com>
In-Reply-To: <37219a840512061220w17388551jd54c189973e23355@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart14176239.iUslbcJ5dN";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200512062139.16846.prakash@punnoor.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:cec1af1025af73746bdd9be3587eb485
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart14176239.iUslbcJ5dN
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Dienstag Dezember 6 2005 21:20 schrieb Michael Krufky:
> On 12/6/05, Prakash Punnoor <prakash@punnoor.de> wrote:
> > Hi,
> >
> > this patch probably needs some touch-up but mainly I am sking the dvb
> > guys why
> > don't they do something like this. Current situation:
> >
>
> NACK.
>
> You are going to run into some problems with this patch... For instance,
> What if the user chooses to compile the b2c2-flexcop driver in-kernel, but
> only compiles the frontend drivers as modules...  Then, the frontend
> support will be built into the flexcop driver, but the module will not yet
> be available at the time when the kernel is looking for it...

Well, I said it needed touch up. ;-) After all I didn't seriously believe i=
t=20
gets merged in current state (and yes, I didn't think about the module issu=
e,=20
but you're right , of course). But it simply didn't seem like dvb guys are=
=20
caring about the problem. I once (probably half a year ago already) mailed =
to=20
linux-dvb and got zero response. That told me everything.

Personally I won't invest more time in perfecting the patch. I just wanted =
to=20
get some attention to this problem and will use the patch privately for my=
=20
own happiness...

Thanks for your input.

=2D-=20
(=C2=B0=3D                 =3D=C2=B0)
//\ Prakash Punnoor /\\
V_/                 \_V

--nextPart14176239.iUslbcJ5dN
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDlfb0xU2n/+9+t5gRAllBAKC1yI7USJIrpu6YEJHRdWIH+XeKagCgkf9Z
S8xxX/DYbnE2mgp7aZwRneQ=
=PWy7
-----END PGP SIGNATURE-----

--nextPart14176239.iUslbcJ5dN--
