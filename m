Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932256AbWGDPdF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932256AbWGDPdF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 11:33:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbWGDPdF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 11:33:05 -0400
Received: from pool-72-66-194-43.ronkva.east.verizon.net ([72.66.194.43]:64710
	"EHLO turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1751272AbWGDPdE (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 11:33:04 -0400
Message-Id: <200607041532.k64FWtpJ025362@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: 7eggert@gmx.de
Cc: Petr Tesarik <ptesarik@suse.cz>, Diego Calleja <diegocg@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: ext4 features
In-Reply-To: Your message of "Tue, 04 Jul 2006 14:28:05 +0200."
             <E1Fxk0v-0000gC-Qk@be1.lrz>
From: Valdis.Kletnieks@vt.edu
References: <6tVcC-1e1-79@gated-at.bofh.it> <6tVcC-1e1-81@gated-at.bofh.it> <6tVcC-1e1-83@gated-at.bofh.it> <6tWib-2Ly-7@gated-at.bofh.it> <6uDdv-7bs-3@gated-at.bofh.it> <6uDGF-7Nj-47@gated-at.bofh.it> <6uDQb-8e8-9@gated-at.bofh.it> <6uDQb-8e8-13@gated-at.bofh.it> <6uE9y-d1-1@gated-at.bofh.it> <6uPom-87W-23@gated-at.bofh.it>
            <E1Fxk0v-0000gC-Qk@be1.lrz>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1152027175_4949P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 04 Jul 2006 11:32:55 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1152027175_4949P
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Tue, 04 Jul 2006 14:28:05 +0200, Bodo Eggert said:
> BTW: If you're using the trashcan on linked files, you will need to sto=
re
> multiple sources for an inode.

No, if it's a multiply linked file, you want all unlinks except the last
to operate the way they always have, and only the LAST link moves to the
trashcan.

Otherwise, if you have a file with two links, and one moves to the trashc=
an,
it's then subject to reaping and overwriting - which will come as a great=

surprise to the still-existing link....

--==_Exmh_1152027175_4949P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEqooncC3lWbTT17ARAnt/AKCQ9QjVCe0+E6ij5HiMinfPn0rJUgCg/BO3
gm/GwTlZptzaHiCT4sMlaAU=
=wFgE
-----END PGP SIGNATURE-----

--==_Exmh_1152027175_4949P--
