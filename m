Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129319AbRCBRFW>; Fri, 2 Mar 2001 12:05:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129324AbRCBRFN>; Fri, 2 Mar 2001 12:05:13 -0500
Received: from mask.uits.indiana.edu ([129.79.6.184]:55819 "EHLO
	mask.uits.indiana.edu") by vger.kernel.org with ESMTP
	id <S129319AbRCBRFA>; Fri, 2 Mar 2001 12:05:00 -0500
Date: Fri, 2 Mar 2001 12:04:59 -0500
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.2 Kernel bug in page_alloc:75
Message-ID: <20010302120458.A1013@indiana.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
From: "Scott G. Miller" <scgmille@indiana.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linux 2.4.2 SMP Kernel died while I was logged in remotely.  When I got
back to the box, the Kernel had spit out a kernel bug.  Here's what I
copied down (didn't get the registers or stack trace, will do if it
happens again):

bug in page_alloc:75
invalid operand: 0000
CPU: 1
EIP: 0010:[<c012d37e>]
Eflags: 00010282
Code: 0f 0b 83 c4 0c 89 d8 2b 05 38 d8 27 c0 69 c0 f1 f0 f0 f0 c1

        Scott

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6n9K6r9IW4v3mHtQRAjFQAJ0bILXu/Dp8GBI0xKPnPIPMHIdkowCfbhvE
0gfYDObu1kqqj22piJKyKLE=
=ysnO
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
