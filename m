Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265994AbUBJSHl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 13:07:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265935AbUBJSET
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 13:04:19 -0500
Received: from turing-police.cirt.vt.edu ([128.173.54.129]:58754 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S266031AbUBJSDu (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 13:03:50 -0500
Message-Id: <200402101803.i1AI3imE010142@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: hpa@zytor.com (H. Peter Anvin)
Cc: linux-kernel@vger.kernel.org
Subject: Re: Very preliminary dynamic pty patch 
In-Reply-To: Your message of "Tue, 10 Feb 2004 17:25:36 GMT."
             <c0b46g$ulg$1@terminus.zytor.com> 
From: Valdis.Kletnieks@vt.edu
References: <c0b46g$ulg$1@terminus.zytor.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1070830864P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 10 Feb 2004 13:03:44 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1070830864P
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Tue, 10 Feb 2004 17:25:36 GMT, hpa@zytor.com (H. Peter Anvin)  said:
> Try it out and send me the oopsen :)
> =

> ftp://ftp.kernel.org/pub/linux/kernel/people/hpa/dynpty-test-1.patch

Eyeball checked only, 2 comments:

1) Will the embedded crew object to the removal of CONFIG_UNIX98_PTYS?
I can see some systems that don't want either SysV or BSD pty's, unless
they're deeply ingrained in some way I don't understand so you can't have=

a system with exactly one tty on a DB-9 serial port for a console without=
 =

having them present too.

2) How much extra code to axe the BSD-style PTYs?

--==_Exmh_-1070830864P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAKR0AcC3lWbTT17ARAvUsAKDYg+fcz1nCTOuFBaJt0wO8oUdR7ACgyh58
92aqGK2Ak5IUcEVvagKHyM4=
=IdOq
-----END PGP SIGNATURE-----

--==_Exmh_-1070830864P--
