Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261257AbUJYTMd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261257AbUJYTMd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 15:12:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261253AbUJYTMC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 15:12:02 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:2720 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261259AbUJYTFk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 15:05:40 -0400
Message-Id: <200410251905.i9PJ5Rrj013717@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 10/11/2004 with nmh-1.1-RC3
To: Paulo Marques <pmarques@grupopie.com>
Cc: "Nico Augustijn." <kernel@janestarz.com>, hvr@gnu.org,
       clemens@endorphin.org, linux-kernel@vger.kernel.org
Subject: Re: Cryptoloop patch for builtin default passphrase 
In-Reply-To: Your message of "Mon, 25 Oct 2004 19:23:35 BST."
             <417D44A7.2030904@grupopie.com> 
From: Valdis.Kletnieks@vt.edu
References: <200410251354.31226.kernel@janestarz.com> <200410251719.i9PHJmOi009687@turing-police.cc.vt.edu> <417D38F7.1040204@grupopie.com> <200410251754.i9PHsVrI018284@turing-police.cc.vt.edu>
            <417D44A7.2030904@grupopie.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-546293252P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 25 Oct 2004 15:05:27 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-546293252P
Content-Type: text/plain; charset=us-ascii

On Mon, 25 Oct 2004 19:23:35 BST, Paulo Marques said:

> (why would you need confidential information to boot in the first place?)

The problem is not that the info in the NVRAM is "confidential",
but that most of it is "configuration".

Really sucks if you recable your SCSI controllers, the default boot disk
changes from controller 4, device 5, to controller 2, device 3 - and you
have to go and re-cable the OLD way, find the rescue CD, and fix /etc/fstab
so that you can boot in the same config that you installed the software?

Either that, or forever lose the use of "default boot device", and
have to specify it on every single boot if you want the software to work.
That *really* sucks if it's a rack-mount in a colo, you need to get physical
access to reboot....

> No it is not. You would just type in again *if* the contents of nvram 
> got lost which shouldn't happen in the first place (or at least happen 
> rarely).

So you change IRQ9 from level to edge trigger, or change "default boot order"
from "floppy, cd, hard drive" to "floppy, cd, hard drive, network", and
suddenly your software evaporates?

That certainly violates the Principle of Least Surprise, and why I asked
if it was an intended effect.

--==_Exmh_-546293252P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBfU52cC3lWbTT17ARAhgSAJ9f9NLYZ3xPCGmIPey082cyo+zVlACfQ1wK
zhc8KVkeZpcxgTOVs3jE3uw=
=8kIw
-----END PGP SIGNATURE-----

--==_Exmh_-546293252P--
