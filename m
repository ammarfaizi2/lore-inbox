Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964993AbWE0VUm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964993AbWE0VUm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 17:20:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964994AbWE0VUm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 17:20:42 -0400
Received: from pool-72-66-202-199.ronkva.east.verizon.net ([72.66.202.199]:15812
	"EHLO turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S964993AbWE0VUl (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 17:20:41 -0400
Message-Id: <200605272120.k4RLKZFi003936@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Andrew Moise <chops@demiurgestudios.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: DMA errors, then I/O errors, on 2.6.16
In-Reply-To: Your message of "Sat, 27 May 2006 17:07:15 EDT."
             <20060527210715.GA2866@qix.demiurgestudios.com>
From: Valdis.Kletnieks@vt.edu
References: <20060527210715.GA2866@qix.demiurgestudios.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1148764835_3209P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sat, 27 May 2006 17:20:35 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1148764835_3209P
Content-Type: text/plain; charset=us-ascii

On Sat, 27 May 2006 17:07:15 EDT, Andrew Moise said:
>   Running 2.6.16 (and some earlier 2.6 kernels as well), I get
> occasional DMA failures, which are always followed by the disk not
> working at all (any request leads to an I/O error).

Have you tried running 'badblocks /dev/hda' under a kernel that is
believe to be working?  That looks more like a drive trying to fail
due to hardware causes than a software problem.....

--==_Exmh_1148764835_3209P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEeMKjcC3lWbTT17ARAjK7AJoDD7U+eS/8stzN11qOsIGYKLjVdACg+5zT
UinC9bNtZENat9TJntZVvc0=
=gVjz
-----END PGP SIGNATURE-----

--==_Exmh_1148764835_3209P--
