Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263328AbTJUWx1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 18:53:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263345AbTJUWx1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 18:53:27 -0400
Received: from rumms.uni-mannheim.de ([134.155.50.52]:26847 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S263328AbTJUWxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 18:53:24 -0400
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: James Simmons <jsimmons@infradead.org>
Subject: Re: 2.6.0-test8-mm1
Date: Wed, 22 Oct 2003 00:53:08 +0200
User-Agent: KMail/1.5.9
Cc: Helge Hafting <helgehaf@aitel.hist.no>, Andrew Morton <akpm@osdl.org>,
       <Valdis.Kletnieks@vt.edu>, <linux-kernel@vger.kernel.org>,
       <linux-mm@kvack.org>
References: <Pine.LNX.4.44.0310212141290.32738-100000@phoenix.infradead.org>
In-Reply-To: <Pine.LNX.4.44.0310212141290.32738-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_Zjbl/DXgFz8jHL1";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200310220053.13547.schlicht@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_Zjbl/DXgFz8jHL1
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 21 October 2003 22:42, James Simmons wrote:
> > > This patch was fine.  2.6.0-test8 with this patch booted and
> > > looked no different from plain 2.6.0-test8.  I am using it for
> > > writing this.  The problems must be in mm1 somehow.
> > >
> > > Helge Hafting
>
> Yeah!!!
>
> > Well here I've got same problems for -test8 + fbdev-patch as with
> > -test8-mm1. I've compiled the kernel with most DEBUG_* options enabled
> > (all but DEBUG_INFO and KGDB) and see the same cursor and image
> > corruption as with -mm1 and the same options enabled.
> >
> > Should I try compiling this kernel without the DEBUG_* options and watch
> > if I get the invalidate_list Oops again?
>
> Yes. I'm using vesafb and I have no problems. I liek to see what the
> problem really is.

OK, without any of the DEBUG_* options enabled the kernel SEEMS to work wit=
h=20
no problems. But I don't know how I can assure there actually is no memory=
=20
corruption...

=46or me the big question stays why enabling the DEBUG_* options results in=
 a=20
corrupt cursor and the false dots on the top of each row... (with both=20
kernels)

And, of course, why enabling vesafb in -mm1 leads to memory corruption. (as=
=20
Vladis already mentioned, the same binary works if vesafb is not enabled vi=
a=20
the 'vga=3Dxxx' boot option).

Regards
   Thomas

--Boundary-02=_Zjbl/DXgFz8jHL1
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA/lbjZYAiN+WRIZzQRAvGRAKCuUBwbluco5bce9zPQBSbC8jLtrgCg3XkE
nHSZ8YP/Y/UZPkjRbiV4lNY=
=0KWD
-----END PGP SIGNATURE-----

--Boundary-02=_Zjbl/DXgFz8jHL1--
