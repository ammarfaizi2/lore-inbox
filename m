Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262468AbUEFPSj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262468AbUEFPSj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 11:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262503AbUEFPSj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 11:18:39 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:1667 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S262468AbUEFPSg (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 11:18:36 -0400
Message-Id: <200405061518.i46FIAY2016476@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Dominik Karall <dominik.karall@gmx.net>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.6-rc3-mm2 (4KSTACK) 
In-Reply-To: Your message of "Wed, 05 May 2004 23:51:36 +0200."
             <20040505215136.GA8070@wohnheim.fh-wedel.de> 
From: Valdis.Kletnieks@vt.edu
References: <20040505013135.7689e38d.akpm@osdl.org> <200405051312.30626.dominik.karall@gmx.net> <200405051822.i45IM2uT018573@turing-police.cc.vt.edu>
            <20040505215136.GA8070@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_943711326P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 06 May 2004 11:18:10 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_943711326P
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Wed, 05 May 2004 23:51:36 +0200, =3D?iso-8859-1?Q?J=3DF6rn?=3D Engel s=
aid:

> I disagree.  -mm is the testing ground for -linus.  If this patch
> would only break the nvidia module, I couldn't care less.

OK.. I need to clarify - I'm OK on the patch being *in -mm* precisely *be=
cause*
it's a testing ground.  Anybody who's running a -mm kernel should have th=
e
technical savvy to deal with the issue by reverting the one patch in ques=
tion,
and to recover if it eats their file system (Yes, I'm running 2.6.6-rc3-m=
m2 and
the NVidia driver as I type.  No, making it work wasn't a problem.  Yes, =
I spin
everything needed to rebuild out to CD/RW at least once a week, just beca=
use it
*is* a -mm kernel. ;)

It's a Good Idea to do this in -mm, to flush out all the binary modules t=
hat
are known to have issues with this (have we identified anybody other than=
 NVidia
that actually *has* a problem)?

It's probably a Bad Idea to push this to Linus before the vendors that ha=
ve
significant market-impact issues (again - anybody other than NVidia here?=
)
have gotten their stuff cleaned up...


--==_Exmh_943711326P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAmlcycC3lWbTT17ARArasAJ0cdJ8NvrwgekXH99ESWndfp/4foACg/E2Y
F9P6W+VnS6yBZ8ZCGvqKA/Y=
=3qqH
-----END PGP SIGNATURE-----

--==_Exmh_943711326P--
