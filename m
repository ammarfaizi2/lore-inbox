Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267159AbSLQV1F>; Tue, 17 Dec 2002 16:27:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267161AbSLQV1F>; Tue, 17 Dec 2002 16:27:05 -0500
Received: from lennier.cc.vt.edu ([198.82.162.213]:11532 "EHLO
	lennier.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S267159AbSLQV1C>; Tue, 17 Dec 2002 16:27:02 -0500
Subject: Re: 2.5.52 compile error
From: "Richard B. Tilley " "(Brad)" <rtilley@vt.edu>
To: Steven Cole <elenstev@mesatop.com>
Cc: Bob Miller <rem@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1040160551.16547.27.camel@spc9.esa.lanl.gov>
References: <3E058049@zathras> <20021217211618.GB1069@doc.pdx.osdl.net> 
	<1040160551.16547.27.camel@spc9.esa.lanl.gov>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-T0sQoN3CTx9dbEL8xACT"
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 17 Dec 2002 16:34:33 -0500
Message-Id: <1040160873.17544.24.camel@oubop4.bursar.vt.edu>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-T0sQoN3CTx9dbEL8xACT
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Yes, my fingers need a keyboard. You are a very intelligent person to
understand this. May your knowledge rub off onto me.

All of these options are modules in my config file, *must* they be built
into the kernel in order to compile?

On Tue, 2002-12-17 at 16:29, Steven Cole wrote:
> On Tue, 2002-12-17 at 14:16, Bob Miller wrote:
> > On Tue, Dec 17, 2002 at 03:57:01PM -0500, rtilley wrote:
> > > Using RH's default *i686.config to build a vanilla 2.5.52 kernel. It =
keeps=20
> > > returning this error on 2 totally different x86 PCs:
> > >=20
> > >=20
> > > drivers/built-in.o: In function `kd_nosound':
> > > drivers/built-in.o(.text+0x1883f): undefined reference to `input_even=
t'
> [more errors snipped]
> > >=20
> > > Where is the fix for this?
> > >=20
> > At your finger tips ;-).  Turn on CONFIG_INPUT via "Input device suppor=
t"
> > off the main page.
>=20
> And if you want to use your keyboard or mouse, something similar to the
> following may be helpful, depending on your system.
>=20
> CONFIG_INPUT_MOUSEDEV=3Dy
> CONFIG_INPUT_MOUSEDEV_PSAUX=3Dy
> CONFIG_SERIO=3Dy
> CONFIG_SERIO_I8042=3Dy
> CONFIG_INPUT_KEYBOARD=3Dy
> CONFIG_KEYBOARD_ATKBD=3Dy
> CONFIG_INPUT_MOUSE=3Dy
> CONFIG_MOUSE_PS2=3Dy
> CONFIG_INPUT_MISC=3Dy
>=20
> Steven


--=-T0sQoN3CTx9dbEL8xACT
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA9/5hpPJE6j+LlAWERAi3yAKDaR2x43vtcSXO4ws6L9cCVtBfy1wCeOyED
kbfCCkqV/G4vAfOSl0NgmHo=
=VjuC
-----END PGP SIGNATURE-----

--=-T0sQoN3CTx9dbEL8xACT--

