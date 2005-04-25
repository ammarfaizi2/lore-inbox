Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262667AbVDYQkQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262667AbVDYQkQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 12:40:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262660AbVDYQiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 12:38:50 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:7694 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S262634AbVDYQga (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 12:36:30 -0400
Message-Id: <200504251636.j3PGa9SJ015388@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Takashi Ikebe <ikebe.takashi@lab.ntt.co.jp>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@muc.de>
Subject: Re: [PATCH x86_64] Live Patching Function on 2.6.11.7 
In-Reply-To: Your message of "Mon, 25 Apr 2005 19:39:51 +0900."
             <426CC8F7.8070905@lab.ntt.co.jp> 
From: Valdis.Kletnieks@vt.edu
References: <4263275A.2020405@lab.ntt.co.jp> <m1y8b9xyaw.fsf@muc.de> <426C51C4.9040902@lab.ntt.co.jp> <e83d0cb60cb50a56b38294e9160d7712@mac.com>
            <426CC8F7.8070905@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1114446969_5553P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 25 Apr 2005 12:36:09 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1114446969_5553P
Content-Type: text/plain; charset=us-ascii

On Mon, 25 Apr 2005 19:39:51 +0900, Takashi Ikebe said:

> Unfortunately, we carrier have very many exiting software and try to run
> on Linux.
> We need to seek the way which can apply to exiting software also...

You *really* want to take the time to re-write the software to do things
The Linux Way.  If you're looking at doing on-the-fly patching, you're
probably also carrying around a lot of *other* ugly cruft to make this
creeping horror work on Linux.  In fact, I'd not be surprised if you have
a shim layer to make the compatibility layer for the *previous* system
work on Linux...

I'm reminded of a (possibly apocryphal) quote from an ATT spokesperson from
1988 or so, when a misplaced comma in a patch kept crashing the long-distance
phone network. When asked "Why don't you just reboot the affected switches?"
his response was "This assumes that the switch had ever been booted in the
first place". (Apparently, the *whole thing* had been on-the-fly replaced/patched
without an actual reload happening...)

Gaaahhh! :)


--==_Exmh_1114446969_5553P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCbRx5cC3lWbTT17ARAlwMAJ9BEFa3mragFy+KgqwOuSAg0A41/QCeMB87
M0aqxAoX1kIzcSMqOcWpESs=
=n9QU
-----END PGP SIGNATURE-----

--==_Exmh_1114446969_5553P--
