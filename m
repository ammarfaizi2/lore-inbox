Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264502AbTLGULF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 15:11:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264504AbTLGULF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 15:11:05 -0500
Received: from quake.mweb.co.za ([196.2.45.76]:14018 "EHLO quake.mweb.co.za")
	by vger.kernel.org with ESMTP id S264502AbTLGULB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 15:11:01 -0500
Date: Sun, 7 Dec 2003 22:13:28 +0200
From: Bongani Hlope <bonganilinux@mweb.co.za>
To: Lee <weifeil@usc.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM:can't load module "ide-cd" automatically(2.6.0-test10)
Message-Id: <20031207221328.4220ea00.bonganilinux@mweb.co.za>
In-Reply-To: <009d01c3bcfa$e409a8b0$0300a8c0@tiger>
References: <009d01c3bcfa$e409a8b0$0300a8c0@tiger>
X-Mailer: Sylpheed version 0.9.6claws (GTK+ 1.2.10; i586-mandrake-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Sun__7_Dec_2003_22_13_28_+0200_fAlgKszgfsgFxRVQ"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Sun__7_Dec_2003_22_13_28_+0200_fAlgKszgfsgFxRVQ
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Sun, 07 Dec 2003 11:47:03 -0800
Lee <weifeil@usc.edu> wrote:

> 1. Under kernel 2.6.0-test10, I can't load module "ide-cd" automatically.
> 2. Unlike under 2.4.x kernel, I must load "cdrom" and "ide-cd" module by
> hand or use shell scripts to do it under 2.6.0-test10 kernel, although I
> didn't change  .config file. If I want to mount my cdrom disk without
> loading these modules, it always tells me that " mount:/dev/cdrom is not a
> valid block device".
> 3. Keyword: module, ide-cd

8<

> 7.6. SCSI information: No such file or directory as /proc/scsi
> 
> That's   all,
> Thanks a lot!
> Weifei

Take a look at /etc/modprobe.preload

--Signature=_Sun__7_Dec_2003_22_13_28_+0200_fAlgKszgfsgFxRVQ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/04n0+pvEqv8+FEMRAr2EAJwOXurl4rV12u80XlEARfh5QDnW+wCbB9OI
ADZcQpFlGYlzLqTVN/aVnnI=
=jNij
-----END PGP SIGNATURE-----

--Signature=_Sun__7_Dec_2003_22_13_28_+0200_fAlgKszgfsgFxRVQ--
