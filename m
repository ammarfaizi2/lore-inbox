Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262802AbTKCUEX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 15:04:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262864AbTKCUEX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 15:04:23 -0500
Received: from h80ad25b7.async.vt.edu ([128.173.37.183]:13460 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S262802AbTKCUEJ (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 15:04:09 -0500
Message-Id: <200311032003.hA3K3tgv017273@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Tomas Szepe <szepe@pinerecords.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: how to restart userland? 
In-Reply-To: Your message of "Mon, 03 Nov 2003 20:39:40 +0100."
             <20031103193940.GA16820@louise.pinerecords.com> 
From: Valdis.Kletnieks@vt.edu
References: <20031103193940.GA16820@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-679395698P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 03 Nov 2003 15:03:55 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-679395698P
Content-Type: text/plain; charset=us-ascii

On Mon, 03 Nov 2003 20:39:40 +0100, Tomas Szepe <szepe@pinerecords.com>  said:
> Would anyone know of a proven way to completely restart the userland
> of a Linux system?

This would be distinct from 'shutdown -r' how?  Is there a reason you
want to "completely" restart userland and *not* reboot (for instance,
wanting to keep existing mounts, etc)?

A case could be made that for a "complete" restart, you need to trash
those mounts too (if you're restarting to get a 'clean' setup, you want
to actually be clean), and so forth.

--==_Exmh_-679395698P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/prSqcC3lWbTT17ARAv/WAJ9CRz76PcQtCBPr0o5p0xokUtlJGgCgv9Wp
51QRdJomGz6PRmqg5jYLngU=
=u3y8
-----END PGP SIGNATURE-----

--==_Exmh_-679395698P--
