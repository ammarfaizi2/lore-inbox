Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267024AbSLQVTs>; Tue, 17 Dec 2002 16:19:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267027AbSLQVTs>; Tue, 17 Dec 2002 16:19:48 -0500
Received: from lennier.cc.vt.edu ([198.82.162.213]:11277 "EHLO
	lennier.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S267024AbSLQVTr>; Tue, 17 Dec 2002 16:19:47 -0500
Subject: Re: 2.5.52 compile error
From: "Richard B. Tilley " "(Brad)" <rtilley@vt.edu>
To: Bob Miller <rem@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20021217211618.GB1069@doc.pdx.osdl.net>
References: <3E058049@zathras>  <20021217211618.GB1069@doc.pdx.osdl.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-7l5JPXvBkP4DAXMukiBX"
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 17 Dec 2002 16:27:40 -0500
Message-Id: <1040160460.17548.20.camel@oubop4.bursar.vt.edu>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-7l5JPXvBkP4DAXMukiBX
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

CONFIG_INPUT is modular, do I *have* to build it in inorder to compile?

On Tue, 2002-12-17 at 16:16, Bob Miller wrote:
> On Tue, Dec 17, 2002 at 03:57:01PM -0500, rtilley wrote:
> > Using RH's default *i686.config to build a vanilla 2.5.52 kernel. It ke=
eps=20
> > returning this error on 2 totally different x86 PCs:
> >=20
> >=20
> > drivers/built-in.o: In function `kd_nosound':
> > drivers/built-in.o(.text+0x1883f): undefined reference to `input_event'
> > drivers/built-in.o(.text+0x18861): undefined reference to `input_event'
> > drivers/built-in.o: In function `kd_mksound':
> > drivers/built-in.o(.text+0x1890a): undefined reference to `input_event'
> > drivers/built-in.o: In function `kbd_bh':
> > drivers/built-in.o(.text+0x197a2): undefined reference to `input_event'
> > drivers/built-in.o(.text+0x197c1): undefined reference to `input_event'
> > drivers/built-in.o(.text+0x197e0): more undefined references to `input_=
event'=20
> > follow
> > drivers/built-in.o: In function `kbd_connect':
> > drivers/built-in.o(.text+0x19d54): undefined reference to `input_open_d=
evice'
> > drivers/built-in.o: In function `kbd_disconnect':
> > drivers/built-in.o(.text+0x19d7f): undefined reference to `input_close_=
device'
> > drivers/built-in.o: In function `kbd_init':
> > drivers/built-in.o(.init.text+0x12c1): undefined reference to=20
> > `input_register_handler'
> > make: *** [.tmp_vmlinux1] Error 1
> >=20
> >=20
> > Where is the fix for this?
> >=20
> At your finger tips ;-).  Turn on CONFIG_INPUT via "Input device support"
> off the main page.
>=20
> --=20
> Bob Miller					Email: rem@osdl.org
> Open Source Development Lab			Phone: 503.626.2455 Ext. 17
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


--=-7l5JPXvBkP4DAXMukiBX
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA9/5bMPJE6j+LlAWERAhWwAJ9n2gOS+mOgYxTBxqmmyEU4Yl/nYQCePjfS
aOnCONJdgrC0GV2g7osVRik=
=luXy
-----END PGP SIGNATURE-----

--=-7l5JPXvBkP4DAXMukiBX--

