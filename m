Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261789AbUKCRgJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261789AbUKCRgJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 12:36:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261788AbUKCRgI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 12:36:08 -0500
Received: from ctb-mesg1.saix.net ([196.25.240.73]:46291 "EHLO
	ctb-mesg1.saix.net") by vger.kernel.org with ESMTP id S261789AbUKCR2G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 12:28:06 -0500
Subject: Re: XMMS (or some other audio player) 'hang' issues with intel8x0
	and	dmix plugin [u]
From: "Martin Schlemmer [c]" <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Clemens Schwaighofer <cs@tequila.co.jp>
Cc: Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
       Takashi Iwai <tiwai@suse.de>, alsa-user@lists.sourceforge.net
In-Reply-To: <41887C56.7090000@tequila.co.jp>
References: <1099284142.11924.17.camel@nosferatu.lan>
	 <41873A9E.3020909@tequila.co.jp> <1099446318.11924.23.camel@nosferatu.lan>
	 <41887C56.7090000@tequila.co.jp>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-SoXq9MwwUfcyauhIyjQ3"
Date: Wed, 03 Nov 2004 19:27:58 +0200
Message-Id: <1099502878.11924.48.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-SoXq9MwwUfcyauhIyjQ3
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-11-03 at 15:36 +0900, Clemens Schwaighofer wrote:
> On 11/03/2004 10:45 AM, Martin Schlemmer [c] wrote:
>=20
> > I would appreciate that.  Any workaround currently will be nice.
>=20
> attached my .asoundrc
>=20
> What I did, I halfed the buffer_size from 8K to 4K. After that it worked
> fine.
>=20

I will try this, thanks.  I had my period/buffer size the same, but the
rate I had 48000 .. maybe this could be it.

Also, I am positive that with alsa-lib-1.0.5, with/without mmap, it
would do the same, but I put it on without mmap last night, and now
about 22/24 hours later it was still playing, so it might be fixed
for non-mmap at least.

My audio controller is also an Intel (SoundMax):

-----
0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801EB/ER
(ICH5/ICH5R) AC'97 Audio Controller (rev 02)
        Subsystem: ASUSTeK Computer Inc. P4P800 Mainboard
        Flags: bus master, medium devsel, latency 0, IRQ 201
        I/O ports at e800
        I/O ports at ee80 [size=3D64]
        Memory at febff800 (32-bit, non-prefetchable) [size=3D512]
        Memory at febff400 (32-bit, non-prefetchable) [size=3D256]
        Capabilities: [50] Power Management version 2
-----

and somebody else had an intel chipset mobo with yamaha sound chip
on, so I do not know if it might be with intel chipset based ac97
sound that this issue comes to light - anybody else have an sis/nvidia
based board?


Thanks,

--=20
Martin Schlemmer


--=-SoXq9MwwUfcyauhIyjQ3
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBiRUeqburzKaJYLYRAhdhAJ97q731dAwf81jsSti8uBLdyGxsPgCfVu4R
XDFyEM8cjXPczWvufSUKVN0=
=SkAY
-----END PGP SIGNATURE-----

--=-SoXq9MwwUfcyauhIyjQ3--

