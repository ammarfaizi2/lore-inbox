Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261208AbTCNWdS>; Fri, 14 Mar 2003 17:33:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261211AbTCNWdS>; Fri, 14 Mar 2003 17:33:18 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:31112 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S261208AbTCNWdQ>; Fri, 14 Mar 2003 17:33:16 -0500
Message-Id: <200303142244.h2EMi0b4025022@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.2 03/12/2003 with nmh-1.0.4+dev
To: Ducrot Bruno <poup@poupinou.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5 XFree and nvidia geforce. 
In-Reply-To: Your message of "Fri, 14 Mar 2003 20:40:50 +0100."
             <20030314194050.GA8814@poup.poupinou.org> 
From: Valdis.Kletnieks@vt.edu
References: <3E70086B.6080408@lemur.sytes.net> <20030313201624.GA29107@suse.de> <Pine.LNX.4.51.0303132026210.24455@dns.toxicfilms.tv> <20030313231615.07563914.bonganilinux@mweb.co.za> <200303132155.h2DLtsRU015899@turing-police.cc.vt.edu>
            <20030314194050.GA8814@poup.poupinou.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-666817280P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 14 Mar 2003 17:44:00 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-666817280P
Content-Type: text/plain; charset=us-ascii

On Fri, 14 Mar 2003 20:40:50 +0100, Ducrot Bruno said:

> One of the main issue for me (I don't want flame please) is
> that it kill acpi and/or apm.  Since it's more important for
> for me to get suspension working, I can not use any
>  drivers provided by nVidia unless of course they implement

No flames intended - I just have different requirements than you do,
and suspending hasn't been an issue for me, and I've not bothered
trying to get it to work.

I've seen a workaround posted for the nvidia suspend issue - the trick was to
configure a suspend script that apmd/whatever would call, and include
a '/usr/bin/chvt 1' in it.  So on the way down, it would change off the
nvidia-controlled VT, and all would be well.

> BTW, XFree4.3.0 is out, and your GeForce is supported.

Oh, the free driver has "supported" the card for ages.  My point was that (a)
the free driver isn't 2-d accelerated as much as the NVidia driver (the 'nv'
free driver can average 10-15% CPU by itself, and the 'nvidia' closed driver
only 1-2% while feeling much quicker), and (b) the NVidia driver "just works"
in finding the video port on the docking station when I'm docked - the 'nv'
free drivers would find the LCD screen fine and not find the docking port
video.

-- 
				Valdis Kletnieks
				Computer Systems Senior Engineer
				Virginia Tech


--==_Exmh_-666817280P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+clsvcC3lWbTT17ARAu7hAKDzXWlH13r8Rm1dNLTcnQ+rl/n6IgCgxv5e
8bEFzRXEZ2q/DykSZFZ4Dt0=
=Tbrs
-----END PGP SIGNATURE-----

--==_Exmh_-666817280P--
