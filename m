Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262192AbTJOBZX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 21:25:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262232AbTJOBZX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 21:25:23 -0400
Received: from h80ad24f4.async.vt.edu ([128.173.36.244]:10624 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S262192AbTJOBZV (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 21:25:21 -0400
Message-Id: <200310150125.h9F1PJjO005719@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Max Valdez <maxvaldez@yahoo.com>
Cc: kernel <linux-kernel@vger.kernel.org>
Subject: Re: nvidia.o on 2.4.22/2.6.0 ?? 
In-Reply-To: Your message of "Wed, 15 Oct 2003 00:33:30 -0000."
             <1066178010.14217.3.camel@garaged.fis.unam.mx> 
From: Valdis.Kletnieks@vt.edu
References: <1066178010.14217.3.camel@garaged.fis.unam.mx>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-2103173083P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 14 Oct 2003 21:25:19 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-2103173083P
Content-Type: text/plain; charset=us-ascii

On Wed, 15 Oct 2003 00:33:30 -0000, Max Valdez <maxvaldez@yahoo.com>  said:

> Have anyone made a successful run of X with nvidia (closes source)
> module ??, I have a TNT2 running on a 2.4.20-gentoo-r7 kernel, but when
> I try to run X on 2.4.22* or 2.6.0* I alway get an error about my screen
> and /dev/nvidia0.

1) Get the 4496 drivers from NVidia, use "--extract-only" to get the pieces out.
2) Surf over to http://www.minion.de/nvidia and pick up the patch.  Apply
it in the NVIDIA-Linux-x86-1.0-4496-pkg2/usr/src/nv directory. While booted
to -test7, 'cp Makefile.kbuild Makefile' and then 'make'.  

(I posted more detailed directions a while ago, they should be in the list archives)

It would certainly help if you were more specific about "get an error about
my screen and /dev/nvidia0".

--==_Exmh_-2103173083P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/jKH+cC3lWbTT17ARArIgAJsErTuLHaz6zw2ksjBFB1cjzm5pUACdGh5L
d1CxeqbxDGDjt8LVqae23Oc=
=ht1w
-----END PGP SIGNATURE-----

--==_Exmh_-2103173083P--
