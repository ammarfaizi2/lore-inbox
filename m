Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264321AbUBHSxa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 13:53:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264361AbUBHSxa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 13:53:30 -0500
Received: from h80ad2602.async.vt.edu ([128.173.38.2]:16262 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S264321AbUBHSx2 (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 13:53:28 -0500
Message-Id: <200402081853.i18IrLtd030471@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: "Vijolicni.oblak" <un.info@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Improved file handling mechanisms for 64-bit architectures 
In-Reply-To: Your message of "Sun, 08 Feb 2004 19:37:45 +0100."
             <001b01c3ee72$a5d5a3b0$0301a8c0@mojeime> 
From: Valdis.Kletnieks@vt.edu
References: <001b01c3ee72$a5d5a3b0$0301a8c0@mojeime>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1486834975P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 08 Feb 2004 13:53:21 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1486834975P
Content-Type: text/plain; charset=us-ascii

On Sun, 08 Feb 2004 19:37:45 +0100, "Vijolicni.oblak" <un.info@gmx.net>  said:

> I will make a suggestion on how to improve file handling performance:

> With AMD64 you are able to make 48-bit addresses, which amount to 256000
> gigabytes of virtual memory. When working with large (eg. 10GB) video or
> database files, Linux kernel could map the whole file into the virtual
> memory using processor's Page Translation Mechanism.
> 
> Those 10GB would then be mapped to a certain memory range. If a portion of
> file that is currently requested is in physical RAM the processor would
> handle it without OS intervention; if not, then a page fault (#PF, 14)
> exception would occur and read a missing page (a missing portion of file).
> 
> 
> 
> The application would see the file as a 10GB large array (or a string), or
> perhaps could map its own data structures into this memory space.

Congratulations... You've re-invented IBM's S/38 and AS/400 architecture. ;)

http://pages.sbcglobal.net/vleveque/AS400_Arch.doc

--==_Exmh_-1486834975P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAJoWhcC3lWbTT17ARAtnhAJ9m9SOHvry5D0I5018YCQpeBb6LYACgxLaW
IC4cbx+T27mYe70hMUMYvEU=
=/sNj
-----END PGP SIGNATURE-----

--==_Exmh_-1486834975P--
