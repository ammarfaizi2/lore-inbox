Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261613AbULIUsL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261613AbULIUsL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 15:48:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261614AbULIUsL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 15:48:11 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:28839 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261613AbULIUsH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 15:48:07 -0500
Message-Id: <200412092048.iB9Km5gq012308@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 10/11/2004 with nmh-1.1-RC3
To: rich turner <rich@storix.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: initrd and fc3 
In-Reply-To: Your message of "Thu, 09 Dec 2004 11:28:01 PST."
             <1102620480.19320.8.camel@rich> 
From: Valdis.Kletnieks@vt.edu
References: <1102620480.19320.8.camel@rich>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1211351157P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 09 Dec 2004 15:48:05 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1211351157P
Content-Type: text/plain; charset=us-ascii

On Thu, 09 Dec 2004 11:28:01 PST, rich turner said:

(off-list reply)

> upon system boot, the kernel executes, checks to see if the initrd is
> initramfs (it isnt), finds the initrd (ext2), mounts it, and then
> immediately exits without executing linuxrc.

Are you *sure* linuxrc isn't run at all?

You might want to run a test 'mkinitrd' and look at what FC3 expects to find
in there (yes, it generates a cpio archive, just extract it into a scratch
directory), then compare that to your initrd and see if you're missing something
(permissions, a directory, etc).

It's possible that the linuxrc is running, not outputting anything to the
console, and hitting an error that causes further progress to fail, making it
LOOK like it's not running at all.

--==_Exmh_1211351157P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBuLoEcC3lWbTT17ARAimDAJ4nhnio3PfX0/WDSyppMM6JYFEMPACgm0UZ
5xC3jLfb0GFSYsxA59oQt0A=
=VlSr
-----END PGP SIGNATURE-----

--==_Exmh_1211351157P--
