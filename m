Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261329AbULAQsh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261329AbULAQsh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 11:48:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261328AbULAQsh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 11:48:37 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:35515 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261359AbULAQs0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 11:48:26 -0500
Message-Id: <200412011648.iB1GmJ7P020934@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 10/11/2004 with nmh-1.1-RC3
To: John Que <qwejohn@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: intird.img file missing - cannot boot. 
In-Reply-To: Your message of "Wed, 01 Dec 2004 17:18:22 +0200."
             <BAY14-F2141AE33478CA464C1B3C7AFBF0@phx.gbl> 
From: Valdis.Kletnieks@vt.edu
References: <BAY14-F2141AE33478CA464C1B3C7AFBF0@phx.gbl>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1967147141P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 01 Dec 2004 11:48:19 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1967147141P
Content-Type: text/plain; charset=us-ascii

On Wed, 01 Dec 2004 17:18:22 +0200, John Que said:

> I use this intird-2.6.7.img image in boot (ext3 is not part of the kernel 
> image).
> (I am working with Fedora with 2.6.7 , and with grub).

So use 'grub' to change the initrd line - use the arrow keys to select
the kernel you want to boot, hit 'e' for edit, then use the arrow keys
to select the initrd line, hit 'e' again, edit the line, then boot with
the edited line.

Not a kernel problem as long as there's a usable kernel/initrd *somewhere*
on your /boot.  Now, if the kernel ate the filesystem and lost your initrd,
*that* would be a different story....

--==_Exmh_1967147141P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBrfXScC3lWbTT17ARAns1AKCxbmr7JMplKTVP/ngnY1ZdMEHXcQCfZ4OH
iSTDPfnLGNfwvmAdMxtyZpA=
=ERqK
-----END PGP SIGNATURE-----

--==_Exmh_1967147141P--
