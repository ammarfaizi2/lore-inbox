Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030458AbWAHHqF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030458AbWAHHqF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 02:46:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030464AbWAHHqF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 02:46:05 -0500
Received: from h80ad256a.async.vt.edu ([128.173.37.106]:28613 "EHLO
	h80ad256a.async.vt.edu") by vger.kernel.org with ESMTP
	id S1030458AbWAHHqE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 02:46:04 -0500
Message-Id: <200601080745.k087j3mU016114@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Michael Buesch <mbuesch@freenet.de>, arjan@infradead.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH 1/4] move capable() to capability.h 
In-Reply-To: Your message of "Sat, 07 Jan 2006 21:51:06 PST."
             <20060107215106.38d58bb9.rdunlap@xenotime.net> 
From: Valdis.Kletnieks@vt.edu
References: <1136543825.2940.8.camel@laptopd505.fenrus.org> <200601061218.17369.mbuesch@freenet.de> <1136546539.2940.28.camel@laptopd505.fenrus.org> <200601061226.42416.mbuesch@freenet.de>
            <20060107215106.38d58bb9.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1136706302_32265P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 08 Jan 2006 02:45:02 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1136706302_32265P
Content-Type: text/plain; charset=us-ascii

On Sat, 07 Jan 2006 21:51:06 PST, "Randy.Dunlap" said:

> From: Randy Dunlap <rdunlap@xenotime.net>
> 
> headers + core:
> - Move capable() from sched.h to capability.h;
> - Use <linux/capability.h> where capable() is used
> 	(in include/, block/, ipc/, kernel/, a few drivers/,
> 	mm/, security/, & sound/;
> 	many more drivers/ to go)

Are there plans for a second patch series to remove sched.h from those
files that only needed it for capable()?

--==_Exmh_1136706302_32265P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFDwML+cC3lWbTT17ARAs9MAJ9/kWVOBZCbh0NiezMd2m+JU8MUQACeLm8u
1wJNAJnPCeS0bqP6bxAIKzo=
=OQr0
-----END PGP SIGNATURE-----

--==_Exmh_1136706302_32265P--
