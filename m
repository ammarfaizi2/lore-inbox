Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261916AbTKCEtu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Nov 2003 23:49:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261923AbTKCEtu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Nov 2003 23:49:50 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:57288 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id S261916AbTKCEtr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Nov 2003 23:49:47 -0500
Date: Mon, 3 Nov 2003 05:49:42 +0100
From: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OOPS] Linux-2.6.0-test9
Message-Id: <20031103054942.4d6c985e.us15@os.inf.tu-dresden.de>
In-Reply-To: <Pine.LNX.4.44.0311022042390.18647-100000@home.osdl.org>
References: <20031103045637.7d2acb90.us15@os.inf.tu-dresden.de>
	<Pine.LNX.4.44.0311022042390.18647-100000@home.osdl.org>
Organization: Fiasco Core Team
X-GPG-Key: 1024D/233B9D29 (wwwkeys.pgp.net)
X-GPG-Fingerprint: CE1F 5FDD 3C01 BE51 2106 292E 9E14 735D 233B 9D29
X-Mailer: X-Mailer 5.0 Gold
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Mon__3_Nov_2003_05_49_42_+0100_PRX8seGL5glvcPAW"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Mon__3_Nov_2003_05_49_42_+0100_PRX8seGL5glvcPAW
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Sun, 2 Nov 2003 20:45:55 -0800 (PST) Linus Torvalds (LT) wrote:

LT> Btw, what compiler version do you have? The UP+preempt bug is a real bug,
LT> but as far as I've been able to find out it's almost impossible to get gcc
LT> to actually generate code that might trigger it. So while it's entirely
LT> possible that the bug you're seeing is due to the (now fixed) UP+preempt 
LT> bug, it's also quite possible that there's something else going on too.

I'm using gcc 3.3.2.

Reading specs from /usr/lib/gcc-lib/i486-slackware-linux/3.3.2/specs
Configured with: ../gcc-3.3.2/configure --prefix=/usr --enable-shared
--enable-threads=posix --enable-__cxa_atexit --disable-checking --with-gnu-ld
--verbose --target=i486-slackware-linux --host=i486-slackware-linux
Thread model: posix
gcc version 3.3.2

-Udo.

--Signature=_Mon__3_Nov_2003_05_49_42_+0100_PRX8seGL5glvcPAW
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/pd5mnhRzXSM7nSkRAmL8AJ96JhGGfAG/MD3aX6t4jgOz19+X4wCfbYzL
qwujQoOdF6zJk2Fw+IsG8l0=
=75eK
-----END PGP SIGNATURE-----

--Signature=_Mon__3_Nov_2003_05_49_42_+0100_PRX8seGL5glvcPAW--
