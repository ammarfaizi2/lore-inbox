Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262458AbTK2FiQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Nov 2003 00:38:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263650AbTK2FiQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Nov 2003 00:38:16 -0500
Received: from h80ad279a.async.vt.edu ([128.173.39.154]:9121 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S262458AbTK2FiP (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sat, 29 Nov 2003 00:38:15 -0500
Message-Id: <200311290538.hAT5c702013700@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: John Zielinski <grim@undead.cc>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Rootfs mounted from user space - problem with umount 
In-Reply-To: Your message of "Sat, 29 Nov 2003 00:24:31 EST."
             <3FC82D8F.9030100@undead.cc> 
From: Valdis.Kletnieks@vt.edu
References: <3FC82D8F.9030100@undead.cc>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-30935206P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sat, 29 Nov 2003 00:38:07 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-30935206P
Content-Type: text/plain; charset=us-ascii

On Sat, 29 Nov 2003 00:24:31 EST, John Zielinski <grim@undead.cc>  said:

> +	  This option switches rootfs so that it uses tmpfs rather than ramfs
> +	  for it's file storage.  This makes rootfs swappable so having a large
> +	  initrd or initramfs image won't eat up valuable RAM.

I'm missing something - why not use an initrd and pivot_root and then
unmount the old root?  Seems to work here.

--==_Exmh_-30935206P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/yDC/cC3lWbTT17ARAnuEAJ9BK8d9wAGg+qJCcE5Y2wI2r4w9fACfRW1d
M8iKdS1b6uQqtUOK+1CIXwQ=
=AxFd
-----END PGP SIGNATURE-----

--==_Exmh_-30935206P--
