Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316397AbSEOPNj>; Wed, 15 May 2002 11:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316400AbSEOPNi>; Wed, 15 May 2002 11:13:38 -0400
Received: from mx1.redhat.com ([66.187.233.31]:65296 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id <S316397AbSEOPNh>;
	Wed, 15 May 2002 11:13:37 -0400
Date: Wed, 15 May 2002 10:13:29 -0500
From: Tommy Reynolds <reynolds@redhat.com>
To: "Joe deBlaquiere" <jadb@redhat.com>
Cc: Jack.Bloch@icn.siemens.com, linux-kernel@vger.kernel.org
Subject: Re: Device driver question
Message-Id: <20020515101329.6e609f33.reynolds@redhat.com>
In-Reply-To: <1021474990.1450.56.camel@uberdog>
Organization: Red Hat Software, Inc. / Embedded Development
X-Mailer: Sylpheed version 0.7.6cvs4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: Nr)Jjr<W18$]W/d|XHLW^SD-p`}1dn36lQW,d\ZWA<OQ/XI;UrUc3hmj)pX]@n%_4n{Zsg$ t1p@38D[d"JHj~~JSE_udbw@N4Bu/@w(cY^04u#JmXEUCd]l1$;K|zeo!c.#0In"/d.y*U~/_c7lIl 5{0^<~0pk_ET.]:MP_Aq)D@1AIQf.juXKc2u[2pSqNSi3IpsmZc\ep9!XTmHwx
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="=.a1bh0ytlOWXb2B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.a1bh0ytlOWXb2B
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Uttered "Joe deBlaquiere" <jadb@redhat.com>, spoke thus:

>  How about just write a driver that responds to the interrupt, and write
>  a program that does a blocking read from the driver. The driver read
>  routine stuff the program on a wait queue... until... interrupt occurs,
>  wake up the program, program does exec(/sbin/halt) ?

Yup, that could work too. (Classic see-interrupt-from-user-space solution)  It
all depends on how urgently his embedded system needs to reboot.  Choices abound
for rebooting: the hard part is not rebooting until you want to reboot.
--=.a1bh0ytlOWXb2B
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iEYEARECAAYFAjziex8ACgkQWEn3bOOMcurNiACgqOhb4MAibiALiXSAR49haOQa
XmIAoJIaNFb6zMN8OUUtcOR0k9un0J4m
=3lzP
-----END PGP SIGNATURE-----

--=.a1bh0ytlOWXb2B--

