Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265667AbUBBSM3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 13:12:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265768AbUBBSM3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 13:12:29 -0500
Received: from turing-police.cirt.vt.edu ([128.173.54.129]:14212 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S265667AbUBBSM1 (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 13:12:27 -0500
Message-Id: <200402021812.i12IC6eR006637@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Joshua Kwan <joshk@triplehelix.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: 2.6 input drivers FAQ 
In-Reply-To: Your message of "Mon, 02 Feb 2004 10:23:18 +0100."
             <20040202092318.GD548@ucw.cz> 
From: Valdis.Kletnieks@vt.edu
References: <20040201100644.GA2201@ucw.cz> <20040201163136.GF11391@triplehelix.org> <200402020527.i125RvTx008088@turing-police.cc.vt.edu>
            <20040202092318.GD548@ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_826320722P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 02 Feb 2004 13:12:06 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_826320722P
Content-Type: text/plain; charset=us-ascii

On Mon, 02 Feb 2004 10:23:18 +0100, Vojtech Pavlik said:

> Are you sure you don't have the mouse configured twice in XFree86
> config? It's a rather common error.

Section "InputDevice"
        Identifier  "Mouse0"
        Driver      "mouse"
        Option      "Device" "/dev/psaux"
        Option      "Protocol" "ExplorerPS/2"
        Option      "Buttons" "7"
        Option      "Emulate3Buttons" "on"
        Option      "ZAxisMapping" "6 7"
EndSection

And if I *had* gotten it in there twice, why would it only hit sporadically
once or twice a day, as opposed to *all* mouse events (clicks, moves,
etc) being doubled?

--==_Exmh_826320722P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAHpL2cC3lWbTT17ARAo3dAJsGig6LUac9IPAqvCpH+IBSKuyveQCg5SlI
UaSg7uMX7awdYEHAztgrsCU=
=hhuD
-----END PGP SIGNATURE-----

--==_Exmh_826320722P--
