Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261524AbSLTKnW>; Fri, 20 Dec 2002 05:43:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261582AbSLTKnW>; Fri, 20 Dec 2002 05:43:22 -0500
Received: from MailBox.iNES.RO ([80.86.96.21]:50340 "EHLO MailBox.iNES.RO")
	by vger.kernel.org with ESMTP id <S261524AbSLTKnV>;
	Fri, 20 Dec 2002 05:43:21 -0500
Subject: Re: [PATCH 2.4] : donauboe IrDA driver (resend)
From: Dumitru Ciobarcianu <Dumitru.Ciobarcianu@iNES.RO>
To: jt@hpl.hp.com
Cc: James McKenzie <james@fishsoup.dhs.org>,
       Christian Gennerat <christian.gennerat@polytechnique.org>,
       Martin Lucina <mato@kotelna.sk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20021219185630.GC6703@bougret.hpl.hp.com>
References: <20021219024632.GB1746@bougret.hpl.hp.com>
	 <1040310314.1225.9.camel@localhost.localdomain>
	 <20021219185630.GC6703@bougret.hpl.hp.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Jwg3Zc3JznJSBWY95rCV"
Organization: iNES Advertising
Message-Id: <1040381739.1084.43.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-1) 
Date: 20 Dec 2002 12:55:40 +0200
X-RAVMilter-Version: 8.4.1(snapshot 20020919) (MailBox.iNES.RO)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Jwg3Zc3JznJSBWY95rCV
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Jo, 2002-12-19 at 20:56, Jean Tourrilhes wrote:
> On Thu, Dec 19, 2002 at 05:05:16PM +0200, Dumitru Ciobarcianu wrote:
> >=20
> 	As I don't have this hardware, I fully depend on people trying
> the code to know if it works or not. This driver has been for 6 months
> in kernel 2.5.X and on my web page (and advertised on the IrDA mailing
> list), and it's only today that I get the first negative bug report.
[...]
> 	Also, would you mind sending this bug report to all three
> maintainers of the driver ? Also : would you mind sending the log
> output of the old toshoboe driver (assuming it works - does it ?).

Well, about the bug report it could be me being lazy or not having
enough time... :)

It works with the old toshoboe driver.
If I load the module with "do_probe=3D0" donauoboe loads on the first try,
thanks for the hint:


toshoboe: Using multiple tasks, version $Id: donauboe.c V2.17 jeu sep 12
08:50:20 2002 $


This is what I dug up from an old bootlog (for the old toshoboe
messages):

Linux version 2.4.18-5.64LNX (root@LNX.iNES.RO) (gcc version 3.1
20020620 (Red Hat Linux Rawhide 3.1-7)) #1 Wed Jul 10 00:30:01 EEST 2002
[..snip..]
IrDA: Registered device irda0
ToshOboe: Using single tasks, version $Id: toshoboe.c,v 1.91 1999/06/29 14:=
21:06 root Exp $
ToshOboe: setting baud to 9600
[..snip..]


Let me know if I can be of any help.

//Cioby


--=-Jwg3Zc3JznJSBWY95rCV
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+AvcrZ73E6zRGg0URAvMsAJ0WZey2uSTY89AKgq7YWXi6ZMM2LgCfXpvD
wKS/GnzjbE//ooZRGKbh0kw=
=SQLG
-----END PGP SIGNATURE-----

--=-Jwg3Zc3JznJSBWY95rCV--

