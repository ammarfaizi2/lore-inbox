Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278525AbRJZOth>; Fri, 26 Oct 2001 10:49:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278511AbRJZOtX>; Fri, 26 Oct 2001 10:49:23 -0400
Received: from smtp.digitalme.com ([193.97.97.75]:58439 "EHLO digitalme.com")
	by vger.kernel.org with ESMTP id <S278522AbRJZOtE>;
	Fri, 26 Oct 2001 10:49:04 -0400
Subject: Re: SiS/Trident 4DWave sound driver oops
From: "Trever L. Adams" <vichu@digitalme.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Stuart Young <sgy@amc.com.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Michael F. Robbins" <compumike@compumike.com>,
        Robert Love <rml@tech9.net>,
        Tachino Nobuhiro <tachino@open.nm.fujitsu.co.jp>
In-Reply-To: <E15x86H-0000GV-00@the-village.bc.nu>
In-Reply-To: <E15x86H-0000GV-00@the-village.bc.nu>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-WFx+z4IT1HNPYmPV2dVw"
X-Mailer: Evolution/0.16.99+cvs.2001.10.24.21.44 (Preview Release)
Date: 26 Oct 2001 10:47:48 -0400
Message-Id: <1004107681.962.1.camel@aurora>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-WFx+z4IT1HNPYmPV2dVw
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2001-10-26 at 10:36, Alan Cox wrote:
> > How can I find out the ac97 codec ID for this chipset (if there is one)=
 so=20
> > it can be added to the ac97_codec_ids array? From what I can tell, it's=
 as=20
> > though the codec->codec_read(codec, AC97_VENDOR_ID#) isn't returning th=
e=20
> > codec value for this system at all.
>=20
> Something is failing to bring up the AC97 codec bus and/or set it up
> properly. Can you find exactly which patch broke that for you (you'll=20
> possibly want to keep fixing the codec table as you test older ones)

Other than my system works as a module, I have the same problems.  I bet
you that 2.4.8 is the last kernel that worked for him.  (It was for
me.)  I do not know about pre-patches.  If you want, I will find that
out for my case.

Trever Adams

--=-WFx+z4IT1HNPYmPV2dVw
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA72XeUnkhkvieoi8wRAtlcAJ0UJprKUIZPVH1MnauEJjY8W2vm+ACdH/7r
s2gp8aMqyxgwYoJhTAj6n8E=
=XDKj
-----END PGP SIGNATURE-----

--=-WFx+z4IT1HNPYmPV2dVw--

