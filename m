Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263876AbUFBTd1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263876AbUFBTd1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 15:33:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263869AbUFBTd1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 15:33:27 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:38819 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263876AbUFBTdV (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 15:33:21 -0400
Message-Id: <200406021933.i52JXKDt030388@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] explicitly mark recursion count 
In-Reply-To: Your message of "Wed, 02 Jun 2004 20:58:32 +0200."
             <20040602185832.GA2874@wohnheim.fh-wedel.de> 
From: Valdis.Kletnieks@vt.edu
References: <200406011929.i51JTjGO006174@eeyore.valparaiso.cl> <Pine.LNX.4.58.0406011255070.14095@ppc970.osdl.org> <20040602131623.GA23017@wohnheim.fh-wedel.de> <Pine.LNX.4.58.0406020712180.3403@ppc970.osdl.org> <Pine.LNX.4.58.0406020724040.22204@bigblue.dev.mdolabs.com> <20040602182019.GC30427@wohnheim.fh-wedel.de> <Pine.LNX.4.58.0406021124310.22742@bigblue.dev.mdolabs.com>
            <20040602185832.GA2874@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1402717424P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 02 Jun 2004 15:33:20 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1402717424P
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Wed, 02 Jun 2004 20:58:32 +0200, =3D?iso-8859-1?Q?J=3DF6rn?=3D Engel s=
aid:

> Note the "in the most general case" part.  You can get things right if
> you make some assumptions and those assumptions are actually valid.
> In my case the assumptions are:
> 1. all relevant function pointers are stuffed into some struct and
> 2. no casts are used to disguise function pointer as something else.

That seems to be reasonable.  And if we're aliasing, or shadowing, or cas=
ting
function pointers to something else, or using a union to overlay it, that=
's
just a time bomb waiting to explode.  At the very least, such code should=

require a large "Danger! Here be large and nasty dragons!" marker.


--==_Exmh_1402717424P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAviuAcC3lWbTT17ARAunoAKCQW84EF7ve5WTdV2vYcNMEqWylJgCdFknv
MqsZA20rYNIDreW8vAknafU=
=M2i2
-----END PGP SIGNATURE-----

--==_Exmh_1402717424P--
