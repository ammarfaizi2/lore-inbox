Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266735AbSKWA1Y>; Fri, 22 Nov 2002 19:27:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266736AbSKWA1X>; Fri, 22 Nov 2002 19:27:23 -0500
Received: from Hell.WH8.tu-dresden.de ([141.30.225.3]:46996 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S266735AbSKWA1W>; Fri, 22 Nov 2002 19:27:22 -0500
Date: Sat, 23 Nov 2002 01:34:28 +0100
From: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux v2.5.49
Message-Id: <20021123013428.6d7a9549.us15@os.inf.tu-dresden.de>
In-Reply-To: <Pine.LNX.4.44.0211221351040.1763-100000@penguin.transmeta.com>
References: <Pine.LNX.4.44.0211221351040.1763-100000@penguin.transmeta.com>
Organization: Disorganized
X-Mailer: Sylpheed version 0.8.5claws179 (GTK+ 1.2.10; Linux 2.5.49)
X-GPG-Key: 1024D/233B9D29 (wwwkeys.pgp.net)
X-GPG-Fingerprint: CE1F 5FDD 3C01 BE51 2106 292E 9E14 735D 233B 9D29
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.DkBWcU,'+OoNGv"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.DkBWcU,'+OoNGv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Nov 2002 13:55:08 -0800 (PST) Linus Torvalds (LT) wrote:

LT> Summary of changes from v2.5.48 to v2.5.49
LT> ============================================

[...]

Hello,

Someone already reported the problem for 2.5.48, and it's still present in
2.5.49:

SCSI subsystem driver Revision: 1.00
ERROR: SCSI host `ide-scsi' has no error handling
ERROR: This is not a safe way to run your SCSI host
ERROR: The error handling must be added to this driver
Call Trace:
 [<c026e193>] scsi_register+0x2e3/0x2f0
 [<c0210aff>] bus_add_driver+0xaf/0xd0
 [<c0275882>] idescsi_detect+0x22/0x80
 [<c026e1d3>] scsi_register_host+0x33/0xd0
 [<c010507a>] init+0x3a/0x160
 [<c0105040>] init+0x0/0x160
 [<c010713d>] kernel_thread_helper+0x5/0x18


Regards,
-Udo.

--=.DkBWcU,'+OoNGv
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE93s0XnhRzXSM7nSkRAoROAJ95gyarovTntg+dPDis9wYWbpBDSQCfWt8r
jAaRKMDLNNQIxvsx2gHVBo8=
=jHw0
-----END PGP SIGNATURE-----

--=.DkBWcU,'+OoNGv--
