Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQKTAFK>; Sun, 19 Nov 2000 19:05:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129807AbQKTAFB>; Sun, 19 Nov 2000 19:05:01 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:21509 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S129183AbQKTAEy>; Sun, 19 Nov 2000 19:04:54 -0500
Date: Sun, 19 Nov 2000 23:34:50 +0000
From: Tim Waugh <twaugh@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.0-test11-pre7: isapnp hang
Message-ID: <20001119233450.H20970@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="xHbokkKX1kTiQeDC"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--xHbokkKX1kTiQeDC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Reading from port 0x313 (my ISA NE2000 is at 0x300-0x31f) hangs my
machine dead.  Unfortunately, reading from that port is exactly what
the isapnp code does on boot, if compiled into the kernel.

Is it the network card's fault (probably), or is there a less invasive
probe that isapnp could use (unlikely, I guess)?

Tim.
*/

--xHbokkKX1kTiQeDC
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6GGOZONXnILZ4yVIRAm9dAJ43+odSrZBkSH/QpZPYtDuBceHb1ACfUhIw
ZwSlHkkq07y5TyRz2VCLQHA=
=JUlb
-----END PGP SIGNATURE-----

--xHbokkKX1kTiQeDC--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
