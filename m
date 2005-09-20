Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750728AbVITVeW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbVITVeW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 17:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750743AbVITVeW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 17:34:22 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:23481 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1750728AbVITVeV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 17:34:21 -0400
Message-Id: <200509202133.j8KLXfHL028916@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Roman I Khimov <rik@osrc.info>, reiserfs-list@namesys.com,
       Pavel Machek <pavel@suse.cz>, Hans Reiser <reiser@namesys.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, thenewme91@gmail.com,
       Christoph Hellwig <hch@infradead.org>,
       Denis Vlasenko <vda@ilport.com.ua>, chriswhite@gentoo.org,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: I request inclusion of reiser4 in the mainline kernel 
In-Reply-To: Your message of "Tue, 20 Sep 2005 17:17:13 EDT."
             <20050920211713.GB6179@thunk.org> 
From: Valdis.Kletnieks@vt.edu
References: <200509182004.j8IK4JNx012764@inti.inf.utfsm.cl> <432E5024.20709@namesys.com> <20050920075133.GB4074@elf.ucw.cz> <200509202328.28501.rik@osrc.info> <200509202015.j8KKFfjd025051@turing-police.cc.vt.edu>
            <20050920211713.GB6179@thunk.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1127252020_3303P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 20 Sep 2005 17:33:40 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1127252020_3303P
Content-Type: text/plain; charset=us-ascii

On Tue, 20 Sep 2005 17:17:13 EDT, "Theodore Ts'o" said:
>
> An exit code of 1 means that filesystem errors were corrected
> (successfully).  

Right.  The problem is that this was a *second* check, after the first one
terminated with exit code 0, 1, or 2.  Thus, it *should* have exited with 0.

The *first* check lied - if there were unfixed errors, it should have exited
with exit 4.

--==_Exmh_1127252020_3303P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFDMIA0cC3lWbTT17ARArEyAJ4rpZq27lmv2Mzt0XZMLW+8h1WuWgCfWdh6
KPWPUmAyVj9mqeWw7AUWSzY=
=wvjK
-----END PGP SIGNATURE-----

--==_Exmh_1127252020_3303P--
