Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261311AbVGYPDn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261311AbVGYPDn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 11:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261308AbVGYPDn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 11:03:43 -0400
Received: from h80ad251a.async.vt.edu ([128.173.37.26]:17593 "EHLO
	h80ad251a.async.vt.edu") by vger.kernel.org with ESMTP
	id S261286AbVGYPDm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 11:03:42 -0400
Message-Id: <200507251503.j6PF328a007465@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: VASM <vasm85@gmail.com>
Cc: Nix <nix@esperi.org.uk>, Jesper Juhl <jesper.juhl@gmail.com>,
       gbakos@cfa.harvard.edu, linux-kernel@vger.kernel.org
Subject: Re: kernel page size explanation 
In-Reply-To: Your message of "Mon, 25 Jul 2005 19:12:47 +0530."
             <4536bb73050725064273cdbb50@mail.gmail.com> 
From: Valdis.Kletnieks@vt.edu
References: <Pine.SOL.4.58.0507211925170.28852@titan.cfa.harvard.edu> <9a87484905072118207a85970e@mail.gmail.com> <87d5p8aw4h.fsf@amaterasu.srvr.nix> <4536bb7305072412011fbeaf59@mail.gmail.com> <878xzvc2qs.fsf@amaterasu.srvr.nix>
            <4536bb73050725064273cdbb50@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1122303780_2774P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 25 Jul 2005 11:03:00 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1122303780_2774P
Content-Type: text/plain; charset=us-ascii

On Mon, 25 Jul 2005 19:12:47 +0530, VASM said:
> are there any specific reasons for not using large page size for
> userspace processes

Assume you can use 4K or 4M page sizes.  Compute the total memory usage
for a system that has 50 processes running, each 1556K in size....


--==_Exmh_1122303780_2774P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFC5P8kcC3lWbTT17ARAidLAKDC5M753O7o5lRuptBWQq6VtnyBSACfVr0j
CyuP9MLUouzULrIlSv7PMLg=
=B51f
-----END PGP SIGNATURE-----

--==_Exmh_1122303780_2774P--
