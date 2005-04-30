Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261244AbVD3WIn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261244AbVD3WIn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 18:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261445AbVD3WIn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 18:08:43 -0400
Received: from h80ad2502.async.vt.edu ([128.173.37.2]:51474 "EHLO
	h80ad2502.async.vt.edu") by vger.kernel.org with ESMTP
	id S261244AbVD3WIc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 18:08:32 -0400
Message-Id: <200504302208.j3UM8BCP002975@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Ed Tomlinson <tomlins@cam.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc3-mm1 
In-Reply-To: Your message of "Sat, 30 Apr 2005 08:27:43 EDT."
             <200504300827.44359.tomlins@cam.org> 
From: Valdis.Kletnieks@vt.edu
References: <20050429231653.32d2f091.akpm@osdl.org>
            <200504300827.44359.tomlins@cam.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1114898890_4892P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sat, 30 Apr 2005 18:08:10 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1114898890_4892P
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Sat, 30 Apr 2005 08:27:43 EDT, Ed Tomlinson said:

> If we stick with git it might make sense not to include a linux-patch. =
 cogito
> is quite fast to export using a commit id.  Suspect some bandwidth coul=
d be=20
> saved if you just stated the commit id that you based the mm patch on.

I suspect that the majority of people who build -mm kernels build -mm ker=
nels
because they *weren't* using BK to pull the trees they were interested in=
.

Currently I can pull the pieces needed for a -mm kernel over a 56K modem
without *too* much pain, which means it's something I can easily do in an=

evening.   What would be the additional disk space requirements to store =
enough
of a git tree so I can pull the corresponding linus.patch myself, and how=
 long
would it take to do at 56K?  Also, what's the comparative CPU/bandwidth h=
it
on the server end for me to download the additional data if it's bundled
into Andrew's patch, versus me doing a 'git update' or whatever the comma=
nd is?

I'm suspecting that it's less strain overall to just include the 180K or =
so that
the bzip'ed linus.patch takes than to make everybody pull the data needed=
 to
create their own linus.patch


--==_Exmh_1114898890_4892P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCdAHKcC3lWbTT17ARAu+KAKC673Ah4AyQQIEfC9zBISAjoP9RbgCbBVVt
ZtuKsKGIx6SyeNKQzQ3O/kQ=
=FI04
-----END PGP SIGNATURE-----

--==_Exmh_1114898890_4892P--
