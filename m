Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271098AbTGPUSu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 16:18:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271104AbTGPUSu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 16:18:50 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:7554 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S271098AbTGPUSi (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 16:18:38 -0400
Message-Id: <200307162033.h6GKXTup002619@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: "David St.Clair" <dstclair@cs.wcu.edu>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test1 Vesa fb and Nvidia 
In-Reply-To: Your message of "Wed, 16 Jul 2003 16:13:16 EDT."
             <1058386396.3710.4.camel@localhost> 
From: Valdis.Kletnieks@vt.edu
References: <1058386396.3710.4.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-850428676P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 16 Jul 2003 16:33:29 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-850428676P
Content-Type: text/plain; charset=us-ascii

On Wed, 16 Jul 2003 16:13:16 EDT, "David St.Clair" <dstclair@cs.wcu.edu>  said:
> I don't know if this is a hardware specific bug or I just don't have
> something configured right.

2.6.0-test1-mm1, Dell C840 laptop with a Geforce4 440Go.

I do *NOT* have 'CONFIG_FB_VGA16' set, but *do* have 'CONFIG_VIDEO_VESA'.

With this, 'vga=794' gets me a small font and a penguin on boot,
the NVidia binary driver works fine under X  after the minion.de patch,
switching back and forth works well, and life is generally good.

Mode 792 is in the VESA bios mode range: from Documentation/svga.txt:

   0x0200 to 0x08ff - VESA BIOS modes. The ID is a VESA mode ID increased by
        0x0100. All VESA modes should be autodetected and shown on the menu.
....
   CONFIG_VIDEO_VESA - enables autodetection of VESA modes. If it doesn't work
on your machine (or displays a "Error: Scanning of VESA modes failed" message),
you can switch it off and report as a bug.

Try turning that on?


--==_Exmh_-850428676P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/FbaZcC3lWbTT17ARAgLZAJ4/uG+d6IlSu4WSghO++r3Iw9VM3ACghMoU
6nTg+jvJbmDwvjKfd02aVwA=
=8YcA
-----END PGP SIGNATURE-----

--==_Exmh_-850428676P--
