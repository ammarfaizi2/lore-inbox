Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269188AbUIBVhp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269188AbUIBVhp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 17:37:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269175AbUIBVhm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 17:37:42 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:51426 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S269172AbUIBVdn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 17:33:43 -0400
Message-Id: <200409022133.i82LXc38022679@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 07/26/2004 with nmh-1.1-RC3
To: "Wise, Jeremey" <jeremey.wise@agilysys.com>
Cc: Oliver Hunt <oliverhunt@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Kernel or Grub bug. 
In-Reply-To: Your message of "Wed, 01 Sep 2004 15:40:12 EDT."
             <1094067612.15795.19.camel@wizej.agilysys.com> 
From: Valdis.Kletnieks@vt.edu
References: <1094008341.4704.32.camel@wizej.agilysys.com> <200408312358.08153.dsteven3@maine.rr.com> <1094041227.4635.7.camel@wizej.agilysys.com> <200409011135.36537.dsteven3@maine.rr.com> <1094055985.4635.44.camel@wizej.agilysys.com> <4699bb7b04090109415f64fea1@mail.gmail.com>
            <1094067612.15795.19.camel@wizej.agilysys.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1123080636P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 02 Sep 2004 17:33:38 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1123080636P
Content-Type: text/plain; charset=us-ascii

On Wed, 01 Sep 2004 15:40:12 EDT, "Wise, Jeremey" said:

> 2) If I choose to compile the kernel with reiserfs as a modules (ie not
> monolithicaly  in the kernel) then I will have issues as the kernel has
> to have the driver reiserfs to mount the root file system to be able to
> load /lib/modules/..../reiserfs.ko. If this is what you meant then
> again, I am a bit confused. I thought that was the whole point of the
> initrd image in that those modules (RAID, FC, USB, Network
> etc....)required to get the OS to the state that it has a / they must be
> compiled in the initrd which is called and referaned in grub or lilo.
> Again, please correct me if I am wrong.

A somewhat subtle gotcha that I got bit by once - very bad things
happen if you try to load reiserfs off an ext2-formatted initrd image,
and your kernel doesn't have ext2 built in.  (Feel free to substitute
any 2 filesystem formats - I actually got nailed by ext2/ext3)...

--==_Exmh_1123080636P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBN5GycC3lWbTT17ARAtagAKCndHf6YtnXHyQS0RTC4CQClxn29gCglXUQ
5A3dOQK1bDXpX4E4TzC6HGg=
=UuM3
-----END PGP SIGNATURE-----

--==_Exmh_1123080636P--
