Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262666AbTIQCsr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 22:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262670AbTIQCsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 22:48:47 -0400
Received: from 200-63-155-39.speedy.com.ar ([200.63.155.39]:20354 "EHLO
	runa.sytes.net") by vger.kernel.org with ESMTP id S262666AbTIQCsp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 22:48:45 -0400
Date: Tue, 16 Sep 2003 23:49:49 -0300
From: Martin Sarsale <runa@runa.sytes.net>
To: linux-kernel@vger.kernel.org
Subject: apache: page allocation failure. order:0, mode:0xd2
Message-Id: <20030916234949.3b9784a1.runa@runa.sytes.net>
X-Mailer: Sylpheed version 0.9.3 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.xBI7G/nSAAp4xb"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.xBI7G/nSAAp4xb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Dear all: Im running 2.6.0-test4 here and today I started experiencing some weird behaviour: from time to time the system freezes for some minutes. When I gain the control back, running top shows 400mb/ram free but running dmesg I some "out of memory" messages. I was playing with some hardware in the weekend so Im not sure if this is a hardware failure. I'll do some other experiments (running memtest, etc) and I'll clarify if it's a hardware issue.
Some dmesg messages:

Out of Memory: Killed process 565 (xmule).
Out of Memory: Killed process 474 (apache).
Out of Memory: Killed process 727 (apache).
Out of Memory: Killed process 473 (apache).
Out of Memory: Killed process 726 (apache).
Out of Memory: Killed process 457 (apache).
Out of Memory: Killed process 3082 (apache).
Out of Memory: Killed process 2880 (xmule).
apache: page allocation failure. order:0, mode:0xd2
VM: killing process apache


thanks in advance

-- 
you can find my public PGP/GPG key at http://www.n3rds.com.ar/files/martin_sarsale.key

--=.xBI7G/nSAAp4xb
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/Z8vWhruVGj+ub3MRAqL/AKDLiFjKFKf4PQKVCuvv48/TQrBo5ACdH3IL
lAEvVDViTaFpdoEA/gfM3cw=
=v1gT
-----END PGP SIGNATURE-----

--=.xBI7G/nSAAp4xb--
