Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291316AbSBMClK>; Tue, 12 Feb 2002 21:41:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291312AbSBMClB>; Tue, 12 Feb 2002 21:41:01 -0500
Received: from sphere.open-net.org ([64.53.98.77]:23175 "HELO pbx.open-net.org")
	by vger.kernel.org with SMTP id <S291316AbSBMCko>;
	Tue, 12 Feb 2002 21:40:44 -0500
Date: Tue, 12 Feb 2002 21:40:16 -0500
From: Robert Jameson <rj@open-net.org>
To: linux-kernel@vger.kernel.org
Subject: unresolved symbols ipt_owner.o with 2.4.18-pre9 with mjc patch
Message-Id: <20020212214016.7fa188c3.rj@open-net.org>
X-Mailer: Sylpheed version 0.7.1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="=.19ht44sJTlMjoU"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.19ht44sJTlMjoU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Is there a fix for the unresolved symbols with ipt_owner.o with
2.4.18-pre9 + mjc's patch, i don't know if this is 2.4.18-pre9 specific or
if its a mjc error, either way, heres the error,

/lib/modules/2.4.18-pre9-mjc/kernel/net/ipv4/netfilter/ipt_owner.o:
unresolved symbol
pidhash_bits/lib/modules/2.4.18-pre9-mjc/kernel/net/ipv4/netfilter/ipt_ow
ner.o: unresolved symbol
pidhash_size/lib/modules/2.4.18-pre9-mjc/kernel/net/ipv4/netfilter/ipt_ow
ner.o: insmod
/lib/modules/2.4.18-pre9-mjc/kernel/net/ipv4/netfilter/ipt_owner.o
failed/lib/modules/2.4.18-pre9-mjc/kernel/net/ipv4/netfilter/ipt_owner.o:
insmod ipt_owner failed

on a side note, i also noticed the following,

depmod -a

depmod: *** Unresolved symbols in
/lib/modules/2.4.18-pre9-mjc/kernel/drivers/net/acenic.o depmod: ***
Unresolved symbols in
/lib/modules/2.4.18-pre9-mjc/kernel/drivers/net/wan/comx.o

-- 
Robert Jameson                  http://rj.open-net.org
C2 Village at Wexford Hwy 278,  Tel: +1 (843) 757 9428
Hilton Head Isl, SC             Cel: +1 (843) 298 0957 
US, 29928.                      mailto:rj@open-net.org


--=.19ht44sJTlMjoU
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iD8DBQE8adITyWZRCCLwK/cRAkNmAJ9YBCFalshKMtfJvlRmC/cshDWSiQCeJcfQ
jH5CVoylptgb0tRFKRMorks=
=qq5h
-----END PGP SIGNATURE-----

--=.19ht44sJTlMjoU--

