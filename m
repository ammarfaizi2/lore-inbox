Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261799AbTJRTmj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 15:42:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261801AbTJRTmj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 15:42:39 -0400
Received: from h80ad2667.async.vt.edu ([128.173.38.103]:6806 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261799AbTJRTm2 (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 15:42:28 -0400
Message-Id: <200310181941.h9IJfhLW030128@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Witold Krecicki <adasi@kernel.pl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: initrd and 2.6.0-test8 
In-Reply-To: Your message of "Sat, 18 Oct 2003 20:02:15 +0200."
             <200310182002.15787.adasi@kernel.pl> 
From: Valdis.Kletnieks@vt.edu
References: <200310182002.15787.adasi@kernel.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1824489159P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sat, 18 Oct 2003 15:41:43 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1824489159P
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Sat, 18 Oct 2003 20:02:15 +0200, Witold Krecicki <adasi@kernel.pl>  sa=
id:

> But do you have HDD-controller parts as modules or built-in? According =
to the
> changelog message, if initrd is detected as 'usual initrd' (e.g. not
> initramfs), then it's copied to /dev/initrd on rootfs. But as I underst=
and,
> there is no such thing as rootfs as long as it isn't mounted (ide/scsi
> modules are not loaded

What happens in the case of a devfs-based system where the real rootfs
can't be mounted till after the initrd is loaded, because / is on an LVM
volume?  I know my laptop crashed-and-burned on this, even though the IDE=

and LVM modules were built into the kernel....

--==_Exmh_-1824489159P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/kZd3cC3lWbTT17ARAgv+AJ9AV18SMb5+nXkbr3+esZ3+lQjpywCffDRQ
GTKBnNqcCq24qpiAy2rq63w=
=p5eo
-----END PGP SIGNATURE-----

--==_Exmh_-1824489159P--
