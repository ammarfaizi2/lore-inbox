Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932509AbWFHAaI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932509AbWFHAaI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 20:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932511AbWFHAaI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 20:30:08 -0400
Received: from rwcrmhc12.comcast.net ([204.127.192.82]:62436 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S932508AbWFHAaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 20:30:06 -0400
Message-ID: <44876E33.6020602@comcast.net>
Date: Wed, 07 Jun 2006 20:24:19 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Thunderbird 1.5.0.2 (X11/20060522)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PAGE_ALIGN()
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

PAGE_ALIGN() seems to be... exactly the same everywhere.

Does anyone else think it should be moved out of asm-*/page.h and into
asm-generic?  I'm thinking stick an #ifndef PAGE_ALIGN() around it in
case (for some reason) it ever changes...?  Or we can just worry about
that when we come to it.

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

    Creative brains are a valuable, limited resource. They shouldn't be
    wasted on re-inventing the wheel when there are so many fascinating
    new problems waiting out there.
                                                 -- Eric Steven Raymond

    We will enslave their women, eat their children and rape their
    cattle!
                  -- Bosc, Evil alien overlord from the fifth dimension
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIVAwUBRIduMQs1xW0HCTEFAQKtShAAjks7GnkN9gS1HjqjH2A9in71QTbv188H
v+uE/DlTlnv31yOazmY3RhwBu2nwzmigX4bpZLfpJsC89bb0zwpgem5drjVMrBXS
4iYuQ4u28tIK0+qfRBlderJ1baNtpGBtg0kmiZGskClarfUeerfoZdjPKIPe0DdP
48k5N+/B1RsIjxtsc9IvTzJaEDYHELA36NBVoa7wS6C56o+Chr1uPa1AnSqHJ7OL
7+lRXsDqlo3KVI9FPlgWl6+6us20nF411N1mbuFJpuw4ixhuzmTPgn53gQagzNUV
hZO2XVxmQU5FEXCt+VxbkZw1PaDkKMIv5GGLSyXded5LCVi10b5Iuc0KKAvSr2Kf
8u1mJ0E/7sWzcrmwxrjzNYpVABGNY73SWFq2w5n8PxHtwRhZAwE1F1XRS13ntue9
Jq6JLhMQRka7Wui9UkdOg278+Ow9ipUwRiNE2GemVjIV6nzVRbhRr/jUBqg3Bdxs
J+r5DbYvEx3qB/3g2Tsj1UmWML+f2PJK4nv9MQSr3yINg7sBGq/YH2a4pbvs3QLA
foQYcdelczgX4Yxev1LoQh9KjhrieSBPaC3Y7H5JShfOPu+GaLfgE8B4YgRGgqvJ
ImxE0Wd1p1XFuyAPNMQruHqfGT29pZEcJi4OuoXrDUImd/rSMALL/cz03lbmqn+d
gUVSMOy2qFs=
=zyZS
-----END PGP SIGNATURE-----
